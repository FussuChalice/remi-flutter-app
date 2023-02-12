const sqllite3 = require('sqlite3').verbose();

module.exports = {
    getCurrentTimeAndDate: () => {
        var today = new Date();
        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        return date+' '+time;
    },
    parseClientIp: (request) => request.headers['x-forwarded-for']?.split(',').shift() || request.socket?.remoteAddress,
    checkExistingInDB: async ({database, table_name, param_name, param_value}) => {
        return new Promise((resolve, reject) => {
            database.all(`SELECT ${param_name} FROM ${table_name} WHERE ${param_name} = "${param_value}"`, (err, result) => {
                if (err) {
                    reject(err);
                }

                else {
                    if (result.length > 0) {
                        promise_result = true;
                    } else {
                        promise_result = false;
                    }
                }

                resolve(promise_result);
            });
        });
    },
    createPersonInDB: async ({database, table_name, email, password, uuid}) => {
        return new Promise((resolve, reject) => {
            try {
                database.run(`INSERT INTO ${table_name} (email, password, UUID) VALUES ("${email}", "${password}", "${uuid}")`);
                resolve(true);
            }
            catch (e) {
                reject(e);
            }
        });
    },
    getUUIDByEmailAndPassword: async ({database, table_name, email, password}) => {
        return new Promise((resolve, reject) => {
            database.get(`SELECT UUID FROM ${table_name} WHERE (email, password) = ("${email}", "${password}")`, (err, result) => {
                if (err) {
                    reject(err);
                }
                resolve(result);
            });
        });
    },
}