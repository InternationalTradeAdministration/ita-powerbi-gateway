require('dotenv').config()

const params = {
    "authorityUrl": "https://login.microsoftonline.com/common/",
    "resourceUrl": "https://analysis.windows.net/powerbi/api",
    "apiUrl": "https://api.powerbi.com/",
    "appId": process.env.APP_ID,
    "workspaceId": process.env.WORKSPACE_ID,
    "username": process.env.RPT_USERNAME,
    "password": process.env.RPT_PASSWORD
};

exports.params = params;