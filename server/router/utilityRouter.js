const express = require('express');
const router = express.Router();

const dbController = require('../helpers/databaseController');
const globals = require('../globals');

router.get('/uuid_to_id/', async function(req, res) {
    let uuid = req.query.uuid;
    let id = await dbController.getIdByUUID(uuid, globals.paths.dbDir + 'main.db', globals.tables.main.main_table);

    res.send(id[0].Id.toString());
});


module.exports.router = router;