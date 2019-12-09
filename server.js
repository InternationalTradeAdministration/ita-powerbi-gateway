const express = require('express');

const PORT = 8080;
const HOST = '0.0.0.0';

var utils = require(__dirname + '/utils.js');
var auth = require(__dirname + '/authentication.js');
var axios = require('axios');

// App
const app = express();

app.use(express.static('public'))

app.get("/api/getPowerBI-token", (req, res, next) => {
  utils.validateConfig()
  res.json(["Vango", "Is", "Cool"]);
});

app.get("/api/reports", async (req, res, next) => {
  const validationResults = utils.validateConfig();
  if (validationResults) {
    console.log("error: " + validationResults);
    return;
  }

  tokenResponse = await auth.getAuthenticationToken();
  if (('' + tokenResponse).indexOf('Error') > -1) {
    console.log('' + tokenResponse);
    return;
  }

  const requestParams = utils.getReports(tokenResponse.accessToken);
  // const resonse = await utils.sendGetReportRequestAsync(requestParams.url, requestParams.options)
  const reportsResponse = await axios({
    url: requestParams.url,
    method: requestParams.options.method,
    headers: requestParams.options.headers
  });
  return res.json(reportsResponse.data);
});

app.get("/api/report", async (req, res, next) => {
  //console.log(req.query.reportId)

  const validationResults = utils.validateConfig();
  if (validationResults) {
    console.log("error: " + validationResults);
    return;
  }

  tokenResponse = await auth.getAuthenticationToken();
  if (('' + tokenResponse).indexOf('Error') > -1) {
    console.log('' + tokenResponse);
    return;
  }

  var token = tokenResponse.accessToken;
  var requestParams = utils.createGetReportRequestParams(token)
  const resonse = await utils.sendGetReportRequestAsync(requestParams.url, requestParams.options)
  return res.json(resonse)
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);


// async function generateEmbedToken(){
//     // validate configuration info
//     res = utils.validateConfig();
//     if(res){
//        console.log("error: "  + res);
//        return;
//     }

//     // get aad token to use for sending api requests
//     tokenResponse = await auth.getAuthenticationToken();
//     if(('' + tokenResponse).indexOf('Error') > -1){
//         console.log('' + tokenResponse);
//         return;
//     }

//     var token = tokenResponse.accessToken;
//     var authHeader = utils.getAuthHeader(token);

//     // get report id to use in GenerateEmbedToken requestd
//     var reportId;
//     if(!config.reportId){
//         console.log("Getting default report from workspace for generating embed token...")

//         var reportParams = utils.createGetReportRequestParams(token)
//         reportResp = await utils.sendGetReportRequestAsync(reportParams.url, reportParams.options);
//         if(!reportResp) {
//             return;
//         }
//         reportId = reportResp.id
//     } else{
//         reportId = config.reportId;
//     } 

//     var headers = {
//         'Authorization': authHeader,
//         'Content-Type': 'application/json',        
//     };

//     var options = {
//             headers: headers,
//             method: 'POST',
//             body: JSON.stringify({"accessLevel": "View"})
//     };

//     var url = config.apiUrl + 'v1.0/myorg/groups/' + config.workspaceId + '/reports/' + reportId + '/GenerateToken';

//     // generate powerbi embed token to use for embed report.
//     // the returned token will be printed to console.
//     return await utils.sendGenerateEmbedTokenRequestAsync(url, options);
// }

// async function generateEmbedTokenWithRls(username, roles){
//     // validate configuration info
//     res = utils.validateConfig();
//     if(res){
//        console.log("error: "  + res);
//        return;
//     }

//     // get aad token to use for sending api requests
//     tokenResponse = await auth.getAuthenticationToken();
//     if(('' + tokenResponse).indexOf('Error') > -1){
//         console.log('' + tokenResponse);
//         return;
//     }

//     var token = tokenResponse.accessToken;
//     var authHeader = utils.getAuthHeader(token);

//     // getting report id to use in GenerateEmbedToken requestd
//     var reportParams = utils.createGetReportRequestParams(token);
//     reportResp = await utils.sendGetReportRequestAsync(reportParams.url, reportParams.options);
//     var reportId = reportResp.id;

//     //getting dataset for effective identity
//     var datasetId = reportResp.datasetId;
//     var datasetResp = await utils.sendGetDatasetRequestAsync(token, datasetId);

//     if(!datasetResp.isEffectiveIdentityRequired){
//         console.log("error: the given dataset doesn't support rls");
//         return;
//     }

//     // creating effective identity
//     var identities = [
//         {
//             'username' : username,
//             'roles' : roles,
//             'datasets' : [datasetId]
//         }
//     ];

//     var body = {
//         "accessLevel": "View",
//         "identities": identities
//     }

//     var headers = {
//         'Authorization': authHeader,
//         'Content-Type': 'application/json',       
//     };

//     var options = {
//             headers: headers,
//             method: 'POST',
//             body: JSON.stringify(body)
//     };

//     var url = config.apiUrl + 'v1.0/myorg/groups/' + config.workspaceId + '/reports/' + reportId + '/GenerateToken';

//     // generate powerbi embed token, with the specified effective identity, to use for embed report.
//     // the returned token will be printed to console.
//     return await utils.sendGenerateEmbedTokenRequestAsync(url, options);
// }