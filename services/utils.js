var request = require('request');
var config = require('../config/config.js');

function getAuthHeader(accessToken) {
    var b = "Bearer ";
    return b.concat(accessToken);
}

function validateConfig() {
    var guid = require('guid');

    if (!config.params.appId) {
        return "ApplicationId is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js";
    }

    if (!guid.isGuid(config.params.appId)) {
        return "ApplicationId must be a Guid object. please register your application as Native app in https://dev.powerbi.com/apps and fill application Id in config.js";
    }

    if (!config.params.workspaceId) {
        return "WorkspaceId is empty. Please select a group you own and fill its Id in config.js";
    }

    if (!guid.isGuid(config.params.workspaceId)) {
        return "WorkspaceId must be a Guid object. Please select a workspace you own and fill its Id in config.js";
    }

    if (!config.params.authorityUrl) {
        return "AuthorityUrl is empty. Please fill valid AuthorityUrl under config.js";
    }

    if (!config.params.username || !config.params.username.trim()) {
        return "Username is empty. Please fill Power BI username in config.js";
    }

    if (!config.params.password || !config.params.password.trim()) {
        return "Password is empty. Please fill password of Power BI username in config.js";
    }
}

function createGetReportRequestParams(accessToken, reportId) {
    var authHeader = getAuthHeader(accessToken);
    var url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports/' + reportId;
    return queryApiWithAuthHeader(url, accessToken, authHeader)
}

function getReports(accessToken) {
    var authHeader = getAuthHeader(accessToken);
    var url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports';
    return queryApiWithAuthHeader(url, accessToken, authHeader);
}

function queryApiWithAuthHeader(url, accessToken, authHeader) {
    var authHeader = getAuthHeader(accessToken);
    var headers = {
        'Authorization': authHeader,
    };
    var options = {
        headers: headers,
        method: 'GET',
    };

    return {
        'url': url,
        'options': options
    };
}

async function sendGetReportRequestAsync(url, options) {
    let promise = () => {
        return new Promise(
            (resolve, reject) => {
                request(url, options, function (error, response, body) {
                    console.log("-----Get Report Results-----");
                    console.log('Request STATUS: ' + response.statusCode);
                    if (error) {
                        reject(error);
                    }
                    try {
                        getReportRes = JSON.parse(body)
                        console.log("Returned report name: " + getReportRes.name);
                        console.log("Returned report Id: " + getReportRes.id);
                        resolve(getReportRes);
                    } catch (e) { }
                });
            });
    }

    var res;
    await promise().then(
        reportResponse => res = reportResponse
    ).catch(
        err => res = err
    );
    return res;
}

async function sendGenerateEmbedTokenRequestAsync(reportId, options) {
    var url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports/' + reportId + '/GenerateToken';
    let promise = () => {
        return new Promise(
            (resolve, reject) => {
                request(url, options, function (error, response, body) {
                    console.log("-----Generate EmbedToken Results-----");
                    console.log('Request STATUS: ' + response.statusCode);
                    if (error) {
                        reject(error);
                    }
                    try {
                        generateEmbedTokenRes = JSON.parse(body)
                        console.log('Token Generated: ' + generateEmbedTokenRes.token);
                        resolve(generateEmbedTokenRes.token);
                    } catch (e) { }
                });
            });
    };

    var res;
    await promise().then(
        tokenResponse => res = tokenResponse
    ).catch(
        err => res = err
    );

    return res;
}

async function sendGetDatasetRequestAsync(token, datasetId) {
    authHeader = getAuthHeader(token);
    var headers = {
        'Authorization': authHeader,
    };
    var options = {
        headers: headers,
        method: 'GET',
    };
    var url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/datasets/' + datasetId;

    let promise = () => {
        return new Promise(
            (resolve, reject) => {
                request(url, options, function (error, response, body) {
                    console.log('Get dataset request STATUS: ' + response.statusCode);
                    if (error) {
                        reject(error);
                    }
                    try {
                        dataset = JSON.parse(body)
                        resolve(dataset);
                    } catch (e) {
                        reject(e)
                    }
                });
            });
    };

    var res;
    await promise().then(
        tokenResponse => res = tokenResponse
    ).catch(
        err => res = err
    );

    return res;
}

module.exports = {
    getAuthHeader: getAuthHeader,
    validateConfig: validateConfig,
    createGetReportRequestParams: createGetReportRequestParams,
    sendGetReportRequestAsync: sendGetReportRequestAsync,
    sendGenerateEmbedTokenRequestAsync: sendGenerateEmbedTokenRequestAsync,
    sendGetDatasetRequestAsync: sendGetDatasetRequestAsync,
    getReports: getReports
}