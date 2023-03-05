const fs = require('fs');

/**
 * Read the json file
 * @param {*} filepath 
 * Path to the file
 */
function read(filepath) {
    const file_data = fs.readFileSync(filepath);
    const data = JSON.parse(file_data);

    return data;
}

/**
 * 
 * @param {*} filepath 
 * Path to the file
 * @param {*} data 
 * Data for saving
 */
function create(filepath, data) {
    const file = fs.writeFileSync(filepath, data);
}

/**
 * 
 * @param {*} filepath 
 * Path to the file
 * @param {*} data 
 * New data
 */
function update(filepath, data) {
    const file = fs.readFileSync(filepath);
    let old_data = JSON.parse();

    fs.writeFileSync(filepath, data);
}

module.exports.read = read;
module.exports.create = create;
module.exports.update = update;