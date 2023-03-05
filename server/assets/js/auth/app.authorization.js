// file: app.authorization.js

/**
 * 
 * @param {*} param0 
 * @returns 
 */
function authorizationRequestBuilder({type, email, password}) {
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
            password: password
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
 * @param {*} requestBuilder 
 */
function buildCookieByAuth(requestBuilder) {
    if (requestBuilder.status == "success") {

        let currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + 10);
        let cookieExpires = currentDate.toUTCString();

        document.cookie = `_UUID=${requestBuilder.uuid}; expires=${cookieExpires}; path=/`;
    }
}
