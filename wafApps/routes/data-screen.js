var express = require('express');
var router = express.Router();
var db = require('../mariadb.js');

router.get('/', function (req, res, next) {
    db.query('SELECT * FROM Traffic_Statistics', function (err, data) {
        if (err) {
            console.error(err);
            return res.status(500).send('Error occurred');
        }

        res.render('data-screen', { trafficData: data });
    });
});

module.exports = router;
