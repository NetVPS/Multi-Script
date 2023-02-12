#!/bin/bash
[[ ! -d /usr/local/lib/rm ]] && exit
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
dir="/etc/VPS-MX"
SCPfrm="${dir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${dir}/protocolos" && [[ ! -d ${SCPinst} ]] && exit
[[ ! -d /usr/local/megat ]] && exit
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}

config="/etc/shadowsocks-libev/config.json"

fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    msg -bar
    echo -e "${cor[3]} $(fun_trans ${id} "Aplicar Sistema Para Mejorar Paquetes SSH?")"
    echo -e "${cor[3]} $(fun_trans ${id} "Opcion Para Usuarios Avanzados")"
    msg -bar
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]} $(fun_trans ${id} "Correccion de problemas de paquetes en SSH...")"
           echo -e " $(fun_trans ${id} "Cual es la Tasa de RX")"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e " $(fun_trans ${id} "Cual es la Tasa de  TX")"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     msg -bar
     }
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
del_shadowsocks () {
[[ -e /etc/shadowsocks-libev/config.json ]] && {
[[ $(ps ax|grep ss-server|grep -v grep|awk '{print $1}') != "" ]] && kill -9 $(ps ax|grep ss-server|grep -v grep|awk '{print $1}') > /dev/null 2>&1 && ss-server -c /etc/shadowsocks-libev/config.json -d stop > /dev/null 2>&1
echo -e "\033[1;33m	SHADOWSOCKS LIBEV DETENIDO"
msg -bar
rm /etc/shadowsocks-libev/config.json
rm -rf Instalador-libev.sh Instalador-libev.log shadowsocks_libev_qr.png
rm -rf Instalador-libev.sh Instalador-libev.log
return 0
}
}

[[ $(ps ax | grep ss-server | grep -v grep | awk '{print $1}') ]] && ss="\e[92m[ ON ]" || ss="\e[91m[ OFF ]"
clear
msg -bar
msg -tit
echo -e "       \e[91m\e[43mINSTALADOR SHADOWSOCKS-LIBEV+(obfs)\e[0m "
msg -bar
echo -e "$(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "INSTALAR SHADOWSOCKS LIBEV") $ss"
echo -e "$(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "DESINSTALAR SHADOWSOCKS LIBEV")"
echo -e "$(msg -verd "[3]")$(msg -verm2 "➛ ")$(msg -azu "VER CONFI LIBEV")"
echo -e "$(msg -verd "[4]")$(msg -verm2 "➛ ")$(msg -azu "MODIFICAR CONFIGURACION (nano)")"
echo -e "$(msg -verd "[0]")$(msg -verm2 "➛ ")$(msg -azu "VOLVER")"
msg -bar
echo -n " Selecione Una Opcion: "
read opcao
case $opcao in
1)
clear
msg -bar
wget --no-check-certificate -O Instalador-libev.sh https://raw.githubusercontent.com/lacasitamx/ZETA/master/sha/Instalador-libev.sh > /dev/null 2>&1
chmod +x Instalador-libev.sh
./Instalador-libev.sh 2>&1 | tee Instalador-libev.log
value=$(ps ax |grep ss-server|grep -v grep)
[[ $value != "" ]] && value="\033[1;32mINICIADO CON EXITO" || value="\033[1;31mERROR"
msg -bar
echo -e "${value}"
msg -bar
;;
2)
clear
msg -bar
echo -e "\033[1;93m  Desinstalar  ..."
del_shadowsocks
msg -bar
wget --no-check-certificate -O Instalador-libev.sh https://raw.githubusercontent.com/lacasitamx/ZETA/master/sha/Instalador-libev.sh > /dev/null 2>&1
chmod +x Instalador-libev.sh
./Instalador-libev.sh uninstall
rm -rf Instalador-libev.sh Instalador-libev.log shadowsocks_libev_qr.png

msg -bar
sleep 3
exit
;;
3)
clear
msg -bar
msg -ama " VER CONFIGURACION"
msg -bar
if [[ ! -e ${config} ]]; then
msg -verm " NO HAY INFORMACION"
else
cat /etc/shadowsocks-libev/confis
msg -bar
fi
;;
4)
clear
msg -bar
msg -ama " MODIFICAR CONFIGURACION"
msg -bar

if [[ ! -e ${config} ]]; then
msg -verm " NO HAY INFORMACION"
else
msg -verd " para guardar la confi precione ( crtl + x )"
read -p " enter para continuar"
nano ${config}
msg -bar
/etc/init.d/shadowsocks-libev restart
msg -bar
fi
;;
esac
