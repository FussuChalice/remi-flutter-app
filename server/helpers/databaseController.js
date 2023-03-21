const sqlite3 = require('sqlite3').verbose();
const globals = require('../globals');
const serverLogger = require('./serverLogger');

/**
 * Get names of columns in the table of database
 * @param {Path} db_path 
 * Name of file database is can have extension: db, sqlite3 and another ...
 * @param {String} table_name 
 * Table name in Database
 * @returns {Promise} PromiseWithColumnNames
 */
async function getColumnNames(db_path, table_name) {
    const database = new sqlite3.Database(db_path);

    try {
        let PromiseWithColumnNames = new Promise(function(resolve, reject) {
            database.all(`PRAGMA table_info(${table_name})`, function (err, rows) {
    
                if (err) {
                    serverLogger.Log(err.message, serverLogger.logLevel.ERROR, true);
                }
        
                let columnNames = [];
        
                rows.forEach(function (row) {
                    columnNames.push(row.name);
                });
        
                resolve(columnNames);
            });
        });

        return PromiseWithColumnNames;
    } catch (err) {
        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
    }
}

/**
 * Convert array to string
 * @param {Array} array 
 * Example:
 * ```javascript
 *  var array = [10, "hello", true, "world"];
 *  arrayToString(array);
 *  // => "10, "hello", true, "world""
 * ```
 */
function arrayToString(array) {
    return array.map((item) => {
        if (typeof item === "string") {
          return `"${item}"`;

        } else {
          return item;
        }
    }).join(", ");
}

/**
 * DatabaseMethods for control
 */
const databaseMethods = {
    INSERT: 0,
    DELETE: 1,
    CHECK_EXIST: 2,
    READ: 3
};

async function isExist(result) {
    return result.length > 0 ? true : false;
}

/**
 * 
 * @param {Object} param0
 * have three parameters [db_path, table_name, record=null, existed=null] 
 * @param {databaseMethods} method
 * is getted from databaseMethods
 * @param {Function} callback 
 * function with param (err, result)
 * Example:
 * ```javascript
 *  const db_path = './test.db';
 *  const table_name = 'test';
 * 
 *  const record = ["Earth"];
 *  const existed = ["title"];
 *  
 *  // Chech existing of record
 *  control({db_path, table_name, record, existed}, databaseMethods.CHECK_EXIST, function(err, result) {
 *      if (err) throw err;
 * 
 *      if (result) {
 *          console.log("Record is existed!!!");
 *      } else {
 *          console.log("Record does not exist!!!");
 *      }
 *      ...
 *  });
 * ```
 */
async function control({db_path, table_name, record=null, existed=null, select=null}, method) {
    const database = new sqlite3.Database(db_path);

    // Get names of columns
    let column_names = await getColumnNames(db_path, table_name);
    column_names.shift();
    let newCN = column_names.join(", ");

    let stringedRecord;
    if (record != null) {
        stringedRecord = arrayToString(record);
    }

    let query;
    switch (method) {
        case databaseMethods.INSERT:
            query = `INSERT INTO ${table_name} (${newCN}) VALUES (${stringedRecord})`;
            break;
        
        case databaseMethods.DELETE:
            query = `DELETE FROM ${table_name} WHERE (${newCN}) = (${stringedRecord})`;
            break;

        case databaseMethods.CHECK_EXIST:
            query =
              existed == null
                ? `SELECT * FROM ${table_name} WHERE (${newCN}) = (${stringedRecord})`
                : `SELECT * FROM ${table_name} WHERE (${existed.join(", ")}) = (${stringedRecord})`;

            break;

        case databaseMethods.READ:
            query = `SELECT ${select} FROM ${table_name} WHERE (${existed.join(", ")}) = (${stringedRecord})`;
            // console.log(query);
            break;
            
    }


    try {

        let output = new Promise(function (resolve, reject) {
            if (method == databaseMethods.CHECK_EXIST || method == databaseMethods.READ) {
                database.all(query, function (err, result) {
                    if (err) { resolve(0x1) }
                    else {
                        resolve(result);
                    }
                });
            } 
    
            else {
                database.run(query, function (err, result) {
                    if (err) { resolve(0x1) }
                    else { resolve(result); }
                });
            }
    
        });

        return output;

    } catch (err) {
        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
    }

}


module.exports.control = control;
module.exports.databaseMethods = databaseMethods;
module.exports.arrayToString = arrayToString;
module.exports.isExist = isExist;
module.exports.getColumnNames = getColumnNames;