var express = require('express');
var router = express.Router();
var db = require('../../mariadb.js');
var multiparty = require('multiparty');

router.post('/', function (req, res, next) {
    var form = new multiparty.Form();
    form.parse(req, function (err, fields, files) {
        var upId = fields.upId[0];
        var dateTime = fields.dateTime[0];
        var sourceIp = fields.sourceIp[0];
        var targetUrl = fields.targetUrl[0];
        var textInfo = fields.textInfo[0];

        db.query(`update XSS_Logs set id=?,date=?,source_ip=?,target_url=?,data=? where id=${upId}`, [upId, dateTime, sourceIp, targetUrl, textInfo], function (err, data) {
            if (err) {
                throw err;
            } else {
                var pageNum = req.query.page;

                db.query('select * from XSS_Logs', function (err, data) {
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
                        res.render('XSS_List', {
                            XSS_List: dataList,
                            pager: pager,
                        });
                    }
                })
            }
        })
    })
});

module.exports = router;