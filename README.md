# 卤肘罐WAF

🎯 一个轻型Web应用代理防火墙，本人2024毕业设计作品。

🎯 A lightweight web application proxy firewall, my 2024 graduation project.

---

## ⚙️ 环境要求(Environmental requirements)：

- LAMP: Linux(CentOS7.9) Apache2 Mariadb PHP
- Python > 3.6

```bash
# 安装依赖：
pip install -r requirements.txt

# Start：
sudo systemctl start firewalld
./install_waf.sh

# Plan update:
# (1) Add a backend blacklist page.
# (2) Resolve IP addresses, obtain province names, and improve the attack area distribution map on the data overview interface. (Cancel)
# (3) Add XXE interception rules.

# describe：
# If you want to enable the blacklist blocking function, please remove the comments on lines 29-34 in black_List.exe.