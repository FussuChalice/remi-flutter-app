const fs = require('fs');
const globals = require('../globals');

/**
 * Colors and font settings for output on console
 */
const Colors = {
    Reset: "\x1b[0m",       Bright: "\x1b[1m",
    Dim: "\x1b[2m",         Underscore: "\x1b[4m",
    Blink: "\x1b[5m",       Reverse: "\x1b[7m",
    Hidden: "\x1b[8m",

    FgBlack: "\x1b[30m",    FgRed: "\x1b[31m",
    FgGreen: "\x1b[32m",    FgYellow: "\x1b[33m",
    FgBlue: "\x1b[34m",     FgMagenta: "\x1b[35m",
    FgCyan: "\x1b[36m",     FgWhite: "\x1b[37m",
    FgGray: "\x1b[90m",     FgOrange: "\x1b[38;5;208m",

    BgBlack: "\x1b[40m",    BgRed: "\x1b[41m",
    BgGreen: "\x1b[42m",    BgYellow: "\x1b[43m",
    BgBlue:"\x1b[44m",      BgMagenta: "\x1b[45m",
    BgCyan: "\x1b[46m",     BgWhite: "\x1b[47m",
    BgGray: "\x1b[100m",
};

const logLevel = {
    DEBUG: 'DEBUG',
    INFO: 'INFO',
    WARN: 'WARN',
    ERROR: 'ERROR',
    FATAL: 'FATAL',
};

/**
 * 
 * @returns Obj with current time and date
 */
function getCurrentTimeAndDate() {
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

    return {
        gmt: today.toGMTString(),
        date: {
            year: today.getFullYear(),
            month: today.getMonth() + 1,
            day: today.getDate(),
        },
        time: {
            hours: today.getHours(),
            minutes: today.getMinutes(),
            seconds: today.getSeconds(),
        },
    };
}


/**
 * @param {*} request 
 * @returns client ip-address
 */
function parseClientIPAddress(request) {
    return request.headers['x-forwarded-for']?.split(',').shift() || request.socket?.remoteAddress;
}


/**
 * Function for log to console and write to file all logs from the server
 * @param {*} message
 * Text for print or save to log
 * @param {*} level
 * DEBUG, INFO, WARN, ERROR, FATAL, from {logType}
 * @param {*} save_to_folder 
 * boolean true to save, or false to not save
 */
function Log(message, level=logLevel.INFO, save_to_folder=false) {
    let currentTimeAndDate = getCurrentTimeAndDate();

    let printColor = Colors.FgWhite;

    switch (level) {
        case logLevel.INFO:
            printColor = Colors.FgBlue;
            break;

        case logLevel.WARN:
            printColor = Colors.FgYellow;
            break;

        case logLevel.DEBUG:
            printColor = Colors.FgGreen;
            break;

        case logLevel.ERROR:
            printColor = Colors.FgOrange;

        case logLevel.FATAL:
            printColor = Colors.FgRed;
    }

    let datePatern = `${currentTimeAndDate.date.month}-${currentTimeAndDate.date.day}-${currentTimeAndDate.date.year}` +
        ` ${currentTimeAndDate.time.hours}:${currentTimeAndDate.time.minutes}:${currentTimeAndDate.time.seconds}`;

    let logFileName = `${currentTimeAndDate.date.month}-${currentTimeAndDate.date.day}-${currentTimeAndDate.date.year}`;

    let pattern = `[${datePatern}]::[${level}] ${message}`;
    console.log(printColor + pattern + Colors.Reset);

    if (save_to_folder) {
        fs.appendFile(globals.paths.logDir + `${logFileName}.log`, pattern + '\n', function (err) {
            if (err) {
                console.log(Colors.FgRed + err + Colors.Reset);
            }
        });
    }
}

module.exports.getCurrentTimeAndDate = getCurrentTimeAndDate;
module.exports.parseClientIPAddress = parseClientIPAddress;
module.exports.Log = Log;
module.exports.logLevel = logLevel;