
# API Server for Remi 🪴
API Server writed on Node.js, Express.js + SQLite and another CSS and JS libraries.

For install all dependencies use this command in project folder
```
    > npm install
```

## Setup
- For setup start:
    - Linux: 
    ```bash
        cd tools
        sudo chmod +x linux_setup.sh
        sudo linux_setup.sh
    ```
    - Windows:
        1. Install [CURL](https://curl.se/download.html)
        2. Install [Node.js](https://nodejs.org/)
        3. Start [windows_setup.bat](./tools/windows_setup.bat)

## API documentation
API documentation saved on [postman collection](./docs/remi.server.postman_collection.json). Import this file into Postman to view requests and documents, but there are no documents to request data, so open server files or write documents yourself. This is official article [How export and import data on Postman?](https://learning.postman.com/docs/getting-started/importing-and-exporting-data/) 

## Run 
- For developer mode use
```
    > npm run dev <port>
```
- Or click:
    - Windows ([windows_dev_start.bat](./tools/windows_dev_start.bat))
    - Linux ([linux_dev_start.sh](./tools/linux_dev_start.sh))

For release mode use
```
    > npm run start <port>
```

## Directories and paths 📂

| Directory | Description                                                       |
|:---------:|-------------------------------------------------------------------|
|   views   | Directory for saving all *.html files                             |
|  helpers  | Directory for keeping all small modules for project writen as me. |
|    docs   | Documentation directory.                                          |
|   router  | Directory for saving all Routers.                                 |
|    logs   | Folder for application, for save techical logs.                   |
|     db    | Directory for Database. Application save there json files.        |
|   assets  | Assets is [*.css, *.js for pages, images, uploads and another]    |
|   tools   | Folder with tools for start or dev server                         |

