// app.connect.js

const apiUrls = {
    settings: '/settings/',
    promocodes: '/promocodes/',
    images: '/images/',
    menu: '/menu/',
    orders: '/orders/',
    comments: '/comments/',
};

function createRequest(url=apiUrls.settings, method='GET', data=null, error_callback) {
    $.ajax({
        type: method,
        url: '/api/data/' + url,
        data: JSON.stringify(data),
        dataType: "json",
        async: false,
        contentType: "application/json",
        success: function (response) {
            return response;
        },
        error: error_callback(error),
    });
}