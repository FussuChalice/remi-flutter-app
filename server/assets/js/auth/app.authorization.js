// file: app.authorization.js

/**
 * 
 * @param {*} param0 
 * @returns 
 */
function authorizationRequestBuilder({type, email, password, token=null}) {
    let finishURL;

    switch(type) {
        case "login":
            finishURL = "/api/auth/login";
            break;
        
        case "signup":
            finishURL = "/api/auth/signup";
            break;
    }

    let dataResp;

    $.ajax({
        type: "POST",
        url: finishURL,
        data: JSON.stringify({
            email: email,
            password: password,
            token: token,
        }),
        async: false,
        contentType: "application/json",
        success: function (response) {
            dataResp = response;
        }
    });

    return dataResp;
}

/**
 * 
 * @param {Object} param0 
 */
function buildCookie({
    cookieName,
    cookieValue,
    cookiePath,
    cookieExpires,
}) {
    
    let fcookieExpires = 0;

    if (!cookieExpires) {
        let currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + 10);
        fcookieExpires = currentDate.toUTCString();

    } else {
        fcookieExpires = cookieExpires;
    }

    document.cookie = `${cookieName}=${cookieValue}; expires=${fcookieExpires}; path=${cookiePath}`;
}
