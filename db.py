import pymysql
import datetime
from termcolor import cprint


try:
    def mariadb_init():
        conn = pymysql.connect(
            host='localhost',
            port=3306,
            db='waf_rules',
            user='root',
            passwd='!QAZ2wsx',
            charset='utf8'
        )
        if conn:
            # cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + '[DONE] Mariadb is connected ...' , 'green')
            return conn

    
except Exception as e:
    print(e)