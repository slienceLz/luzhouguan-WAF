import subprocess
import re
from db import mariadb_init


def get_attackIp(strings):
    pattern = r"'(.*?)'"
    attackIp = re.search(pattern, strings)

    return attackIp

def attack_black(attackIp):
    conn = mariadb_init()
    cursor = conn.cursor()

    select_sql = "select * from Black_List where attackIp=(%s)"
    count = cursor.execute(select_sql, attackIp)
    result = cursor.fetchall()

    if result:
        update_sql = "update Black_List set attackNum=attackNum+1 where attackIp=(%s)"
        cursor.execute(update_sql, attackIp)
        conn.commit()

        # 判断攻击次数，每攻击10次，将封禁IP1分钟。
        flag_sql = "select * from Black_List where attackIp=(%s)"
        cursor.execute(flag_sql, attackIp)
        result = cursor.fetchone()
        if result[1] % 10 == 0 and result[3] == 1:
            command = f"sudo firewall-cmd --zone=public --add-rich-rule='rule family='ipv4' source address='{attackIp}' port protocol='tcp' port='8000' reject' --timeout=1m"
            process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            process.wait()

            or_sql = ""

    else:
        insert_sql = "insert into Black_List (attackIp, attackNum) values (%s, 1)"
        cursor.execute(insert_sql, attackIp)
        conn.commit()