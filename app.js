const express = require('express')
const utils = require('./services/utils.js')
const routes = require('./routes/routes.js')
const app = express()

const validationResults = utils.validateConfig()
if (validationResults) {
  console.log(validationResults)
  app.close()
}

const PORT = (process.env.NODE_ENV !== 'production') ? 8080 : 80
const HOST = '0.0.0.0'

app.use(express.static('public'))
app.use('/api', routes)
app.listen(PORT, HOST)

console.log(`Running on http://${HOST}:${PORT}`)
