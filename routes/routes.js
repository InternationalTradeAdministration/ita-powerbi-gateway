const express = require('express')
const router = express.Router()
const reporingController = require('./controllers/reporting.js')

router.get('/list-groups', reporingController.listGroups)
router.post('/list-reports', reporingController.listReports)
router.post('/get-report', reporingController.getReport)

module.exports = router
