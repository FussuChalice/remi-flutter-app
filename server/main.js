const express = require('express');
const serverLogger = require('./helpers/serverLogger');
const globals = require('./globals');

// const cookieSession = require('cookie-session');
// const cookieParser = require('cookie-parser');

// Routers
const pages_route = require('./router/pagesRouter');
const auth_route = require('./router/authRouter');
const data_route = require('./router/dataRouter');
const utility_route = require('./router/utilityRouter');

const app = express();
const PORT = process.env.port || process.argv[2];

app.use(express.json());


app.use('/', pages_route.router);
app.use('/api/auth', auth_route.router);
app.use('/api/data/', data_route.router);
app.use('/api/utility/', utility_route.router);

app.use('/assets', express.static('./assets/'));

app.listen(PORT, () => {
    serverLogger.Log(`Server started on ${globals.serverURL}:${PORT}`, serverLogger.logLevel.INFO, true);
});