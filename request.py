from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, unquote
import urllib.parse
import http.client
import socket
import io
from judge import is_sql_injection, is_xss_attack, is_fileInclude_attack, is_xxe_attack, traffic_normal
from intercept import sql_intercept_attack, xss_intercept_attack, fileInclude_intercept_attack, xxe_intercept_attack
from db import mariadb_init
import datetime
from termcolor import cprint
import logging
import subprocess
from black_List import attack_black, get_attackIp
from functions import Http_Server_Input, Http_Server_Output


class ProxyHTTPRequestHandler(BaseHTTPRequestHandler):
    def par_GET(self):
        logs = []
        # 从请求行中提取路径和查询参数
        date = str(datetime.datetime.now())
        source_ip = str(self.client_address)
        parsed_url = urlparse(self.path)
        path = parsed_url.path
        data = unquote(parsed_url.query)

        if data != {}:
            logs = [date, source_ip, path, data]
            return logs
        else:
            return None
    
    def par_POST(self):
        logs = []

        # 获取 POST 数据
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode('utf-8')

        # 整理 POST 数据
        date = str(datetime.datetime.now())
        source_ip = str(self.client_address)
        target_url = self.headers.get('Referer')
        data = post_data
        data = urllib.parse.unquote(data)
        
        logs = [date, source_ip, target_url, data]

        return logs

    def do_GET(self):
        logs = self.par_GET()
        if self.use_judge(logs) == True:
            self.redirect()
        else:
            # 转发请求到 Apache Web 服务器
            traffic_normal()
            self.forward_request()
    
    def do_POST(self):
        logs = self.par_POST()

        # 获取 POST 数据
        post_data = logs[3]

        if self.use_judge(logs) == True:
            self.redirect()
        else:
            logs = self.par_GET()
            if self.use_judge(logs) == True:
                self.redirect()
            else:
                # 转发请求到 Apache Web 服务器
                traffic_normal()
                self.forward_request(post_data)

    def use_judge(self, logs=[]):
        sql_bools = is_sql_injection(logs[3])
        xss_bools = is_xss_attack(logs[3])
        file_bools = is_fileInclude_attack(logs[3])
        xxe_bools = is_xxe_attack(logs[3])

        if sql_bools == True:
            sql_intercept_attack(logs)
            self.redirect()
            attackIp = get_attackIp(logs[1])
            attack_black(attackIp.group(1))
            return True
        elif xss_bools == True:
            xss_intercept_attack(logs)
            self.redirect()
            attackIp = get_attackIp(logs[1])
            attack_black(attackIp.group(1))
            return True
        elif file_bools == True:
            fileInclude_intercept_attack(logs)
            self.redirect()
            attackIp = get_attackIp(logs[1])
            attack_black(attackIp.group(1))
            return True
        elif xxe_bools == True:
            xxe_intercept_attack(logs)
            self.redirect()
            attackIp = get_attackIp(logs[1])
            attack_black(attackIp.group(1))
            return True
        else:
            return False

    def forward_request(self, post_data=None):
        # Apache Web 服务器的地址和端口
        Server_info = Http_Server_Output()
        apache_host = Server_info.get("Ip")
        apache_port = Server_info.get("Port")

        # 创建与 Apache Web 服务器的连接
        connection = http.client.HTTPConnection(apache_host, apache_port)

        # 构建转发请求
        forwarded_path = self.path
        if self.headers.get('Host'):
            forwarded_path = f"http://{self.headers['Host']}{forwarded_path}"

        # 将原始请求转发给 Apache Web 服务器
        connection.request(
            self.command,
            forwarded_path,
            body=io.BytesIO(post_data.encode('utf-8')) if post_data else None,
            headers=self.headers
        )

        # 获取 Apache Web 服务器的响应
        response = connection.getresponse()

        # 将 Apache Web 服务器的响应发送回客户端
        self.send_response(response.status)
        for header, value in response.getheaders():
            self.send_header(header, value)
        self.end_headers()
        self.wfile.write(response.read())

        # 关闭连接
        connection.close()
    
    def redirect(self):
        self.send_response(301)  # 301 重定向
        self.send_header('Location', '/templates/404.html')  # 设置重定向的目标 URL
        self.end_headers()  # 结束 HTTP 头部的发送

def get_loacl_ip():
    ip = Http_Server_Output()["Ip"]
    return ip

# 启动代理服务器
def run(server_class=HTTPServer, handler_class=ProxyHTTPRequestHandler, port=8000):
    server_address = ('', port)
    logging.basicConfig(filename='server.log', level=logging.INFO)

    httpd = server_class(server_address, handler_class)
    cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + f"[DONE] Starting proxy server on http://{get_loacl_ip()}:{port} ...", "green")
    cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + f"[+] Dashbord server is start ...", "magenta")
    subprocess.Popen('./wafApps/bin/www', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + f"[DONE] Dashbord is opening on http://{get_loacl_ip()}:9558/admin ...", "green")
    cprint("The program is continuously running ...", "cyan")
    print("↓↓↓↓↓↓ ↓↓↓↓↓↓ Running Informations ↓↓↓↓↓↓ ↓↓↓↓↓↓")
    httpd.serve_forever()


if __name__ == '__main__':
    try:
        mariadb_init()
        Http_Server_Input("Please enter the IP address of Apache2 server")
        cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + f"[+] Proxy server is start ...", "magenta")
        run()
    except KeyboardInterrupt as e:
        cprint('\n[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + '[+] Service is Stoping ...', "magenta")
        cprint('[' + str(datetime.datetime.now()) + ']' + '  INFO:    ' + '[DONE] Thank you for using ...', "green")