const express = require('express');
const sqllite3 = require('sqlite3').verbose();
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const utilites = require('./utilites');
const router = express.Router();

const db = new sqllite3.Database('./database.db');

router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, "/index.html"));
    console.log(`[${utilites.getCurrentTimeAndDate()}] Connected ${utilites.parseClientIp(req)}`);
});

router.get('/pages/sign-up', (req, res) => {
    res.sendFile(path.join(__dirname, "/public/pages/sign-up.html"));
    console.log(`[${utilites.getCurrentTimeAndDate()}] Connected ${utilites.parseClientIp(req)} to /sign-up`);
});

router.get('/pages/log-in', (req, res) => {
    res.sendFile(path.join(__dirname, "/public/pages/log-in.html"));
    console.log(`[${utilites.getCurrentTimeAndDate()}] Connected ${utilites.parseClientIp(req)} to /log-in`);
});

// Page for save data to db
router.post('/signup', async (req, res) => {
    let table_name = "services_passwords";
    let u_email = req.body.email;
    let u_password = req.body.password;
    let u_uuid = uuidv4();

    if (await utilites.checkExistingInDB({
        database: db,
        table_name: table_name,
        param_name: "email",
        param_value: u_email
    })) {

        res.json({status: "e", error: `Email is used! <a href="./log-in" class="alert-link">Login</a>`});

    } else {

        if (await utilites.createPersonInDB({
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

    let user_uuid = await utilites.getUUIDByEmailAndPassword({
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


router.all('*', (req, res) => {
    res.status(404).sendFile(path.join(__dirname, '/public/errors/404.html'));
    console.log(`[${utilites.getCurrentTimeAndDate()}] Connected ${utilites.parseClientIp(req)} to /404 `);
});

module.exports = router;