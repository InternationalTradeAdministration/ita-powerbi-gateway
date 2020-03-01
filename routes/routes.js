const express = require('express')
const router = express.Router()
const reporingController = require('./controllers/reporting.js')

router.get('/list-reports', reporingController.listReports)
router.get('/get-report', reporingController.getReport)
router.get('/generate-embed-token', reporingController.generateEmbedToken)

module.exports = router
