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

function deletePromocode() {
    $(".delete-promocode").on("click", function() {
        let button_id = $(this).attr("id");
        
        Swal.fire({
            title: "You want delete promocode?",
            icon: "info",
            confirmButtonText: "Yes",
            showDenyButton: true,
            denyButtonText: "No",
        }).then((result) => {
            if (result.isConfirmed) {
                $("#tdpr-" + button_id).remove();
            }
        });
    });
}

function saveProfileSettings() {
    $("#hms-b-save").on("click", function() {
        let service_name = $("#hsi-name").val();
        let service_description = $("#hsi-description").val();
        let service_address = $("#hsi-address").val();

        let service_type = $("#hms-st").val();

        Swal.fire({
            title: 'Do you want to save the changes?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Save',
            denyButtonText: `Don't save`,
          }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=UTF-8",
                    url: "/services/save-settings",
                    data: JSON.stringify({
                        data: {
                            service_name: service_name,
                            service_address: service_address,
                            service_description: service_description,
                            service_type: service_type,
                        },
                        uuid: getCookie("_U"),
                    }),
                    async: false,
                    success: function (data) {
                        if (data.status == "success") {
                            Swal.fire('Saved!', '', 'success');
                        }
                    },
                    dataType: "json"
                });
            } else if (result.isDenied) {
              Swal.fire('Changes are not saved', '', 'info');
            }
          });
    });
}