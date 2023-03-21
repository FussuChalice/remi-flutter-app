// file: app.validate.js

/**
 * 
 * @param {String} email 
 * @returns 
 */
function validateEmail(email) {
    const validatePattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    
    return (email.match(validatePattern)) ? true : false;
}

/**
 * 
 * @param {String} password 
 * @returns 
 */
function validatePassword(password) {
    const validatePattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$/;

    return (password.match(validatePattern)) ? true : false;
}

/**
 * 
 * @param {String} password 
 * @param {String} confirm 
 * @returns 
 */
function validateConfirm(password, confirm) {
    return (password == confirm && confirm != '') ? true : false;
}

/**
 * 
 * @param {Element} element 
 * @param {String} validateText 
 */
function reportCustomVaildity(element, validateText) {
    element.setCustomValidity(validateText);
    element.reportValidity();
}