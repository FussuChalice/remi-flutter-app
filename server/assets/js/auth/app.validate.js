// file: app.validate.js

/**
 * 
 * @param {*} email 
 * @returns 
 */
function validateEmail(email) {
    const validatePattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    
    return (email.match(validatePattern)) ? true : false;
}

/**
 * 
 * @param {*} password 
 * @returns 
 */
function validatePassword(password) {
    const validatePattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$/;

    return (password.match(validatePattern)) ? true : false;
}

/**
 * 
 * @param {*} password 
 * @param {*} confirm 
 * @returns 
 */
function validateConfirm(password, confirm) {
    return (password == confirm && confirm != '') ? true : false;
}

/**
 * 
 * @param {*} element 
 * @param {*} validateText 
 */
function reportCustomVaildity(element, validateText) {
    element.setCustomValidity(validateText);
    element.reportValidity();
}