const express = require('express');
var routes = require('./routes/routes.js');

let PORT = (process.env.NODE_ENV !== 'production') ? 8080 : 80;
const HOST = '0.0.0.0';
const app = express();

app.use(express.static('public'))
app.use('/api', routes);
app.listen(PORT, HOST);

console.log(`Running on http://${HOST}:${PORT}`);