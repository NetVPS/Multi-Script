#!/bin/bash
 clear
 echo -e               "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                 ""\E[41;1;37m  << ACTIVACION Y DESACTIVACION TCP SPEED >>  \033[0m"
 echo -e               "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[41;1;37mSI ACTIVAS BBR DESACTIVA PRIMERO PARA ACTIVAR CUBIC Y BBR\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] • ACTIVAR TCP SPEED BBR\033[0m     ""\E[48;1;37m[3] • ACTIVAR TCP SPEED CUBIC\033[0m"
 echo -e "\E[48;1;37m[2] • DESACTIVAR TCP SPEED BBR\033[0m  ""\E[48;1;37m[4] • DESACTIVAR TCP SPEED CUBIC\033[0m"
 echo ""
 tput setaf 7 ; tput setab 4 ; tput bold ; printf '%0s%s%-0s' "SISTEMA TCP ACTIVO EN:" ; tput sgr0 ; tput setaf 5 ; tput bold ; printf '%0s%-1s>>%-1s' ; tput sgr0 ; tput setaf 7 ; tput setab 1 ; tput bold ; printf '%0s%0s%-0s'
 sysctl net.ipv4.tcp_congestion_control ; tput sgr0
 echo ""
 echo ""
 echo -e "\E[41;1;37mCAMBIA DNS DE GOOGLE A CLOUDFLARE CAMBIAR AL GUSTO EL DNS\033[0m"
 echo ""
 echo -e "\E[48;1;37m[5] • ACTIVAR DNS DE CLOUDFLARE\033[0m ""\E[48;1;37m[7] • ACTIVAR DNS DE GOOGLE\033[0m"
 echo -e "\E[48;1;37m[6] • DESACTIVAR DNS CLOUDFLARE\033[0m ""\E[48;1;37m[8] • DESACTIVAR DNS GOOGLE\033[0m"
 echo -e "\033[1;35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e "\E[48;1;37m[9] • ACTIVAR DNS DE OPENDNS\033[0m    ""\E[48;1;37m[11]• ACTIVAR DNS QUAD9\033[0m"
 echo -e "\E[48;1;37m[10]• DESACTIVAR DNS OPENDNS\033[0m    ""\E[48;1;37m[12]• DESACTIVAR DNS QUAD9\033[0m"
 echo -e "\033[1;35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e "\E[48;1;37m[13]• ACTIVAR ESTABLE DNS.WATCH\033[0m ""\E[48;1;37m[16]• ACTIVAR DNS NETFLIX Y JUEGOS\033[0m"
 echo -e "\E[48;1;37m[14]• DESACTIVAR EL DNS.WATCH\033[0m   ""\E[48;1;37m[17]• DESACTIVAR DNS NETFLIX Y JUEGOS\033[0m"
 echo ""
 tput setaf 7 ; tput setab 4 ; tput bold ; printf '%0s%s%-0s' "DNS ACTUAL Y EN USO:" ; tput sgr0 ; tput setaf 5 ; tput bold ; printf '%0s%-1s>>%-1s' ; tput sgr0 ; tput setaf 7 ; tput setab 1 ; tput bold ;  printf '%0s%s%-0s\n' "ACTIVAR EL APAGADO Y DESACTIVAR EL ONLINE PARA CAMBIAR" ; tput sgr0 ; tput setaf 7 ; tput setab 1 ; tput bold ;
 cat /etc/resolv.conf | grep nameserver ; tput sgr0
 echo ""
 echo -e "\E[41;1;37m[15]-AUTO-MENU\033[0m"   "\E[41;1;37m[00]-EXIT\033[0m"
 echo ""
 function ac () {
 echo -e "\E[44;1;37mTCP SPEED BBR A SIDO ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 echo "net.ipv4.tcp_window_scaling = 1
 net.core.default_qdisc=fq
 net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_max = 16777216
 net.core.wmem_max = 16777216
 net.ipv4.tcp_rmem = 4096 87380 16777216
 net.ipv4.tcp_wmem = 4096 16384 16777216
 net.ipv4.tcp_low_latency = 1
 net.ipv4.tcp_slow_start_after_idle = 0
 net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
 sudo sysctl -p
 /root/c.sh
 clear
 }
 function ad () {
 echo -e "\E[44;1;37mTCP SPEED BBR A SIDO DESACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 grep -v "^a
 net.ipv4.tcp_window_scaling = 1
 net.core.default_qdisc=fq
 net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_max = 16777216
 net.core.wmem_max = 16777216
 net.ipv4.tcp_rmem = 4096 87380 16777216
 net.ipv4.tcp_wmem = 4096 16384 16777216
 net.ipv4.tcp_low_latency = 1
 net.ipv4.tcp_slow_start_after_idle = 0
 net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
 sudo sysctl -p
 /root/c.sh
 }
 function es () {
 echo -e "\E[44;1;37mTCP SPEED CUBIC A SIDO ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 echo "net.ipv4.tcp_window_scaling = 1
 net.core.default_qdisc=fq
 net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_max = 16777216
 net.core.wmem_max = 16777216
 net.ipv4.tcp_rmem = 4096 87380 16777216
 net.ipv4.tcp_wmem = 4096 16384 16777216
 net.ipv4.tcp_low_latency = 1
 net.ipv4.tcp_slow_start_after_idle = 0
 net.ipv4.tcp_congestion_control=cubic" >> /etc/sysctl.conf
 sudo sysctl -p
 /root/c.sh
 }
 function as () {
 echo -e "\E[44;1;37mTCP SPEED CUBIC A SIDO DESACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 grep -v "^a
 net.ipv4.tcp_window_scaling = 1
 net.core.default_qdisc=fq
 net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_max = 16777216
 net.core.wmem_max = 16777216
 net.ipv4.tcp_rmem = 4096 87380 16777216
 net.ipv4.tcp_wmem = 4096 16384 16777216
 net.ipv4.tcp_low_latency = 1
 net.ipv4.tcp_slow_start_after_idle = 0
 net.ipv4.tcp_congestion_control=cubic" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
 sudo sysctl -p
 /root/c.sh
 clear
 }
 function uy () {
 echo -e "\E[44;1;37mMODULO SPEED A SIDO ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 echo "net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_default = 524288
 net.core.rmem_max = 524288
 net.core.wmem_default = 524288
 net.core.wmem_max = 524288
 net.ipv4.tcp_wmem = 87380 4096 524288
 net.ipv4.tcp_rmem = 87380 4096 524288
 net.ipv4.tcp_mem = 524288 524288 524288
 net.ipv4.tcp_rfc1337 = 1
 net.ipv4.ip_no_pmtu_disc = 0
 net.ipv4.tcp_sack = 1
 net.ipv4.tcp_fack = 1
 net.ipv4.tcp_window_scaling = 1
 net.ipv4.tcp_timestamps = 1
 net.ipv4.tcp_ecn = 0
 net.ipv4.route.flush = 1" >> /etc/sysctl.conf
 sudo sysctl -p
 /root/c.sh
 }
 function ag () {
 echo -e "\E[44;1;37mMODULO SPEED A SIDO DESACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 grep -v "^a
 net.ipv6.conf.all.disable_ipv6=1
 net.ipv6.conf.default.disable_ipv6=1
 net.core.rmem_default = 524288
 net.core.rmem_max = 524288
 net.core.wmem_default = 524288
 net.core.wmem_max = 524288
 net.ipv4.tcp_wmem = 87380 4096 524288
 net.ipv4.tcp_rmem = 87380 4096 524288
 net.ipv4.tcp_mem = 524288 524288 524288
 net.ipv4.tcp_rfc1337 = 1
 net.ipv4.ip_no_pmtu_disc = 0
 net.ipv4.tcp_sack = 1
 net.ipv4.tcp_fack = 1
 net.ipv4.tcp_window_scaling = 1
 net.ipv4.tcp_timestamps = 1
 net.ipv4.tcp_ecn = 0
 net.ipv4.route.flush = 1" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function bb () {
 echo -e "\E[44;1;37mDNS CLOUDFLARE A SIDO ACTIVADO\033[0m"
 sleep 2.5s
 echo "
 nameserver 1.1.1.1
 nameserver 1.0.0.1" >> /etc/resolv.conf
 /root/c.sh
 }
 function cg () {
 echo -e "\E[44;1;37mDNS CLOUDFLARE A SIDO DESACTIVADO\033[0m"
 sleep 2.5s
 grep -v "^a
 nameserver 1.1.1.1
 nameserver 1.0.0.1
 nameserver 127.0.0.53
 options edns0
 #nameserver 127.0.0.53"  /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function vb () {
 echo -e "\E[44;1;37mDNS DE GOOGLE A SIDO ACTIVADO\033[0m"
 sleep 2.5s
 echo "
 nameserver 8.8.8.8
 nameserver 8.8.4.4" >> /etc/resolv.conf
 /root/c.sh
 }
 function re () {
 echo -e "\E[44;1;37mDNS DE GOOGLE A SIDO DESACTIVADO\033[0m"
 sleep 2.5s
 grep -v "^a
 nameserver 8.8.8.8
 nameserver 8.8.4.4
 nameserver 127.0.0.53
 options edns0
 #nameserver 127.0.0.53"  /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function tt () {
 echo -e "\E[44;1;37mDNS DE OPENDNS A SIDO ACTIVADO\033[0m"
 sleep 2.5s
 echo "
 nameserver 208.67.222.222
 nameserver 208.67.220.220" >> /etc/resolv.conf
 /root/c.sh
 }
 function bn () {
 echo -e "\E[44;1;37mDNS DE OPENDNS A SIDO DESACTIVADO\033[0m"
 sleep 2.5s
 grep -v "^a
 nameserver 208.67.222.222
 nameserver 208.67.220.220
 nameserver 127.0.0.53
 options edns0
 #nameserver 127.0.0.53" /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function kl () {
 echo -e "\E[44;1;37mDNS QUAD9 A SIDO ACTIVADO\033[0m"
 sleep 2.5s
 echo "
 nameserver 9.9.9.9
 nameserver 149.112.112.112" >> /etc/resolv.conf
 /root/c.sh
 }
 function mk () {
 echo -e "\E[44;1;37mDNS QUAD9 A SIDO DESACTIVADO\033[0m"
 sleep 2.5s
 grep -v "^a
 nameserver 9.9.9.9
 nameserver 149.112.112.112
 nameserver 127.0.0.53
 options edns0
 #nameserver 127.0.0.53" /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function pq () {
 echo -e "\E[0;37;44mDNS NETFLIX Y JUEGOS ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 echo "
 nameserver 45.55.147.169
 nameserver 204.12.225.226" >> /etc/resolv.conf
 /root/c.sh
 }
 function qp () {
 grep -v "^a
 nameserver 45.55.147.169
 nameserver 204.12.225.226" /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 function as () {
 echo -e "\E[0;37;44mDNS ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 echo "
 nameserver 84.200.69.80
 nameserver 84.200.70.40" >> /etc/resolv.conf
 /root/c.sh
 }
 function adn () {
 echo -e "\E[0;37;44mDNS.WATCH DESACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 grep -v "^a
 nameserver 84.200.69.80
 nameserver 84.200.70.40" /etc/resolv.conf > /tmp/syscl && mv -f /tmp/syscl /etc/resolv.conf
 /root/c.sh
 }
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 1)ac
 ;;
 2)ad
 ;;
 3)es
 ;;
 4)as
 ;;
 5)bb
 ;;
 6)cg
 ;;
 7)vb
 ;;
 8)re
 ;;
 9)tt
 ;;
 10)bn
 ;;
 11)kl
 ;;
 12)mk
 ;;
 13)as
 ;;
 14)adn
 ;;
 15)/root/menu
 ;;
 16)pq
 ;;
 17)qp
 ;;
 esac
 exit
  