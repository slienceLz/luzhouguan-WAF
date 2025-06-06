var express = require('express');
var router = express.Router();
var db = require('../../mariadb.js');

router.get('/', function (req, res, next) {
    var pageNum = req.query.page;
    var like = req.query.like_file_rule || req.query.selectVal;

    if (req.query.like_file_rule) {
        db.query(`select * from File_Sensitive where keyword like '%${req.query.like_file_rule}%'`, function (err, data) {
            var pager = {};
            // 当前页数
            pager.pageCurrent = pageNum || 1;
            // 日志总条数
            pager.maxNum = data.length;
            // 每页显示条数
            pager.pageSize = 10;
            // 日志总页数
            pager.pageCount = parseInt(Math.ceil(pager.maxNum / pager.pageSize));
            // 修改传递的数据数量
            var dataList = data.slice((pager.pageCurrent - 1) * pager.pageSize, (pager.pageCurrent - 1) * pager.pageSize + pager.pageSize);

            if (err) {
                throw err;
            } else {
                res.render('File_Rule', {
                    File_Rule: dataList,
                    pager: pager,
                });
            }
        })
    } else if (req.query.selectVal) {
        db.query(`select * from File_Sensitive where id='${req.query.selectVal}'`, function (err, data) {
            var pager = {};
            // 当前页数
            pager.pageCurrent = pageNum || 1;
            // 日志总条数
            pager.maxNum = data.length;
            // 每页显示条数
            pager.pageSize = 10;
            // 日志总页数
            pager.pageCount = parseInt(Math.ceil(pager.maxNum / pager.pageSize));
            // 修改传递的数据数量
            var dataList = data.slice((pager.pageCurrent - 1) * pager.pageSize, (pager.pageCurrent - 1) * pager.pageSize + pager.pageSize);

            if (err) {
                throw err;
            } else {
                res.render('File_Rule', {
                    File_Rule: dataList,
                    pager: pager,
                });
            }
        })
    }
});

module.exports = router;