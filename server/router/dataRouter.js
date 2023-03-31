const express = require('express');
const router = express.Router();

const serverLogger = require('../helpers/serverLogger');

const jsonController = require('../helpers/jsonController');
const globals = require('../globals');
const dbController = require('../helpers/databaseController');
const genAthToken = require('../helpers/GenerateAuthToken');
const messages = require('../helpers/Messages.json');

const routes = [
    'settings', 'promocodes',
    'contacts', 'comments',
    'images', 'menu',
];

routes.forEach(function(route) {
    router.get(`/${route}/:id`, async function(req, res) {
        try {
            
            let result = await jsonController.readFile(req.params['id']);
            res.send(result[route]);

        } catch (err) {
            serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
            res.send(messages.errors.db.not_found);
        }
    });

    router.post(`/${route}/:id`, async function(req, res) {
        try {

            let uuid = await dbController.selectColumnByColumn({
                search_column: 'UUID',
                column: 'Id',
                column_value: req.params['id'],
                db_path: globals.paths.dbDir + 'main.db',
                table_name: globals.tables.main.main_table,
            })[0].UUID;

            let password = await dbController.selectColumnByColumn({
                search_column: 'password',
                column: 'UUID',
                column_value: uuid,
                db_path: globals.paths.dbDir + 'main.db',
                table_name: globals.tables.main.main_table,
            })[0].password;

            let DateOfCreation = await dbController.selectColumnByColumn({
                search_column: 'time_of_creating',
                column: 'UUID',
                column_value: uuid,
                db_path: globals.paths.dbDir + 'main.db',
                table_name: globals.tables.main.main_table,
            })[0].time_of_creating;

            if (genAthToken.ReadAthToken(req.body.atoken, DateOfCreation) == password) {
                let result = await jsonController.saveFile(uuid, req.body.data, route);
                res.send(result);
            } else {
                res.send("Incorrect password");
            }

        } catch (err) {
            serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
            res.send(messages.errors.db.not_found);
        }
    });
});

module.exports.router = router;