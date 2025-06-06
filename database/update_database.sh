#!/bin/bash

# 设置数据库用户名和密码
DB_USER="root"
DB_PASSWORD="!QAZ2wsx"
DATABASE="waf_rules"

# 删掉旧的SQL文件
rm -rf waf_rules.sql

# 置空日志数据
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; delete from SQL_Logs;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; delete from XSS_Logs;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; delete from File_Logs;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; delete from XXE_Logs;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; delete from Black_List;" -s

mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; alter table SQL_Logs auto_increment=1;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; alter table XSS_Logs auto_increment=1;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; alter table File_Logs auto_increment=1;" -s
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; alter table XXE_Logs auto_increment=1;" -s

mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "use waf_rules; update Traffic_Statistics set normal=0, malice=0;" -s

# 导出新的SQL文件
mysqldump -u root -p waf_rules > waf_rules.sql