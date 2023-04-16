:: Go to root server directory
cd ..
	
:: Create folder for JavaScript libs and go there
:: Install all URLs by CURL
cd ./assets/js
mkdir libs
cd ./libs/

:: SET ALL JS libs URLs here
:: ===========================================
curl -LO "https://unpkg.com/material-components-web@14.0.0/dist/material-components-web.min.js"
curl -LO "https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"
:: ===========================================
	
:: Go to ./assets/
cd ..
cd ..
	
:: Create libs forlder in CSS and download URLs by CURL
cd ./css/
mkdir libs
cd ./libs/

:: SET ALL CSS libs URLs here
:: ===========================================
curl -LO "https://unpkg.com/material-components-web@14.0.0/dist/material-components-web.min.css"
:: ===========================================
	
pause