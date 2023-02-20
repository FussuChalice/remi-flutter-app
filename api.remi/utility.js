const sqllite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');

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

                var PatternOBJ = {
                    settings: {
                        address: null,
                        service_name: null,
                        description: null,
                        main_img: null,
                        service_type: "restaurant",
                        owner_email: email,
                    },
                    images: [],
                    orders: [],
                    comments: [],
                    promocodes: [],
                };

                var json_pattern = JSON.stringify(PatternOBJ);

                fs.writeFile(path.join(__dirname, '/databases/' + uuid + '.json'), json_pattern, 'utf8', (err, data) => {});

                resolve(true);
            }
            catch (e) {
                reject(e);
            }
        });
    },
    saveSettings: (uuid, settings_data) => {
        fs.readFile(path.join(__dirname, `/databases/${uuid}.json`), 'utf8', function readFileCallback(err, data) {
            if (err) {
                console.log(err);
            } else {
                obj = JSON.parse(data);
                obj.settings.address = settings_data.service_address;
                obj.settings.service_name = settings_data.service_name;
                obj.settings.description = settings_data.service_description;
                obj.settings.service_type = settings_data.service_type;

                json = JSON.stringify(obj); //convert it back to json
                fs.writeFile(path.join(__dirname, `/databases/${uuid}.json`), json, 'utf8', (err, data) => {});
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
    getInfoByUUID: async (db, table_name, uuid) => {
        if (await module.exports.checkExistingInDB({
            database: db,
            table_name: table_name,
            param_name: "UUID",
            param_value: uuid
        })) {
            
            // Read JSON file and return
            let json = JSON.parse(fs.readFileSync(path.join(__dirname, "/databases/" + uuid + ".json"), "utf8"));
            return json;
        } else {
            return {"error": "no user"};
        }
    }
    
}