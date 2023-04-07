const fs =  require('fs');
const slog = require('./serverLogger');
const dbController = require('./databaseController');
const globals = require('../globals');

async function readFile(id=null) {
    try {
        let uuid = await dbController.selectColumnByColumn({
            search_column: 'UUID',
            column: 'Id',
            column_value: id,
            db_path: globals.paths.dbDir + 'main.db',
            table_name: globals.tables.main.main_table,
        });
        let result = fs.readFileSync(globals.paths.dbDir + uuid[0].UUID);
        return JSON.parse(result);

    } catch (err) {
        serverLogger.Log(`[${__filename}]: ${err}`, serverLogger.logLevel.ERROR, true);
        return 'Error reading';
    }
}

async function saveFile(uuid, data, section) {
    try {
        let obj = JSON.parse(fs.readFileSync(globals.paths.dbDir + uuid[0].UUID));

        obj[section] = data;

        fs.writeFileSync(globals.paths.dbDir + uuid[0].UUID, JSON.stringify(obj));

        return 'Data saved';

    } catch (err) {
        serverLogger.Log(`[${__filename}]: ${err}`, serverLogger.logLevel.ERROR, true);
        return 'Error saving';
    }
}

module.exports.readFile = readFile;
module.exports.saveFile = saveFile;