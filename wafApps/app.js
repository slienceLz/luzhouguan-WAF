var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var adminRouter = require('./routes/admin');
var left = require('./routes/left');
var right = require('./routes/right');
// data-screen
var data_screen = require('./routes/data-screen');
// SQL_List
var SQL_List = require('./routes/SQL_List/SQL_List');
var like_sql_list = require('./routes/SQL_List/like_sql_list');
var SQL_List_addLog = require('./routes/SQL_List/SQL_List_addLog');
var SQL_List_update = require('./routes/SQL_List/SQL_List_update');
var SQL_List_del = require('./routes/SQL_List/SQL_List_del');
// SQL_Rule
var SQL_Rule = require('./routes/SQL_Rule/SQL_Rule');
var like_sql_rule = require('./routes/SQL_Rule/like_sql_rule')
var SQL_Rule_addLog = require('./routes/SQL_Rule/SQL_Rule_addLog');
var SQL_Rule_update = require('./routes/SQL_Rule/SQL_Rule_update');
var SQL_Rule_del = require('./routes/SQL_Rule/SQL_Rule_del');
// XSS_List
var XSS_List = require('./routes/XSS_List/XSS_List');
var like_xss_list = require('./routes/XSS_List/like_xss_list');
var XSS_List_addLog = require('./routes/XSS_List/XSS_List_addLog');
var XSS_List_update = require('./routes/XSS_List/XSS_List_update');
var XSS_List_del = require('./routes/XSS_List/XSS_List_del');
// XSS_Rule
var XSS_Rule = require('./routes/XSS_Rule/XSS_Rule');
var like_xss_rule = require('./routes/XSS_Rule/like_xss_rule')
var XSS_Rule_addLog = require('./routes/XSS_Rule/XSS_Rule_addLog');
var XSS_Rule_update = require('./routes/XSS_Rule/XSS_Rule_update');
var XSS_Rule_del = require('./routes/XSS_Rule/XSS_Rule_del');
// File_List
var File_List = require('./routes/File_List/File_List');
var like_file_list = require('./routes/File_List/like_file_list');
var File_List_addLog = require('./routes/File_List/File_List_addLog');
var File_List_update = require('./routes/File_List/File_List_update');
var File_List_del = require('./routes/File_List/File_List_del');
// File_Rule
var File_Rule = require('./routes/File_Rule/File_Rule');
var like_file_rule = require('./routes/File_Rule/like_file_rule')
var File_Rule_addLog = require('./routes/File_Rule/File_Rule_addLog');
var File_Rule_update = require('./routes/File_Rule/File_Rule_update');
var File_Rule_del = require('./routes/File_Rule/File_Rule_del');
// XXE_List
var XXE_List = require('./routes/XXE_List/XXE_List');
var like_xxe_list = require('./routes/XXE_List/like_xxe_list');
var XXE_List_addLog = require('./routes/XXE_List/XXE_List_addLog');
var XXE_List_update = require('./routes/XXE_List/XXE_List_update');
var XXE_List_del = require('./routes/XXE_List/XXE_List_del');
// XXE_Rule
var XXE_Rule = require('./routes/XXE_Rule/XXE_Rule');
var like_xxe_rule = require('./routes/XXE_Rule/like_xxe_rule')
var XXE_Rule_addLog = require('./routes/XXE_Rule/XXE_Rule_addLog');
var XXE_Rule_update = require('./routes/XXE_Rule/XXE_Rule_update');
var XXE_Rule_del = require('./routes/XXE_Rule/XXE_Rule_del');
// Black_List
var Black_List = require('./routes/Black_List/Black_List');
var like_black_rule = require('./routes/Black_List/like_black_list')
var Black_List_addLog = require('./routes/Black_List/Black_List_addLog');
var Black_List_update = require('./routes/Black_List/Black_List_update');
var Black_List_del = require('./routes/Black_List/Black_List_del');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 首页
app.use('/admin', adminRouter);
// 左侧
app.use('/left', left);
// 右侧
app.use('/right', right);
// data-screen
app.use('/data-screen', data_screen);
// SQL_List
app.use('/SQL_List', SQL_List);
app.use('/like_sql_list', like_sql_list);
app.use('/SQL_List_addLog', SQL_List_addLog);
app.use('/SQL_List_del', SQL_List_del);
app.use('/SQL_List_update', SQL_List_update);
// SQL_Rule
app.use('/SQL_Rule', SQL_Rule);
app.use('/like_sql_rule', like_sql_rule);
app.use('/SQL_Rule_addLog', SQL_Rule_addLog);
app.use('/SQL_Rule_del', SQL_Rule_del);
app.use('/SQL_Rule_update', SQL_Rule_update);
// XSS_List
app.use('/XSS_List', XSS_List);
app.use('/like_xss_list', like_xss_list);
app.use('/XSS_List_addLog', XSS_List_addLog);
app.use('/XSS_List_del', XSS_List_del);
app.use('/XSS_List_update', XSS_List_update);
// XSS_Rule
app.use('/XSS_Rule', XSS_Rule);
app.use('/like_xss_rule', like_xss_rule);
app.use('/XSS_Rule_addLog', XSS_Rule_addLog);
app.use('/XSS_Rule_del', XSS_Rule_del);
app.use('/XSS_Rule_update', XSS_Rule_update);
// File_List
app.use('/File_List', File_List);
app.use('/like_File_List', like_file_list);
app.use('/File_List_addLog', File_List_addLog);
app.use('/File_List_del', File_List_del);
app.use('/File_List_update', File_List_update);
// File_Rule
app.use('/File_Rule', File_Rule);
app.use('/like_File_Rule', like_file_rule);
app.use('/File_Rule_addLog', File_Rule_addLog);
app.use('/File_Rule_del', File_Rule_del);
app.use('/File_Rule_update', File_Rule_update);
// XXE_List
app.use('/XXE_List', XXE_List);
app.use('/like_xxe_List', like_xxe_list);
app.use('/XXE_List_addLog', XXE_List_addLog);
app.use('/XXE_List_del', XXE_List_del);
app.use('/XXE_List_update', XXE_List_update);
// XXE_Rule
app.use('/XXE_Rule', XXE_Rule);
app.use('/like_xxe_Rule', like_xxe_rule);
app.use('/XXE_Rule_addLog', XXE_Rule_addLog);
app.use('/XXE_Rule_del', XXE_Rule_del);
app.use('/XXE_Rule_update', XXE_Rule_update);
// Black_List
app.use('/Black_List', Black_List)
app.use('/like_black_rule', like_black_rule);
app.use('/Black_List_addlog', Black_List_addLog);
app.use('/Black_List_update', Black_List_update);
app.use('/Black_List_del', Black_List_del);


// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
