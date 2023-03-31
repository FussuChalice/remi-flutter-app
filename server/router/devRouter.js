const express = require('express');
const router = express.Router();

const slog = require('../helpers/serverLogger');
const pkg = require('../package.json');


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

module.exports.router = router;