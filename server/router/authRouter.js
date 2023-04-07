const express = require('express');
const router = express.Router();

const slog = require('../helpers/serverLogger');
const dbController = require('../helpers/databaseController');
const globals = require('../globals');
const messages = require('../helpers/Messages.json');
const uuid = require('uuid');
const AuthTokenGenerator = require('../helpers/GenerateAuthToken');
const patterns = require('../helpers/patterns');

router.post('/signup', async function(req, res) {
    let USER_DATA = [
        req.body.email,
        req.body.password,
        uuid.v4(),
        slog.getCurrentTimeAndDate().gmt,
    ];

    // console.log(req.body);

    try {
        let existing_check = await dbController.control({
            db_path: globals.paths.dbDir + 'main.db',
            table_name: globals.tables.main.main_table,
            record: [USER_DATA[0]],
            existed: ["email"],
            select: "UUID",
        }, dbController.databaseMethods.CHECK_EXIST);
    
        // console.log(existing_check);
        // console.log(await dbController.isExist(existing_check));
    
        if (await dbController.isExist(existing_check)) {
            res.json({
                status: messages.status.err,
                message: messages.errors.auth.email_is_existed
            });
        } 
        else {
            if (existing_check != 0x1) {
                let data_insert = await dbController.control({
                    db_path: globals.paths.dbDir + 'main.db',
                    table_name: globals.tables.main.main_table,
                    record: USER_DATA, 
                }, dbController.databaseMethods.INSERT);
        
                if (data_insert == 0x1) {
                    res.json({status: messages.status.err, message: messages.errors.db.failed_insert});
                } else {
                    jsonController.create(globals.paths.dbDir + USER_DATA[2], JSON.stringify(patterns.newServiceFilePattern));
                    res.json({
                        status: messages.status.ok,
                        message: messages.success.auth.s_signup,
                        uuid: USER_DATA[2],
                        token: AuthTokenGenerator.GenerateAuthToken(USER_DATA[1], USER_DATA[3]).toString(),
                    });
                }
            }
        }
    } catch (err) {
        slog.Log(`[${__filename}]: ${err}`, slog.logLevel.ERROR, true);
    }

});

router.post('/login', async function (req, res) {
    let USER_DATA_I = [
        req.body.email,
        req.body.password,
    ];

    try {
        let response = await dbController.control({
            db_path: globals.paths.dbDir + 'main.db',
            table_name: globals.tables.main.main_table,
            record: USER_DATA_I,
            existed: ["email", "password"],
            select: "UUID",
        }, dbController.databaseMethods.READ);
    
        if (response[0] == undefined) {
            res.json({
                status: messages.status.err,
                message: messages.errors.auth.incorrect_data
            });
        } else {
            let DateOfCreation = await dbController.control({
                db_path: globals.paths.dbDir + 'main.db',
                table_name: globals.tables.main.main_table,
                record: USER_DATA_I,
                existed: ["email", "password"],
                select: "time_of_creating",
            }, dbController.databaseMethods.READ);
            let timeofC = DateOfCreation[0].time_of_creating;
            slog.Log(timeofC);

            let token = AuthTokenGenerator.GenerateAuthToken(USER_DATA_I[1], timeofC);
            slog.Log(`Generated token: ${token}`, slog.logLevel.INFO, true);

            res.json({
                status: messages.status.ok,
                message: messages.success.auth.s_login,
                uuid: response[0].UUID,
                token: token.toString(),
            });
        }
    } catch (err) {
        slog.Log(`[${__filename}]: ${err}`, slog.logLevel.ERROR, true);
    }
});




module.exports.router = router;