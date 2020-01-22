var utils = require('../../services/utils.js');
var auth = require('../../services/authentication.js');
var axios = require('axios')

exports.listReports = async (req, res, next) => {
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

exports.getReport = async (req, res, next) => {
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

exports.generateEmbedToken = async (req, res) => {
  if (!req.query.reportId) {
    res.json("Please pass a reportId on the query string")
    return res;
  }

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
  var authHeader = utils.getAuthHeader(token);
  var headers = {
    'Authorization': authHeader,
    'Content-Type': 'application/json',
  };

  var options = {
    headers: headers,
    method: 'POST',
    body: JSON.stringify({ "accessLevel": "View" })
  };

  const response = await utils.sendGenerateEmbedTokenRequestAsync(req.query.reportId, options);
  return res.json(response) 
}
