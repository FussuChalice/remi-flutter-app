const express = require('express');
const { paths } = require('../globals');
const router = express.Router();

const dbc = require('../helpers/databaseController');
const { Log, logLevel } = require('../helpers/serverLogger');

router.get('/', async function (req, res) {
    let result = await dbc.getColumnNames(paths.dbDir + 'main.db', "services_passwords");
    Log(result, logLevel.INFO, true);
    res.send(result);
});

module.exports.router = router;