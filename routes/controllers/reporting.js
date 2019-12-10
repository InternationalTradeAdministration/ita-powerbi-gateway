var utils = require('../../services/utils.js');
var auth = require('../../services/authentication.js');
var axios = require('axios')

exports.get_powerBI_token = (req, res) => {
  utils.validateConfig()
  res.json(["Vango", "Is", "Cool"]);
};

exports.list_reports = async (req, res, next) => {
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
  const reportsResponse = await axios({
    url: requestParams.url,
    method: requestParams.options.method,
    headers: requestParams.options.headers
  });
  return res.json(reportsResponse.data);
};

exports.get_report = async (req, res, next) => {
  if (!req.query.reportId) {
    res.json("Please pass a reportId on the query string")
    return res;
  }

  const validationResults = utils.validateConfig();
  if (validationResults) {
    console.log("error: " + validationResults);
  }

  tokenResponse = await auth.getAuthenticationToken();
  if (('' + tokenResponse).indexOf('Error') > -1) {
    console.log('' + tokenResponse);
    return;
  }

  var token = tokenResponse.accessToken;
  var requestParams = utils.createGetReportRequestParams(token, req.query.reportId)
  const resonse = await utils.sendGetReportRequestAsync(requestParams.url, requestParams.options)
  return res.json(resonse)
};

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