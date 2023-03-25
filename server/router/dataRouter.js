const express = require('express');
const router = express.Router();
const fs = require('fs');

const dbController = require('../helpers/databaseController');
const jsonController = require('../helpers/jsonController');
const globals = require('../globals');
const serverLogger = require('../helpers/serverLogger');

/**==| Get routes |==**/
/****/
/****/router.get('/settings/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.settings);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/****/router.get('/promocodes/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.promocodes);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/****/router.get('/contacts/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.contacts);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/****/router.get('/comments/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.comments);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/****/router.get('/images/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.images);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/****/router.get('/menu/:id', async function (req, res) {
/****/    try {
/****/        let result = await jsonController.readFile(req.params['id']);
/****/        // console.log(req.params);
/****/        res.send(result.menu);
/****/
/****/    } catch (err) {
/****/        serverLogger.Log(err, serverLogger.logLevel.ERROR, true);
/****/    }
/****/});
/****/
/**==| End Get Routes |==**/

module.exports.router = router;