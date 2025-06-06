#!/bin/bash

echo -e "\e[31m
╔════════════════════════════════════════════════════════════╗
║   __      ________    __        _____                      ║
║  /\ \    /\_____  \  /\ \      /\___ \\                     ║
║  \ \ \   \/____//'/' \ \ \     \/__/\ \\                    ║
║   \ \ \  __   //'/'   \ \ \  __  _ \ \ \\                   ║
║    \ \ \L\ \ //'/'___  \ \ \L\ \ /\ \_\ \\                  ║
║     \ \____/ /\_______\ \ \____/ \ \____/                  ║
║      \/___/  \/_______/  \/___/   \/___/   exploit by @Lhk ║
║                                                            ║
║ If you have any questions while using the product,         ║
║ please send me an email slience_lhk@163.com                ║
╚════════════════════════════════════════════════════════════╝\e[0m
"
echo "↓↓↓↓↓↓ ↓↓↓↓↓↓ Installation Informations ↓↓↓↓↓↓ ↓↓↓↓↓↓"

# ==================================获取时间--开始==================================
# 获取当前时间，包括秒和纳秒
current_time=$(date +"%Y-%m-%d %H:%M:%S.%N")

# 提取秒和纳秒部分
seconds=$(echo "$current_time" | awk -F'.' '{print $1}') # 获取秒部分
nanoseconds=$(echo "$current_time" | awk -F'.' '{print $2}') # 获取纳秒部分

# 截取纳秒部分的前六位数字
formatted_nanoseconds=$(echo "${nanoseconds:0:6}")

# 输出格式化后的时间，包括六位的纳秒部分
# echo -e "\e[31m$seconds.$formatted_nanoseconds\e[0m"
# ==================================获取时间--结束==================================


# ==================================创建数据库--开始==================================
# 设置数据库用户名和密码
DB_USER="root"
DB_PASSWORD="!QAZ2wsx"
DATABASE="waf_rules"

# 连接到 MySQL，检查数据库是否存在
result=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$DATABASE';" -s)
if [ "$result" = "$DATABASE" ]; then
    echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Database $DATABASE already exists ...\e[0m"
else
    # 创建数据库
    mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE $DATABASE;"
    mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DATABASE" < ./database/waf_rules.sql
    if [ $? -eq 0 ]; then
        echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Database $DATABASE created successfully ...\e[0m"
    else
        echo "Failed to create database $DATABASE."
        # 导入 SQL 文件
        exit 1
    fi
fi
# ==================================创建数据库--结束==================================


# ==================================安装node环境--开始==================================
result=$(/usr/local/bin/node -v)
node_put="v14.6.0"
if [ "$result" = "$node_put" ]; then
    echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Node is installed ...\e[0m"
else
    echo "↑↑↑ Test information, please ignore ↑↑↑"
    echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Node is installing ...\e[0m"
    cd ./install/node-v14.6.0-linux-x64/
    cp -R * /usr/local/
    cd ../../wafApps/
    npm install
    cd ..
    echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Node installed successfully ...\e[0m"
fi
# ==================================安装node环境--结束==================================


# ==================================防火墙规则--结束==================================
result=$(firewall-cmd --list-forward-ports)
firewall_rule="port=80:proto=tcp:toport=8000:toaddr="
if [ "$result" = $firewall_rule ]; then
    echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Firewalld rules already exists ...\e[0m"
else
    firewall-cmd --zone=public --add-port=8000/tcp --permanent
    firewall-cmd --zone=public --add-port=9558/tcp --permanent
    firewall-cmd --zone=public --add-port=3306/tcp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8000
    echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Firewalld rules created successfully ...\e[0m"
fi
# ==================================防火墙规则--结束==================================


# ==================================防火墙规则--结束==================================
echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Moving the interception page ...\e[0m"
cp -r ./source/templates/ /var/www/html/
cp -r ./source/imgs/ /var/www/html/
echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Interception page moved successfully ...\e[0m"
# =================防火墙规则--结束=================


# ==================================运行程序--开始==================================
echo -e "\e[35m[$seconds.$formatted_nanoseconds]  INFO:    [+] Install python modules ...\e[0m"
pip3 install -r requirement.txt
echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Python modules installed successfully ...\e[0m"
python3 request.py
# ==================================运行程序--结束==================================
