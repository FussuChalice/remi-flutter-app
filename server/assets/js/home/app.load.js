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
        id_select_stype.value = settings?.type;
        
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

updateHomePageUI(Cookies.get('_UUID'));