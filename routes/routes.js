var express = require('express');
var router = express.Router();
var reporing_controller = require('./controllers/reporting.js');

router.get("/get-powerBI-token", reporing_controller.get_powerBI_token);
router.get("/list-reports", reporing_controller.list_reports);
router.get("/get-report", reporing_controller.get_report);

module.exports = router;
