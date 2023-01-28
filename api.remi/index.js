const express = require('express');
const sqllite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const { checkRowExistingInDB } = require('./utilites');
const utilites = require('./utilites');

const app = express();
const PORT = process.env.port || process.argv[2];

// Conect to db
const db = new sqllite3.Database('./database.db');

app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, "/index.html"));
    console.log(`[${utilites.getCurrentTimeAndDate()}] Connected ${utilites.parseClientIp(req)}`);
});


// Page for save data to db
app.post('/signup', (req, res) => {
    let email = req.body.email;
    let password = req.body.password;

    // Generate UUID
    let uuid = uuidv4();
    let status = null;

    db.all(`SELECT email FROM services_passwords WHERE email = "${email}"`, (err, result) => {
        console.log(err);
        
        if (result.length != 0) {
            status = "e";
            console.log(result.length);
        } else {
            status = "s";
            try {
        


                // db.serialize(() => {
                //     db.run(`INSERT INTO services_passwords (email, password, UUID) VALUES("${email}", "${password}", "${uuid}")`);
                // });
                console.log(`[${utilites.getCurrentTimeAndDate()}] /signup/ : data saved {${email}, ${password}}`);
            }
            catch (err) {
                console.log(err);
            }
        }

        res.json({status: status, uuid: uuid});
    });

});

app.listen(PORT, () => {
    console.log(`[${utilites.getCurrentTimeAndDate()}] Server started on http://localhost:${PORT}/`);
});