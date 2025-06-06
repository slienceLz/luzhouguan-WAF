from db import mariadb_init


def sql_intercept_attack(logs):
    conn = mariadb_init()
    cursor = conn.cursor()
    sql = "INSERT INTO SQL_Logs (date, source_ip, target_url, data) VALUES (%s, %s, %s, %s)"
    cursor.execute(sql, logs)
    conn.commit()

def xss_intercept_attack(logs):
    conn = mariadb_init()
    cursor = conn.cursor()
    xss = "INSERT INTO XSS_Logs (date, source_ip, target_url, data) VALUES (%s, %s, %s, %s)"
    cursor.execute(xss, logs)
    conn.commit()

def fileInclude_intercept_attack(logs):
    conn = mariadb_init()
    cursor = conn.cursor()
    fileInclude = "INSERT INTO File_Logs (date, source_ip, target_url, data) VALUES (%s, %s, %s, %s)"
    cursor.execute(fileInclude, logs)
    conn.commit()

def xxe_intercept_attack(logs):
    conn = mariadb_init()
    cursor = conn.cursor()
    xxe = "INSERT INTO XXE_Logs (date, source_ip, target_url, data) VALUES (%s, %s, %s, %s)"
    cursor.execute(xxe, logs)
    conn.commit()