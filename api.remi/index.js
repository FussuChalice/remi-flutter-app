const express = require('express');
const path = require('path');
const utility = require('./utility');
const router = require('./router');

const app = express();
const PORT = process.env.port || process.argv[2];

app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());

app.use('/', router);

app.listen(PORT, () => {
    console.log(`[${utility.getCurrentTimeAndDate()}] Server started on http://localhost:${PORT}/`);
});