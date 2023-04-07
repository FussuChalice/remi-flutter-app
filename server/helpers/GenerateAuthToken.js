const crypto_js = require('crypto-js');
const { Log, logLevel } = require('./serverLogger');

/**
 * 
 * @param {string} STRING 
 * @param {string} SECRED_CODE 
 * @returns 
 */
module.exports.GenerateAuthToken = function(STRING, SECRED_CODE) {
    try {
        return crypto_js.AES.encrypt(STRING, SECRED_CODE);
    } catch (err) {
        Log(`[${__filename}]: ${err}`, logLevel.ERROR, true);
    }
}

/**
 * 
 * @param {string} STRING 
 * @param {string} SECRED_CODE 
 * @returns 
 */
module.exports.ReadAthToken = function(STRING, SECRED_CODE) {
    try {
        return crypto_js.AES.decrypt(STRING, SECRED_CODE);
    } catch (err) {
        Log(`[${__filename}]: ${err}`, logLevel.ERROR, true);
    }
};