kill -9 `netstat -ntlp | grep :9558 | awk '{print $7}' | cut -d'/' -f1`
kill -9 `netstat -ntlp | grep :8000 | awk '{print $7}' | cut -d'/' -f1`

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

echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [+] Service is Stoping ...\e[0m"
echo -e "\e[32m[$seconds.$formatted_nanoseconds]  INFO:    [DONE] Thank you for using ...\e[0m"