// sign.js

function signUp() {
    let email = document.getElementById('input-email').value;
    let password = document.getElementById('input-password').value;
    let re_pass_i = document.getElementById('input-repeat-password');

    if (password == re_pass_i.value) {
        re_pass_i.setCustomValidity(" ");

        if (validateEmail(email)) {
            
            if (validatePassword(password)) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=UTF-8",
                    url: "/signup",
                    data: JSON.stringify({
                        email: email,
                        password: password
                    }),
                    success: function (data) {
                        if (data.status == "e") {
                            $('.alert').css({
                                "position": "absolute",
                                "width": "100%",
                                "display": 'block',
                                "visibility": 'visible'
                            });
                        } else {
                            document.cookie = `User=${data.uuid}`;
                        }
                    },
                    dataType: "json",
                });
            } else {
                document.getElementById('input-password').setCustomValidity("Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters");
                document.getElementById('input-password').reportValidity();
            }

        } else {
            document.getElementById('input-email').setCustomValidity("email must have @");
            document.getElementById('input-email').reportValidity();
        }

    } else {
        re_pass_i.setCustomValidity("Passwords don't match");
        re_pass_i.reportValidity();

        console.log("password don't match");
    }
}

const validateEmail = (email) => {
    return email.match(
      /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    );
};

const validatePassword = (password) => {
    return password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/);
}