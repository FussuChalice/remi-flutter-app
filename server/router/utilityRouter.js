const express = require('express');
const router = express.Router();

const dbController = require('../helpers/databaseController');
const globals = require('../globals');

const messages = require('../helpers/Messages.json');

router.get('/uuid_to_id/', async function(req, res) {
    let uuid = req.query.uuid;
    let id = await dbController.selectColumnByColumn({
        search_column: 'Id',
        column: "UUID",
        column_value: uuid,
        db_path: globals.paths.dbDir + "main.db",
        table_name: globals.tables.main.main_table,
    });

    if (id[0] == undefined) {
        res.send(messages.errors.db.not_found);
    } else {
        res.send(id[0].Id.toString());
    }
});


module.exports.router = router;