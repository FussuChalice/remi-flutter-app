const express = require('express');
const serverLogger = require('./helpers/serverLogger');
const globals = require('./globals');

// const cookieSession = require('cookie-session');
// const cookieParser = require('cookie-parser');

// Routers
const pages_route = require('./router/pagesRouter');
const auth_route = require('./router/authRouter');
const test_route = require('./router/testRouter');

const app = express();
const PORT = process.env.port || process.argv[2];

app.use(express.json());


app.use('/', pages_route.router);
app.use('/api/auth', auth_route.router);
app.use('/assets', express.static('./assets/'));

app.use('/api/test', test_route.router);

app.listen(PORT, () => {
    serverLogger.Log(`Server started on ${globals.serverURL}:${PORT}`, serverLogger.logLevel.INFO, true);
});