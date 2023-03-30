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

    function error_callback(error) {
        console.log(error);
        Swal.fire({
            icon: 'error',
            title: 'Ooops! Something went wrong',
            text: "Go back by another time"
        });
    }
    
    // function  createPromocode() {
    //     let promocode = {
    //         name:
    //     };
    //     $('#createPromocode').on('click', function() {
    //         Swal.fire({
    //             title: 'Enter name of promocode',
    //             showCloseButton: true,
    //             input: 'text',
    //             confirmButtonText: 'Next',
    //             inputAttributes: {
    //                 autocapitalize: 'off'
    //             },
    //             preConfirm: function(promocode_name) {
    //                 console.log(promocode_name);
    //             }
    //         });
    //     });
    // }

    function first_page() {
        const input_name        = $('#hsi-name');
        const input_description = $('#hsi-description');
        const input_address     = $('#hsi-address');
        const select_type       = $('#select-stype');
        const table_promocode   = $('#promocode');

        // Work with cookie
        // Cookies = is element from JQuery with functions (set, get, remove)
        const uuid      = Cookies.get("_UUID");
        const atoken    = Cookies.get("_atoken");

        const service_id = createRequest("GET", `/api/utility/uuid_to_id?uuid=${uuid}`, error_callback);
        alert(service_id)


    }
    
    redirectIFNoCookie();
    addMenuMechanic();
    showClock();

    // Load pages
    first_page();

});