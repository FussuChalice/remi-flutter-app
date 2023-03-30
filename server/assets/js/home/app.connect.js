// app.connect.js

function createRequest(method='GET', url, data=null, error_callback) {
    $.ajax({
        type: method,
        url: url,
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

