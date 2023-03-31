:install_libs

    curl -LO "https://code.jquery.com/jquery-3.6.4.min.js"
    curl -LO "https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"
    curl -LO "https://github.com/js-cookie/js-cookie/releases/download/v3.0.1/js.cookie.min.js"

EXIT /B 0


:main

    cd ..
    cd /assets/js/
    mkdir libs

    CALL install_libs

    cd ..
    cd ..

    cd /assets/css/
    curl -LO "https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css"

    cd ..
    cd ..

    

EXIT /B 0


CALL main