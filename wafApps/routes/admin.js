var express = require('express');
var router = express.Router();
var db = require('../mariadb.js');

/* GET admin page. */
router.get('/', function (req, res, next) {
    res.render('admin', { title: '登录' });
});

router.post('/dashbord', function (req, res, next) {
    var val = req.body;
    var userName = val.userName;
    var userPwd = val.userPwd;

    db.query('select * from Admin_Users where userName=? and userPwd=?', [userName, userPwd], function (err, data) {
        if (err) {
            throw err;
        } else if (data.length > 0) {
            res.render('dashbord');
        } else {
            res.render('error')
        }
    })
})

module.exports = router;