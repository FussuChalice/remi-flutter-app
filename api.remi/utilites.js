module.exports = {
    getCurrentTimeAndDate: () => {
        var today = new Date();
        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        return date+' '+time;
    },
    parseClientIp: (request) => request.headers['x-forwarded-for']?.split(',').shift() || request.socket?.remoteAddress,
    checkExistingInDB: (db) => {
        let status = null;
        db.all(`SELECT email FROM services_passwords WHERE email = "${email}"`, (err, result) => {
            console.log(err);
            
            if (result.length != 0) {
                status = "e";
                console.log(result.length);
            } else {
                status = "s";
            }
        });

        return status;
    },
}