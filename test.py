import subprocess
import re
from db import mariadb_init

attackIp = '1.119.138.132'


flag_sql = "select * from Black_List where attackIp=(%s)"
conn = mariadb_init()
cursor = conn.cursor()
cursor.execute(flag_sql, attackIp)
result = cursor.fetchone()

print(result[1])
print(type(result[1]))

print(result[3])
print(type(result[3]))