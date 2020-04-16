require('dotenv').config()

const params = {
  authorityUrl: 'https://login.microsoftonline.com/common/',
  resourceUrl: 'https://analysis.usgovcloudapi.net/powerbi/api',
  apiUrl: 'https://api.powerbigov.us/',
  tenantId: process.env.TENANT_ID,
  clientId: process.env.CLIENT_ID,
  clientSecret: process.env.CLIENT_SECRET
}

exports.params = params
