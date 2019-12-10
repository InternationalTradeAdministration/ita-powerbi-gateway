const express = require('express');
var routes = require('./routes/routes.js');

let PORT = 8080;
if (process.env.NODE_ENV === 'production') {
  PORT = 80
}

const HOST = '0.0.0.0';
const app = express();

app.use(express.static('public'))
app.use('/api', routes);
app.listen(PORT, HOST);

console.log(`Running on http://${HOST}:${PORT}`);