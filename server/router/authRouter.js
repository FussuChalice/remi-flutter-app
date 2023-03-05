const path = require('path');
const express = require('express');
const router = express.Router();

const slog = require('../helpers/serverLogger');
const dbController = require('../helpers/databaseController');
const globals = require('../globals');
const messages = require('../helpers/Messages.json');
const jsonController = require('../helpers/jsonController');
const uuid = require('uuid');

router.post('/signup', async function(req, res) {
    let USER_DATA = [
        req.body.email,
        req.body.password,
        uuid.v4(),
        slog.getCurrentTimeAndDate().gmt,
    ];

    // console.log(req.body);

    let existing_check = await dbController.control({
        db_path: globals.paths.dbDir + 'main.db',
        table_name: "services_passwords",
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
                table_name: "services_passwords",
                record: USER_DATA, 
            }, dbController.databaseMethods.INSERT);
    
            if (data_insert == 0x1) {
                res.json({status: messages.status.err, message: messages.errors.db.failed_insert});
            } else {
                jsonController.create(globals.paths.dbDir + USER_DATA[2], JSON.stringify(globals.newServiceFilePattern));
                res.json({
                    status: messages.status.ok,
                    message: messages.success.auth.s_signup,
                    uuid: USER_DATA[2]
                });
            }
        }
    }

});

router.post('/login', async function (req, res) {
    let USER_DATA_I = [
        req.body.email,
        req.body.password
    ];

    let response = await dbController.control({
        db_path: globals.paths.dbDir + 'main.db',
        table_name: "services_passwords",
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
        res.json({
            status: messages.status.err,
            message: response[0].UUID,
        });
    }
});




module.exports.router = router;