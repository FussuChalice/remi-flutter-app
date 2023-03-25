const fs =  require('fs');
const slog = require('./serverLogger');
const dbController = require('./databaseController');
const globals = require('../globals');

async function readFile(id=null) {
    try {
        let uuid = await dbController.getUUIDById(id, globals.paths.dbDir + 'main.db', globals.tables.main.main_table);
        let result = fs.readFileSync(globals.paths.dbDir + uuid[0].UUID);
        return JSON.parse(result);

    } catch (err) {
        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
    }
}

module.exports.readFile = readFile;