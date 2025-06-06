import re
from db import mariadb_init
import base64
import html

def is_sql_injection(query):
    # flag = True 时，表示查询语句含有敏感字符
    flag = bool(False)
    query_base64_decode = None
    query_hex_decode = None
    conn = mariadb_init()
    cursor = conn.cursor()

    # base64 解码
    text_base64 = query
    # 以'&'和'='作为分隔符分割字符串
    parts = text_base64.split('&')
    for part in parts:
        sub_parts = part.split('=')
        encoded_part = sub_parts[1] if len(sub_parts) > 1 else sub_parts[0]
        try:
            weishu = len(encoded_part) % 4
            if weishu != 0:
                encoded_part = "".join([encoded_part, "="*(4 - weishu)])
            decoded_data = base64.b64decode(encoded_part)
            decoded_str = decoded_data.decode('utf-8')
            query_base64_decode = decoded_str
        except Exception as e:
            continue
    
    # hex 解码
    text_hex = query
    # 以'&'和'='作为分隔符分割字符串
    parts = text_hex.split('&')
    for part in parts:
        sub_parts = part.split('=')
        encoded_part = sub_parts[1] if len(sub_parts) > 1 else sub_parts[0]
        try:
            decoded_data = bytes.fromhex(encoded_part)
            decoded_str = decoded_data.decode('utf-8')
            query_hex_decode = decoded_str
        except Exception as e:
            continue

    # 查询数据库存放的SQL注入敏感词
    select_sql = "select keyword from SQL_Sensitive"
    count = cursor.execute(select_sql)
    result = cursor.fetchall()
    # 将查询的值以元组形式存储
    if result:
        keywords = tuple(row[0] for row in result)

    # 将前端返回的查询语句和敏感词进行匹配，如果匹配成功，将 flag 置为 True
    for keyword in keywords:
        # 将字符串格式编译成正则表达式对象
        keyword = re.compile(keyword, re.IGNORECASE)
        if keyword.search(query):
            flag = True
            traffic_malice()
            break
        elif query_base64_decode:
            if keyword.search(query_base64_decode):
                flag = True
                traffic_malice()
                break
        elif query_hex_decode:
            if keyword.search(query_hex_decode):
                flag = True
                traffic_malice()
                break

    return flag

def is_xss_attack(query):
    flag = bool(False)
    conn = mariadb_init()
    cursor = conn.cursor()

    # HTML 解码
    text_html = query
    decoded_html_str = html.unescape(text_html)

    # 八进制 解码
    text_8 = query
    encoded_8_str = re.findall(r'\\(\d{3})', text_8)
    encoded_8_str_combined = "".join([chr(int(octal_code, 8)) for octal_code in encoded_8_str])
    decoded_8_str = re.sub(r'\\(\d{3})', lambda x: chr(int(x.group(1), 8)), encoded_8_str_combined)

    # 十六进制 解码
    text_16 = query
    encoded_16_str = re.findall(r'\\x([0-9a-fA-F]{2})', text_16)
    encoded_16_str_combined = "".join([chr(int(hex_code, 16)) for hex_code in encoded_16_str])
    decoded_16_str = re.sub(r'\\x([0-9a-fA-F]{2})', lambda x: chr(int(x.group(1), 16)), encoded_16_str_combined)

    # 检查XSS敏感词
    select_xss = "select keyword from XSS_Sensitive"
    count = cursor.execute(select_xss)
    result = cursor.fetchall()
    # 将查询的值以元组形式存储
    if result:
        keywords = tuple(row[0] for row in result)
    
    # 将前端返回的请求语句和敏感词元组进行匹配，如果匹配成功，将 flag 置为 True
    for keyword in keywords:
        # 将字符串格式编译成正则表达式对象
        keyword = re.compile(keyword, re.IGNORECASE)
        if keyword.search(query):
            flag = True
            traffic_malice()
            break
        elif keyword.search(decoded_html_str):
            flag = True
            traffic_malice()
            break
        elif keyword.search(decoded_8_str):
            flag = True
            traffic_malice()
            break
        elif keyword.search(decoded_16_str):
            flag = True
            traffic_malice()
            break
    
    return flag

def is_fileInclude_attack(query):
    flag = bool(False)
    conn = mariadb_init()
    cursor = conn.cursor()

    # 检查fileInclude敏感词
    select_fileInclude = "select keyword from File_Sensitive"
    count = cursor.execute(select_fileInclude)
    result = cursor.fetchall()
    # 将查询的值以元组形式存储
    if result:
        keywords = tuple(row[0] for row in result)
    
    # 将前端返回的请求语句和敏感词元组进行匹配，如果匹配成功，将 flag 置为 True
    for keyword in keywords:
        # 将字符串格式编译成正则表达式对象
        keyword = re.compile(keyword, re.IGNORECASE)
        if keyword.search(query):
            flag = True
            traffic_malice()
            break

    return flag

def is_xxe_attack(query):
    flag = bool(False)
    conn = mariadb_init()
    cursor = conn.cursor()

    # 检查XXE敏感词
    selcet_xxe = "select keyword from XXE_Sensitive"
    count = cursor.execute(selcet_xxe)
    result = cursor.fetchall()
    # 将查询的值以元组形式存储
    if result:
        keywords = tuple(row[0] for row in result)
    
    # 将前端返回的请求语句和敏感词元组进行匹配，如果匹配成功，将 flag 置为 True
    for keyword in keywords:
        # 将字符串格式编译成正则表达式对象
        keyword = re.compile(keyword, re.IGNORECASE)
        if keyword.search(query):
            flag = True
            traffic_malice()
            break

    return flag

def traffic_normal():
    conn = mariadb_init()
    cursor = conn.cursor()

    sql = 'update Traffic_Statistics set normal=normal+1'
    cursor.execute(sql)
    conn.commit()

def traffic_malice():
    conn = mariadb_init()
    cursor = conn.cursor()

    sql = 'update Traffic_Statistics set malice=malice+1'
    cursor.execute(sql)
    conn.commit()