const path = require('path');
const express = require('express');
const router = express.Router();
const slog = require('../helpers/serverLogger');

router.get('/', function (req, res) {
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

// router.get('*', function (req, res) {
//     res.sendFile(path.join(__dirname, '../views/404.html'), 404);
//     slog.Log("Connected to /404", slog.logLevel.INFO, true);
// });


module.exports.router = router;