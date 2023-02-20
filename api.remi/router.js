const express = require('express');
const sqllite3 = require('sqlite3').verbose();
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const utility = require('./utility');
const router = express.Router();

const db = new sqllite3.Database('./databases/main.db');

router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, "/index.html"));
    console.log(`[${utility.getCurrentTimeAndDate()}] Connected ${utility.parseClientIp(req)}`);
});

router.get('/pages/sign-up', (req, res) => {
    res.sendFile(path.join(__dirname, "/public/pages/sign-up.html"));
    console.log(`[${utility.getCurrentTimeAndDate()}] Connected ${utility.parseClientIp(req)} to /sign-up`);
});

router.get('/pages/log-in', (req, res) => {
    res.sendFile(path.join(__dirname, "/public/pages/log-in.html"));
    console.log(`[${utility.getCurrentTimeAndDate()}] Connected ${utility.parseClientIp(req)} to /log-in`);
});

// Page for save data to db
router.post('/signup', async (req, res) => {
    let table_name = "services_passwords";
    let u_email = req.body.email;
    let u_password = req.body.password;
    let u_uuid = uuidv4();

    if (await utility.checkExistingInDB({
        database: db,
        table_name: table_name,
        param_name: "email",
        param_value: u_email
    })) {

        res.json({status: "e", error: `Email is used! <a href="./log-in" class="alert-link">Login</a>`});

    } else {

        if (await utility.createPersonInDB({
            database: db,
            table_name: table_name,
            email: u_email,
            password: u_password,
            uuid: u_uuid
        })) {
            res.json({status: "s", uuid: u_uuid});
        }

    }
});

router.post('/login', async (req, res) => {
    let table_name = "services_passwords";
    let u_email = req.body.email;
    let u_password = req.body.password;

    let user_uuid = await utility.getUUIDByEmailAndPassword({
        database: db,
        table_name: table_name,
        email: u_email,
        password: u_password
    });

    let result, status;

    if (user_uuid == undefined) {
        status = "e";
        result = `Wrong email or password. <a href="./sign-up" class="alert-link">SignUp</a>`;
    } else {
        status = "s";
        result = user_uuid['UUID'];
    }

    res.json({status: status, result: result});
});


router.post('/services/info-by-uuid', async (req, res) => {
    let uuid = req.body.uuid;

    if (uuid === undefined) {
        res.json({"data":"is undefined"});

    } else {
        let data = await utility.getInfoByUUID(db, "services_passwords", uuid);
        res.json(data);
    }
});

router.post('/services/save-settings', (req, res) => {
    let uuid = req.body.uuid;
    let in_data = req.body.data;

    utility.saveSettings(uuid, in_data);
    res.json({"status": "success"});
});
router.post('/services/save-promocodes', (req, res) => {
    let uuid = req.body.uuid;
    let in_data = req.body.data;
});

router.all('*', (req, res) => {
    res.status(404).sendFile(path.join(__dirname, '/public/errors/404.html'));
    console.log(`[${utility.getCurrentTimeAndDate()}] Connected ${utility.parseClientIp(req)} to /404 `);
});

module.exports = router;