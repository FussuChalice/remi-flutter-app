// file: app.dashboard.js
$(document).ready(function() {
    // Function with JQuery

    function addMenuMechanic() {
        $(".menu-select-button").on("click", function() {
            $(".menu-select-button").removeClass("selected");
            $(this).addClass("selected");
    
            switch(this.id) {
                case "home-s":
                    $(".content-canvas").removeClass("opened");
                    $("#home-page").addClass("opened");
    
                    break;
    
                case "orders-s":
                    $(".content-canvas").removeClass("opened");
                    $("#orders-page").addClass("opened");
    
                    break;
    
                case "gallery-s":
                    $(".content-canvas").removeClass("opened");
                    $("#gallery-page").addClass("opened");
    
                    break;
                    
                case "comment-s":
                    $(".content-canvas").removeClass("opened");
                    $("#comment-page").addClass("opened");
    
                    break;
            }
        });
    }

    function showClock() {
        setInterval(function() {
            // Minutes
            var minutes = new Date().getMinutes();
            // Hours
            var hours = new Date().getHours(); 
    
            document.getElementById("span-clock").innerText = (hours < 10 ? '0' : '') + hours + ":" +  (minutes < 10 ? '0' : '') + minutes;
        }, 1000);
    }

    function redirectIFNoCookie() {
        if (window.document.cookie.indexOf("_UUID=") == -1) {
            window.location.href = "/signup";
        }
    }
    
    redirectIFNoCookie();
    addMenuMechanic();
    showClock();
});