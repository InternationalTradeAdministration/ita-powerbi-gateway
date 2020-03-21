const express = require('express')
const router = express.Router()
const reporingController = require('./controllers/reporting.js')

router.get('/list-reports', reporingController.listReports)
router.get('/get-report-by-id', reporingController.getReportById)
router.post('/get-report-by-name', reporingController.getReportByName)

module.exports = router
