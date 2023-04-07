const DOME = {

};

async function loadDataFromServer(uuid) {
    try {

        const id = await $.ajax({
            url: "/api/utility/uuid_to_id?uuid=" + uuid,
            type: 'GET',
        });

        const data = await $.ajax({
            url: `/api/data/full/${id}`,
            type: 'GET',

        });

        return data;

    } catch (err) {
        console.error(err);
    }
}

function updateUI(data) {

}

let res = loadDataFromServer(Cookies.get('_UUID'));
console.log(res);