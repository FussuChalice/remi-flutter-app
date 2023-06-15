const crypto_js = require('crypto-js');
const { Log, logLevel } = require('./serverLogger');

/**
 * 
 * @param {string} STRING 
 * @param {string} SECRED_CODE 
 * @returns 
 */
module.exports.GenerateAuthToken = function(STRING, SECRET_CODE) {
    try {
        return crypto_js.AES.encrypt(STRING, SECRET_CODE);
    } catch (err) {
        Log(`[${__filename}]: ${err}`, logLevel.ERROR, true);
    }
}

/**
 * 
 * @param {string} STRING 
 * @param {string} SECRET_CODE 
 * @returns 
 */
module.exports.ReadAthToken = function(STRING, SECRET_CODE) {
    try {
        return crypto_js.AES.decrypt(STRING, SECRET_CODE).toString(crypto_js.enc.Utf8);
    } catch (err) {
        Log(`[${__filename}]: ${err}`, logLevel.ERROR, true);
    }
};