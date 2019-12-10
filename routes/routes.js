var express = require('express');
var router = express.Router();
var reporing_controller = require('./controllers/reporting.js');

router.get("/list-reports", reporing_controller.listReports);
router.get("/get-report", reporing_controller.getReport);
router.get("/generate-embed-token", reporing_controller.generateEmbedToken);

module.exports = router;
