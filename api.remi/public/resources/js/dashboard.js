function loadToHomePage(data) {
    // Set to inputs
    document.getElementById('hsi-name').value = data.settings.service_name;
    document.getElementById('hsi-description').value = data.settings.description;
    document.getElementById('hsi-address').value = data.settings.address;

    document.getElementById(`sopt-${data.settings.service_type}`).setAttribute("selected", "selected");

    let p_index = 0;
    const promocodes_array = data.promocodes;
    promocodes_array.forEach(element => {
        
        let promocode = document.createElement("tr");
        let tr_id = `tdpr-${p_index}`;
        promocode.id = tr_id;
        promocode.innerHTML = `<td>${element.name}</td><td>${element.discount}</td><td><span class="delete-promocode" id="${p_index}">❌</span></td>`;
        document.getElementById("promocode").appendChild(promocode);
        p_index++;
    });
}

function getDataByUUID(uuid) {
    let data_resp = {};
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=UTF-8",
        url: "/services/info-by-uuid",
        data: JSON.stringify({
            uuid: uuid
        }),
        async: false,
        success: function (data) {
            data_resp = data;
        },
        dataType: "json"
    });

    return data_resp;
}

function checkUserInCookie() {
    if (getCookie("_U") == null) {
        
        Swal.fire({
            title: "You must Log-in",
            icon: "error",
            showDenyButton: true,
            confirmButtonText: "Log-in",
            denyButtonText: "Sign-up",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/pages/log-in";
            } else {
                window.location.href = "/pages/sign-up";
            }
        });

    } else {
        let data = getDataByUUID(getCookie("_U"));
        loadToHomePage(data);
    }
}

function getCookie(name) {

    var matches = document.cookie.match(new RegExp(
      "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ))
    return matches ? decodeURIComponent(matches[1]) : undefined
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


checkUserInCookie();