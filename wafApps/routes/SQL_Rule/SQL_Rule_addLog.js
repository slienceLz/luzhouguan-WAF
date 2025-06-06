var express = require('express');
var db = require('../../mariadb.js');
var router = express.Router();
var multiparty = require('multiparty');

router.post('/', function (req, res, next) {
    var form = new multiparty.Form();
    form.parse(req, function (err, fields, files) {
        var idNum = fields.idNum[0];
        var keyWord = fields.keyWord[0];

        db.query('insert into SQL_Sensitive value(?,?)', [idNum, keyWord], function (err, data) {
            if (err) {
                throw err;
            } else {
                var pageNum = req.query.page;

                db.query('select * from SQL_Sensitive', function (err, data) {
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
                        res.render('SQL_Rule', {
                            SQL_Rule: dataList,
                            pager: pager,
                        });
                    }
                })
            }
        })
    })
});

module.exports = router;