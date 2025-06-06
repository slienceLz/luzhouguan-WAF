var mariadb = require('mysql')
var db = mariadb.createConnection({
    host: 'localhost',
    user: 'root',
    password: '!QAZ2wsx',
    database: 'waf_rules'
});

db.connect();

module.exports = db;