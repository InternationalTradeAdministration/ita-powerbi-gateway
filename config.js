const params = {
    "authorityUrl": "https://login.microsoftonline.com/common/",
    "resourceUrl": "https://analysis.windows.net/powerbi/api",
    "apiUrl": "https://api.powerbi.com/",
    "appId": process.env.APP_ID,
    "workspaceId": process.env.WORKSPACE_ID,
    "reportId": process.env.REPORT_ID,
    "username": process.env.USERNAME,
    "password": process.env.PASSWORD
};

exports.params = params;