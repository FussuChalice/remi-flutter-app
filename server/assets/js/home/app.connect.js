// app.connect.js

function error_callback(error) {
    Swal.fire({
        icon: 'error',
        title: 'Ooops! Something went wrong',
        text: "Go back by another time"
    });
}

function createRequest(method='GET', url, data=null) {
    $.ajax({
        type: method,
        url: url,
        data: JSON.stringify(data),
        dataType: "json",
        async: false,
        contentType: "application/json",
        success: function (response) {
            return response;
        },
        error: function (error) {
            console.log(error);
            error_callback();
        },
    });
}

function first_page() {
    const input_name        = $('#hsi-name');
    const input_description = $('#hsi-description');
    const input_address     = $('#hsi-address');
    const select_type       = $('#select-stype');
    let table_promocode     = document.getElementById('promocode');

    // Work with cookie
    // Cookies = is element from JQuery with functions (set, get, remove)
    const uuid      = Cookies.get("_UUID");
    const atoken    = Cookies.get("_atoken");

    $.ajax({
        type: 'GET',
        url: `/api/utility/uuid_to_id?uuid=${uuid}`,
        async: false,
        success: function (data) {
            return data;
        },
        error: function (error) {
            console.log(error);
            error_callback();
        }
    }).then(function (response) {
        $.ajax({
            type: 'GET',
            url: `/api/data/settings/${response}`,
            async: false,
            success: function (data) {

                input_name.val(data.title);
                input_description.val(data.description);
                input_address.val(data.address);
                select_type.val(data.type);

                $.ajax({
                    type: 'GET',
                    url: `/api/data/promocodes/${response}`,
                    async: false,
                    success: function (data) {
                        
                        data.forEach(function (element) {
                            let tr = document.createElement('tr');

                            let name_td = document.createElement('td');
                            name_td.innerText = element.name;

                            let discount_td = document.createElement('td');
                            discount_td.innerText = element.discount;

                            tr.appendChild(name_td);
                            tr.appendChild(discount_td);

                            let td_deleteButton = document.createElement('td');
                            td_deleteButton.classList.add(`deletePromocode`);
                            td_deleteButton.innerText = "❌";
                            tr.appendChild(td_deleteButton);

                            table_promocode.appendChild(tr);
                        });

                        return data;
                    },
                    error: function (error) {
                        console.log(error);
                        error_callback();
                    }
                });

                return data;
            },
            error: function (error) {
                console.log(error);
                error_callback();
            }
        });
    });

}