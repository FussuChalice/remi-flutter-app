const path = require('path');
const express = require('express');
const router = express.Router();
const slog = require('../helpers/serverLogger');

const pkg = require('../package.json');

// var { randomBytes } = require('crypto');

router.get('/', function (req, res) {
    console.log(req.session)
    res.sendFile(path.join(__dirname, '../views/index.html'));
    slog.Log(`${slog.parseClientIPAddress(req)} Connected to /`, slog.logLevel.INFO, true);
});

router.get('/login', function (req, res) {
    res.sendFile(path.join(__dirname, '../views/log-in.html'));
    slog.Log(`${slog.parseClientIPAddress(req)} Connected to /login`, slog.logLevel.INFO, true);
});

router.get('/signup', function (req, res) {
    res.sendFile(path.join(__dirname, '../views/sign-up.html'));
    slog.Log(`${slog.parseClientIPAddress(req)} Connected to /signup`, slog.logLevel.INFO, true);
});

// Route for get all version of Software
router.get('/version', function (req, res) {
    const versions = {
        app_version: pkg.version,
        node_js_version: process.version,
        packages: {
            express: pkg.dependencies.express,
            sqlite3: pkg.dependencies.sqlite3
        },
    };

    res.send(versions);
    slog.Log(`${slog.parseClientIPAddress(req)} Connected to /version`, slog.logLevel.INFO, true);
});

// router.get('*', function (req, res) {
//     res.sendFile(path.join(__dirname, '../views/404.html'), 404);
//     slog.Log("Connected to /404", slog.logLevel.INFO, true);
// });


module.exports.router = router;