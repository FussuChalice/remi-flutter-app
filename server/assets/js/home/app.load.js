/**
 * 
 * @param {string} uuid 
 * @returns id
 */
async function getIdByUuid(uuid) {
    const id = await $.ajax({
        url: "/api/utility/uuid_to_id?uuid=" + uuid,
        type: 'GET',
    });

    return id;
}

async function updateHomePageUI(uuid) {
    try {

        const id = await getIdByUuid(uuid);

        const settings = await $.ajax({
            url: `/api/data/settings/${id}`,
            type: 'GET',

        });

        const promocodes = await $.ajax({
            url: `/api/data/promocodes/${id}`,
            type: 'GET',
        });

        /**==============|  Update UI  |==**/
        
        id_input_hsi_name.value = settings?.title;
        id_input_hsi_description.value = settings?.description;
        id_input_hsi_address.value = settings?.address;
        id_select_hms_st.value = settings?.type;
        
        promocodes.forEach(function(pcode) {
            let tmp_tr, tmp_td_name, tmp_td_discount, tmp_td_delete;
            
            tmp_tr = document.createElement('tr');
            tmp_td_name = document.createElement('td');
            tmp_td_discount = document.createElement('td');
            tmp_td_delete = document.createElement('td');

            tmp_td_name.innerText = pcode?.name;
            tmp_td_discount.innerText = pcode?.discount;
            tmp_td_delete.innerText = "❌";

            tmp_tr.className = "pcode";
            tmp_td_delete.className = "pcode-delete";

            Array.from([tmp_td_name, tmp_td_discount, tmp_td_delete]).forEach(function (element) {
                tmp_tr.appendChild(element);
            });

            id_table_promocode.appendChild(tmp_tr);
        });
        
        
        /**==============| End Update UI  |==**/



    } catch (err) {
        console.error(err);
    }
}

async function updateOrdersPageUI(uuid) {
    try {

        const id = await getIdByUuid(uuid);

        const settings = await $.ajax({
            url: `/api/data/settings/${id}`,
            type: 'GET',

        });

        const orders = await $.ajax({
            url: `/api/data/orders/${id}`,
            type: 'GET',
        });

        /**==============|  Update UI  |==**/
        
        // console.log(orders);

        orders.forEach(function (order) {
            let tmp_tr = document.createElement('tr');
            let td_avatar = document.createElement('td');
            let img_avatar = document.createElement('img');
            let td_name = document.createElement('td');
            let td_count_of_tables = document.createElement('td');
            let td_promocode = document.createElement('td');
            let td_accept_decline = document.createElement('td');

            img_avatar.src = order?.client_avatar;
            img_avatar.alt = "client_avatar";
            img_avatar.height = "80";
            td_avatar.appendChild(img_avatar);

            td_name.innerText = order?.client_name;
            td_count_of_tables.innerText = order?.count_of_tables;
            td_promocode.innerText = order?.promocode;
            td_accept_decline.innerHTML = '<span class="ordersAccept">✔️</span><span class="ordersDecline">❌</span>';

            Array.from([td_avatar, td_name, td_count_of_tables, td_promocode, td_accept_decline]).forEach(function (row) {
                tmp_tr.appendChild(row);
            });

            id_table_orders_table.appendChild(tmp_tr);

        });
        
        
        /**==============| End Update UI  |==**/



    } catch (err) {
        console.error(err);
    }
}

async function updateGalleryPage(uuid) {
    try {

        const id = await getIdByUuid(uuid);

        const main_image = await $.ajax({
            url: `/api/data/main_image/${id}`,
            type: 'GET',
        });

        const images = await $.ajax({
            url: `/api/data/images/${id}`,
            type: 'GET',
        });

        /**==============|  Update UI  |==**/

        console.log(main_image);
        
        let main_image_element = document.getElementById('main_image');
        main_image_element.style.backgroundImage = `url('${main_image}')`;
        // console.log(main_image_element);
        
        /**==============| End Update UI  |==**/



    } catch (err) {
        console.error(err);
    }
}

updateHomePageUI(Cookies.get('_UUID'));
updateOrdersPageUI(Cookies.get('_UUID'));
updateGalleryPage(Cookies.get('_UUID'));