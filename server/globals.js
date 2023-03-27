/**
 * Path to directories or files
 */
const paths = {
    logDir: './logs/',
    dbDir: './db/',
};

const tables = {
    main: {
        main_table: 'services_passwords',
    },
};

/**
 * Data for test APIs requests
 */
const Test = {
    auth: {
        email: "test@example.com",
        password: "Testpassword123",
        uuid: "a9ac528e-6d9d-4e69-ae04-85a63d5d8263"
    },
}

// const cookieSessionConfig = {
//     name: 'session',
//     secret: 'TqaShjGVydFZzXEg',
//     maxAge: 24 * 60 * 60 * 1000,
//     sameSite: 'lax',                              
//     path: '/',                                    
//     httpOnly: true    
// };

const serverURL = 'http://localhost';


module.exports.paths = paths;
module.exports.serverURL = serverURL;
module.exports.Test = Test;
module.exports.tables = tables;