const express = require('express');
const router = express.Router();

const logger = require('../helpers/serverLogger');

const jsonController = require('../helpers/jsonController');
const globals = require('../globals');
const dbController = require('../helpers/databaseController');
const genAthToken = require('../helpers/GenerateAuthToken');
const messages = require('../helpers/Messages.json');

const routes = [
    'settings', 'promocodes',
    'contacts', 'comments',
    'images', 'menu',
    'orders', 'main_image',
];

routes.forEach(function(route) {
    router.get(`/${route}/:id`, async function(req, res) {
        try {
            
            let result = await jsonController.readFile(req.params['id']);
            res.send(result[route]);

        } catch (err) {
            logger.Log(`[${__filename}]: ${err}`, logger.logLevel.ERROR, true);
            res.send(messages.errors.db.not_found);
        }
    });

    router.post(`/${route}/:id`, async function(req, res) {
        try {

            let dbRow = await dbController.getAllByOneColumn("Id", req.params["id"], globals.paths.dbDir + "main.db", globals.tables.main.main_table);
            
            const authToken = genAthToken.ReadAthToken(req.body.atoken.toString(), dbRow[0]["time_of_creating"]);
            if (authToken == dbRow[0]["password"]) {
                let result = await jsonController.saveFile(dbRow[0]["UUID"], req.body.data, route);
                res.send(result);
            } else {
                res.send("Incorrect password");
            }

        } catch (err) {
            logger.Log(`[${__filename}]: ${err}`, logger.logLevel.ERROR, true);
            res.send(messages.errors.db.not_found);
        }
    });
});

router.get('/full/:id', async function (req, res) {
    try {
            
        let result = await jsonController.readFile(req.params['id']);
        res.send(result);

    } catch (err) {
        logger.Log(`[${__filename}]: ${err}`, logger.logLevel.ERROR, true);
        res.send(messages.errors.db.not_found);
    }
});

module.exports.router = router;