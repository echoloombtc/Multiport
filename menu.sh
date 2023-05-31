#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="kenDevXD"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
#Domain
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
WKT=$(curl -s ipinfo.io/timezone)
IPVPS=$(curl -s ipinfo.io/ip)
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# USERNAME
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
# Order ID
rm -f /usr/bin/ver
user=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}')
echo "$user" >/usr/bin/ver
# validity
rm -f /usr/bin/e
valid=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
echo "$valid" >/usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf )
clear
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}$version${Font_color_suffix}"
Info2="${Green_font_prefix} Latest Version ${Font_color_suffix}"
Error=" Version ${Green_font_prefix}[$ver]${Font_color_suffix} Available${Red_font_prefix}[Update]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf | grep $version )
#Status Version
if [ $version = $new_version ]; then
stl="${Info2}"
else
stl="${Error}"
fi
clear
# Getting CPU Information
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/root/t1
bulan=$(date +%b)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /root/t1)" != '0' ]; then
    bulan=$(date +%b)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $10}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $4}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $7}')
else
    bulan=$(date +%Y-%m)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $8}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $2}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /root/t1)" != '0' ]; then
    yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
    yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
    yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
    yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
    yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
    yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
    yesterday=NULL
    yesterday_v=NULL
    yesterday_rx=NULL
    yesterday_rxv=NULL
    yesterday_tx=NULL
    yesterday_txv=NULL
fi

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Registered)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=$(date -d "0 days" +"%Y-%m-%d")
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
xtls=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
trtls=$(grep -c -E "^#trx " "/usr/local/etc/xray/tcp.json")
# TOTAL ACC CREATE  TROJAN WS TLS
trws=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e "\e[032;1mCPU Model:\e[0m $cname"
echo -e "\e[032;1mNumber Of Cores:\e[0m $cores"
echo -e "\e[032;1mCPU Frequency:\e[0m $freq MHz"
echo -e "\e[032;1mTotal Amount Of RAM:\e[0m $tram MB"
echo -e "\e[032;1mSystem Uptime:\e[0m $uptime"
echo -e "\e[032;1mIsp Name:\e[0m $ISP"
echo -e "\e[032;1mCity:\e[0m $CITY"
echo -e "\e[032;1mTime:\e[0m $WKT"
echo -e "\e[033;1mIPVPS:\e[0m $IPVPS"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "   \e[$text Traffic${NC}      \e[${text}Today       Yesterday       Month   "
echo -e "   \e[$text Download${NC}   \e[${text}$today_tx $today_txv      $yesterday_tx $yesterday_txv      $month_tx $month_txv   \e[0m"
echo -e "   \e[$text Upload${NC}     \e[${text}$today_rx $today_rxv      $yesterday_rx $yesterday_rxv      $month_rx $month_rxv   \e[0m"
echo -e "   \e[$text Total${NC}    \e[${text}  $todayd $today_v     $yesterday $yesterday_v      $month $month_v  \e[0m "
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e " \e[$text   Ssh/Ovpn  Vmess  Vless  VlessXtls  Trojan-Ws  Trojan-Tls \e[0m "    
echo -e " \e[$below      $total_ssh        $vmess      $vless       $xtls          $trws          $trtls \e[0m "
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                        \e[30m[\e[$box PANEL MENU\e[30m ]\e[1m                      \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$number (•1)\e[m \e[$below XRAY VMESS & VLESS\e[m"
echo -e "  \e[$number (•2)\e[m \e[$below TROJAN XRAY & WS\e[m"
echo -e "  \e[$number (•3)\e[m \e[$below OPENSSH & OPENVPN\e[m" 
echo -e "  \e[$number (•4)\e[m \e[$below XRAY BUG \e[m"
echo -e "  \e[$number (•5)\e[m \e[$below SYSTEM MENU\e[m"
echo -e "  \e[$number (•6)\e[m \e[$below CHECK RUNNING\e[m"
echo -e "  \e[$number (•7)\e[m \e[$below CHANGE PORT\e[m"
echo -e "  \e[$number (•8)\e[m \e[$below REBOOT VPS\e[m
echo -e "  \e[$number (•9)\e[m \e[$below MENU THEMES\e[m"
echo -e "  \e[$number (10)\e[m \e[$below REGIP ADMIN ONLY\e[m"
echo -e "  \e[$number (11)\e[m \e[$below INFO ALL PORT\e[m"
echo -e "  \e[$number (12)\e[m \e[$below CLEAR LOG VPS\e[m"
echo -e ""
echo -e "  \e[$below[Ctrl + C] For exit from main menu\e[m"
echo -e "  \e[32mContact @aixxy7 t.me/aixxy7\e[m"
echo -e ""
echo -e "\e[$below "
read -p " Select menu :  " menu
echo -e ""
case $menu in
1)
    xraay
    ;;
2)
    trojaan 
    ;;
3)
    ssh
    ;;
4)
    maxisdigi
    ;;
5)
    system
    ;;
6)
    check-sc
    ;;
7)
    change-port
    ;;
8)
    reboot
    ;;
9)
    themes
    ;;
10)
    addip
    ;;
11)
    about
    ;;
12)
    clear-log
    ;;
x)
    clear
    exit
    echo -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
    ;;
*)
    clear
    echo -e "\e[1;31mPlease enter an correct number\e[0m"
    sleep 1
    menu
    ;;
esac