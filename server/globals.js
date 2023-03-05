/**
 * Path to directories or files
 */
const paths = {
    logDir: './logs/',
    dbDir: './db/',
};

/**
 * Data for test APIs
 */
const Test = {
    auth: {
        email: "test@example.com",
        password: "Testpassword123",
        uuid: "a9ac528e-6d9d-4e69-ae04-85a63d5d8263"
    },
}

const newServiceFilePattern = {
    settings: {
        title: null,
        type: "restaurant",
        main_image: null,
        address: null,
    },
    promocodes: [],
    contacts: {
        phone_numbers: null,
        email: null,
        social_network: {
            twitter: null,
            youtube: null,
            telegram: null,
            facebook: null,
            instagram: null,
            reddit: null,
            pinterest: null,
        },
    },
    comments: {},
    orders: {},
    images: {},
    menu: {},
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

module.exports.newServiceFilePattern = newServiceFilePattern;
// module.exports.cookieSessionConfig = cookieSessionConfig;