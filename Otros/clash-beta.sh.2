#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
#SCRIPT OFICIAL ChumoGH|Plus
# Formato Creado por @ChumoGH | '593987072611 Whatsapp Personal
clear&&clear
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /bin/ejecutar/trojanports.txt && cat /bin/ejecutar/trojanports.txt`;
troport=$(cat /bin/ejecutar/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
portFTP=$(lsof -V -i tcp -P -n | grep apache2 | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | cut -d: -f2 | cut -d' ' -f1 | uniq)
portFTP=$(echo ${portFTP} | sed 's/\s\+/,/g' | cut -d , -f1)
}
#FUN_BAR
fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
} 

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar3
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar3
#bc
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || apt-get install golang-go -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install golang-go............ $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
msg -bar3
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar3
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
echo -ne "\033[97m Deseas agregar Menu Clash Rapido [s/n]: "
read insta
[[ $insta = @(s|S|y|Y) ]] && enttrada
}


fun_insta(){
fun_ip
install_ini
msg -bar3
killall clash 1> /dev/null 2> /dev/null
echo -e " ➣ Creando Directorios y Archivos"
msg -bar3 
[[ -d /root/.config ]] && rm -rf /root/.config/* || mkdir /root/.config 
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
last_version=$(curl -Ls "https://api.github.com/repos/Dreamacro/clash/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
arch=$(arch)
if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64"
else
  arch="amd64"
fi
wget -N --no-check-certificate -O /root/.config/clash/clash.gz https://github.com/Dreamacro/clash/releases/download/${last_version}/clash-linux-${arch}-${last_version}.gz
gzip -d /root/.config/clash/clash.gz
chmod +x /root/.config/clash/clash
echo -e " ➣ Clonando Repositorio Original Dreamacro "
go get -u -v github.com/Dreamacro/clash
clear
}



[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')
[[ ! -d /bin/ejecutar/clashFiles ]] && mkdir /bin/ejecutar/clashFiles
clashFiles='/bin/ejecutar/clashFiles/'

INITClash(){
msg -bar
conFIN
read -p "Ingrese Nombre del Poster WEB de la configuracion: " cocolon
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s%/_dAtE/%${fecha}%g" /root/.config/clash/config.yaml
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s/_h0rA/${hora}/g" /root/.config/clash/config.yaml
cp /root/.config/clash/config.yaml /var/www/html/$cocolon.yaml && chmod +x /var/www/html/$cocolon.yaml
service apache2 restart
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "-------------------------------------------------------"
echo -e "		\033[4;31mNOTA importante\033[0m"
echo -e "Recuerda Descargar el Fichero, o cargarlo como URL!!"
echo -e "-------------------------------------------------------"
echo -e " \033[0;31mSi Usas Clash For Android, Ultima Version  "
echo -e "  Para luego usar el Link del Fichero, y puedas ."
echo -e " Descargarlo desde cualquier sitio con acceso WEB"
echo -e "        Link Clash Valido por 30 minutos "
echo -e "    Link : \033[1;42m  http://$IP:${portFTP}/$cocolon.yaml\033[0m"
echo -e "-------------------------------------------------------"
#read -p "PRESIONA ENTER PARA CARGAR ONLINE"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
scr=$(echo $(($RANDOM*3))|head -c 3)
unset yesno
echo -e " ENLACE VALIDO POR 30 MINUTOS? " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
killall clash > /dev/null &1>&2
screen -dmS clashse_$cocolon /root/.config/clash/clash
echo '#!/bin/bash -e' > /root/.config/clash/$cocolon.sh
echo "sleep 1800s" >> /root/.config/clash/$cocolon.sh && echo -e " ACTIVO POR 30 MINUTOS "  || echo " Validacion Incorrecta "
echo "mv /var/www/html/$cocolon.yaml ${clashFiles}$cocolon.yaml" >> /root/.config/clash/$cocolon.sh
echo 'echo "Fichero removido a ${clashFiles}$cocolon.yaml"' >> /root/.config/clash/$cocolon.sh
echo "service apache2 restart" >> /root/.config/clash/$cocolon.sh
echo "rm -f /root/.config/clash/$cocolon.sh" >> /root/.config/clash/$cocolon.sh
echo 'exit' >> /root/.config/clash/$cocolon.sh && screen -dmS clash${scr} bash /root/.config/clash/$cocolon.sh
} 
echo -e "Proceso Finalizado"

}

configINIT_rule () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL ChumoGH|Plus
# Formato Creado por @ChumoGH | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: rule
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""

dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000
    
proxy-groups:
- name: "ChumoGH-ADM"
  type: select
  proxies:    ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
ConfTrojINI
foc=1
unset yesno
ConfV2RINI
}

configINIT_global () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL ChumoGH|Plus
# Formato Creado por @ChumoGH | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: global
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""
dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000   
 ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
ConfTrojINI
unset yesno
foc=1
ConfV2RINI
}

proxyTRO() {
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proTRO+="- name: $1\n  type: trojan\n  server: ${IP}\n  port: ${troport}\n  password: $2\n  udp: true\n  sni: $3\n  alpn:\n  - h2\n  - http/1.1\n  skip-cert-verify: true\n\n" 
  }

ConfTrojINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG TROJAN " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p " [S/N]: " yesno

tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL TROJAN CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${tropass} ]] && view_usert || { 
echo -e " USER ${tropass}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3
proxyTRO ${nameperfil} ${tropass} ${trosni}
ConfTrojINI
								}
}

proxyV2R() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  servername: $2\n  network: $5\n  ws-opts:  \n       path: $6\n       headers:\n         Host: $2\n  \n\n" 
  }
  
proxyV2Rgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="
- name: $1\n  server: ${IP}\n  port: $7\n  type: vmess\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  tls: true\n  skip-cert-verify: true\n  network: grpc\n  servername: $2\n  grpc-opts:\n    grpc-mode: gun\n    grpc-service-name: $6\n  udp: true"
  }

ConfV2RINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG V2RAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL V2RAY CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${uid} ]] && view_user || { 
echo -e " USER ${ps}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)

[[ $net = '"grpc"' ]] && {
proxyV2Rgprc ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${path} ${v2port}
} || {
proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
}

ConfV2RINI
								}
}

confRULE() {
[[ $mode = 1 ]] && echo -e '
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChumoGH-ADM

# By ChumoGH By CGH
- name: "【 ✵ 𝚂𝚎𝚛𝚟𝚎𝚛-𝙿𝚁𝙴𝙼𝙸𝚄𝙼 ✵ 】"
  type: select
  proxies: 
    - "ChumoGH-ADM"

#- name: "【 📱 +593987072611 】"
#  type: select
#  proxies:
#    - "ChumoGH-ADM"

Rule:
# Unbreak
# > Google
- DOMAIN-SUFFIX,googletraveladservices.com,ChumoGH-ADM
- DOMAIN,dl.google.com,ChumoGH-ADM
- DOMAIN,mtalk.google.com,ChumoGH-ADM

# Internet Service Providers ChumoGH-ADM 运营商劫持
- DOMAIN-SUFFIX,17gouwuba.com,ChumoGH-ADM
- DOMAIN-SUFFIX,186078.com,ChumoGH-ADM
- DOMAIN-SUFFIX,189zj.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,285680.com,ChumoGH-ADM
- DOMAIN-SUFFIX,3721zh.com,ChumoGH-ADM
- DOMAIN-SUFFIX,4336wang.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,51chumoping.com,ChumoGH-ADM
- DOMAIN-SUFFIX,51mld.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,51mypc.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,58mingri.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,58mingtian.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,5vl58stm.com,ChumoGH-ADM
- DOMAIN-SUFFIX,6d63d3.com,ChumoGH-ADM
- DOMAIN-SUFFIX,7gg.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,91veg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,9s6q.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,adsame.com,ChumoGH-ADM
- DOMAIN-SUFFIX,aiclk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,akuai.top,ChumoGH-ADM
- DOMAIN-SUFFIX,atplay.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,baiwanchuangyi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,beerto.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,beilamusi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,benshiw.net,ChumoGH-ADM
- DOMAIN-SUFFIX,bianxianmao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bryonypie.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cishantao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cszlks.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cudaojia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dafapromo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,daitdai.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dsaeerf.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dugesheying.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dv8c1t.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,echatu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,erdoscs.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fan-yong.com,ChumoGH-ADM
- DOMAIN-SUFFIX,feih.com.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,fjlqqc.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fkku194.com,ChumoGH-ADM
- DOMAIN-SUFFIX,freedrive.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,gclick.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,goufanli100.com,ChumoGH-ADM
- DOMAIN-SUFFIX,goupaoerdai.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gouwubang.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gzxnlk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,haoshengtoys.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hyunke.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ichaosheng.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ishop789.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jdkic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jiubuhua.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jsncke.com,ChumoGH-ADM
- DOMAIN-SUFFIX,junkucm.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jwg365.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,kawo77.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kualianyingxiao.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,kumihua.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ltheanine.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,maipinshangmao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,minisplat.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mkitgfs.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mlnbike.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mobjump.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nbkbgd.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,newapi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pinzhitmall.com,ChumoGH-ADM
- DOMAIN-SUFFIX,poppyta.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qianchuanghr.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qichexin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qinchugudao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,quanliyouxi.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,qutaobi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ry51w.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sg536.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifubo.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuce.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuda.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifufu.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuge.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifugu.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuhe.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuhu.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuji.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,sifuka.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,smgru.net,ChumoGH-ADM
- DOMAIN-SUFFIX,taoggou.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tcxshop.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tjqonline.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,topitme.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tt3sm4.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,tuia.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,tuipenguin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tuitiger.com,ChumoGH-ADM
- DOMAIN-SUFFIX,websd8.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wsgblw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wx16999.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xchmai.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xiaohuau.xyz,ChumoGH-ADM
- DOMAIN-SUFFIX,ygyzx.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,yinmong.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yitaopt.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yjqiqi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yukhj.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zhaozecheng.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,zhenxinet.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zlne800.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zunmi.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,zzd6.com,ChumoGH-ADM
- IP-CIDR,39.107.15.115/32,ChumoGH-ADM,no-resolve
- IP-CIDR,47.89.59.182/32,ChumoGH-ADM,no-resolve
- IP-CIDR,103.49.209.27/32,ChumoGH-ADM,no-resolve
- IP-CIDR,123.56.152.96/32,ChumoGH-ADM,no-resolve
# > ChinaTelecom
- IP-CIDR,61.160.200.223/32,ChumoGH-ADM,no-resolve
- IP-CIDR,61.160.200.242/32,ChumoGH-ADM,no-resolve
- IP-CIDR,61.160.200.252/32,ChumoGH-ADM,no-resolve
- IP-CIDR,61.174.50.214/32,ChumoGH-ADM,no-resolve
- IP-CIDR,111.175.220.163/32,ChumoGH-ADM,no-resolve
- IP-CIDR,111.175.220.164/32,ChumoGH-ADM,no-resolve
- IP-CIDR,122.229.8.47/32,ChumoGH-ADM,no-resolve
- IP-CIDR,122.229.29.89/32,ChumoGH-ADM,no-resolve
- IP-CIDR,124.232.160.178/32,ChumoGH-ADM,no-resolve
- IP-CIDR,175.6.223.15/32,ChumoGH-ADM,no-resolve
- IP-CIDR,183.59.53.237/32,ChumoGH-ADM,no-resolve
- IP-CIDR,218.93.127.37/32,ChumoGH-ADM,no-resolve
- IP-CIDR,221.228.17.152/32,ChumoGH-ADM,no-resolve
- IP-CIDR,221.231.6.79/32,ChumoGH-ADM,no-resolve
- IP-CIDR,222.186.61.91/32,ChumoGH-ADM,no-resolve
- IP-CIDR,222.186.61.95/32,ChumoGH-ADM,no-resolve
- IP-CIDR,222.186.61.96/32,ChumoGH-ADM,no-resolve
- IP-CIDR,222.186.61.97/32,ChumoGH-ADM,no-resolve
# > ChinaUnicom
- IP-CIDR,106.75.231.48/32,ChumoGH-ADM,no-resolve
- IP-CIDR,119.4.249.166/32,ChumoGH-ADM,no-resolve
- IP-CIDR,220.196.52.141/32,ChumoGH-ADM,no-resolve
- IP-CIDR,221.6.4.148/32,ChumoGH-ADM,no-resolve
# > ChinaMobile
- IP-CIDR,114.247.28.96/32,ChumoGH-ADM,no-resolve
- IP-CIDR,221.179.131.72/32,ChumoGH-ADM,no-resolve
- IP-CIDR,221.179.140.145/32,ChumoGH-ADM,no-resolve
# > Dr.Peng
# - IP-CIDR,10.72.25.0/24,ChumoGH-ADM,no-resolve
- IP-CIDR,115.182.16.79/32,ChumoGH-ADM,no-resolve
- IP-CIDR,118.144.88.126/32,ChumoGH-ADM,no-resolve
- IP-CIDR,118.144.88.215/32,ChumoGH-ADM,no-resolve
- IP-CIDR,118.144.88.216/32,ChumoGH-ADM,no-resolve
- IP-CIDR,120.76.189.132/32,ChumoGH-ADM,no-resolve
- IP-CIDR,124.14.21.147/32,ChumoGH-ADM,no-resolve
- IP-CIDR,124.14.21.151/32,ChumoGH-ADM,no-resolve
- IP-CIDR,180.166.52.24/32,ChumoGH-ADM,no-resolve
- IP-CIDR,211.161.101.106/32,ChumoGH-ADM,no-resolve
- IP-CIDR,220.115.251.25/32,ChumoGH-ADM,no-resolve
- IP-CIDR,222.73.156.235/32,ChumoGH-ADM,no-resolve

# Malware 恶意网站
# > 快压
# https://zhuanlan.zhihu.com/p/39534279
- DOMAIN-SUFFIX,kuaizip.com,ChumoGH-ADM
# > MacKeeper
# https://www.lizhi.io/blog/40002904
- DOMAIN-SUFFIX,mackeeper.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zryydi.com,ChumoGH-ADM
# > Adobe Flash China Special Edition
# https://www.zhihu.com/question/281163698/answer/441388130
- DOMAIN-SUFFIX,flash.cn,ChumoGH-ADM
- DOMAIN,geo2.adobe.com,ChumoGH-ADM
# > C&J Marketing 思杰马克丁软件
# https://www.zhihu.com/question/46746200
- DOMAIN-SUFFIX,4009997658.com,ChumoGH-ADM
- DOMAIN-SUFFIX,abbyychina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bartender.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,betterzip.net,ChumoGH-ADM
- DOMAIN-SUFFIX,betterzipcn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,beyondcompare.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,bingdianhuanyuan.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,chemdraw.com.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,cjmakeding.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cjmkt.com,ChumoGH-ADM
- DOMAIN-SUFFIX,codesoftchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,coreldrawchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,crossoverchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dongmansoft.com,ChumoGH-ADM
- DOMAIN-SUFFIX,earmasterchina.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,easyrecoverychina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ediuschina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,flstudiochina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,formysql.com,ChumoGH-ADM
- DOMAIN-SUFFIX,guitarpro.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,huishenghuiying.com.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,hypersnap.net,ChumoGH-ADM
- DOMAIN-SUFFIX,iconworkshop.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,imindmap.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,jihehuaban.com.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,keyshot.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,kingdeecn.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,logoshejishi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,luping.net.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mairuan.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mairuan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mairuan.com.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mairuan.net,ChumoGH-ADM
- DOMAIN-SUFFIX,mairuanwang.com,ChumoGH-ADM
- DOMAIN-SUFFIX,makeding.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mathtype.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mindmanager.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,mindmanager.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,mindmapper.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,mycleanmymac.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nicelabel.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,ntfsformac.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,ntfsformac.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,overturechina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,passwordrecovery.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,pdfexpert.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,photozoomchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,shankejingling.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ultraiso.net,ChumoGH-ADM
- DOMAIN-SUFFIX,vegaschina.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,xmindchina.net,ChumoGH-ADM
- DOMAIN-SUFFIX,xshellcn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yihuifu.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,yuanchengxiezuo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zbrushcn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zhzzx.com,ChumoGH-ADM

# Global Area Network
# (ChumoGH-ADM)
# (Music)
# > Deezer
# USER-AGENT,Deezer*,ChumoGH-ADM
- DOMAIN-SUFFIX,deezer.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dzcdn.net,ChumoGH-ADM
# > KKBOX
- DOMAIN-SUFFIX,kkbox.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kkbox.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,kfs.io,ChumoGH-ADM
# > JOOX
# USER-AGENT,WeMusic*,ChumoGH-ADM
# USER-AGENT,JOOX*,ChumoGH-ADM
- DOMAIN-SUFFIX,joox.com,ChumoGH-ADM
# > Pandora
# USER-AGENT,Pandora*,ChumoGH-ADM
- DOMAIN-SUFFIX,pandora.com,ChumoGH-ADM
# > SoundCloud
# USER-AGENT,SoundCloud*,ChumoGH-ADM
- DOMAIN-SUFFIX,p-cdn.us,ChumoGH-ADM
- DOMAIN-SUFFIX,sndcdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,soundcloud.com,ChumoGH-ADM
# > Spotify
# USER-AGENT,Spotify*,ChumoGH-ADM
- DOMAIN-SUFFIX,pscdn.co,ChumoGH-ADM
- DOMAIN-SUFFIX,scdn.co,ChumoGH-ADM
- DOMAIN-SUFFIX,spotify.com,ChumoGH-ADM
- DOMAIN-SUFFIX,spoti.fi,ChumoGH-ADM
- DOMAIN-KEYWORD,spotify.com,ChumoGH-ADM
- DOMAIN-KEYWORD,-spotify-com,ChumoGH-ADM
# > TIDAL
# USER-AGENT,TIDAL*,ChumoGH-ADM
- DOMAIN-SUFFIX,tidal.com,ChumoGH-ADM
# > YouTubeMusic
# USER-AGENT,com.google.ios.youtubemusic*,ChumoGH-ADM
# USER-AGENT,YouTubeMusic*,ChumoGH-ADM
# (Video)
# > All4
# USER-AGENT,All4*,ChumoGH-ADM
- DOMAIN-SUFFIX,c4assets.com,ChumoGH-ADM
- DOMAIN-SUFFIX,channel4.com,ChumoGH-ADM
# > AbemaTV
# USER-AGENT,AbemaTV*,ChumoGH-ADM
- DOMAIN-SUFFIX,abema.io,ChumoGH-ADM
- DOMAIN-SUFFIX,ameba.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,abema.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,hayabusa.io,ChumoGH-ADM
- DOMAIN,abematv.akamaized.net,ChumoGH-ADM
- DOMAIN,ds-linear-abematv.akamaized.net,ChumoGH-ADM
- DOMAIN,ds-vod-abematv.akamaized.net,ChumoGH-ADM
- DOMAIN,linear-abematv.akamaized.net,ChumoGH-ADM
# > Amazon Prime Video
# USER-AGENT,InstantVideo.US*,ChumoGH-ADM
# USER-AGENT,Prime%20Video*,ChumoGH-ADM
- DOMAIN-SUFFIX,aiv-cdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,aiv-delivery.net,ChumoGH-ADM
- DOMAIN-SUFFIX,amazonvideo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,primevideo.com,ChumoGH-ADM
- DOMAIN,avodmp4s3ww-a.akamaihd.net,ChumoGH-ADM
- DOMAIN,d25xi40x97liuc.cloudfront.net,ChumoGH-ADM
- DOMAIN,dmqdd6hw24ucf.cloudfront.net,ChumoGH-ADM
- DOMAIN,d22qjgkvxw22r6.cloudfront.net,ChumoGH-ADM
- DOMAIN,d1v5ir2lpwr8os.cloudfront.net,ChumoGH-ADM
- DOMAIN-KEYWORD,avoddashs,ChumoGH-ADM
# > Bahamut
# USER-AGENT,Anime*,ChumoGH-ADM
- DOMAIN-SUFFIX,bahamut.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,gamer.com.tw,ChumoGH-ADM
- DOMAIN,gamer-cds.cdn.hinet.net,ChumoGH-ADM
- DOMAIN,gamer2-cds.cdn.hinet.net,ChumoGH-ADM
# > BBC iPlayer
# USER-AGENT,BBCiPlayer*,ChumoGH-ADM
- DOMAIN-SUFFIX,bbc.co.uk,ChumoGH-ADM
- DOMAIN-SUFFIX,bbci.co.uk,ChumoGH-ADM
- DOMAIN-KEYWORD,bbcfmt,ChumoGH-ADM
- DOMAIN-KEYWORD,uk-live,ChumoGH-ADM
# > DAZN
# USER-AGENT,DAZN*,ChumoGH-ADM
- DOMAIN-SUFFIX,dazn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dazn-api.com,ChumoGH-ADM
- DOMAIN,d151l6v8er5bdm.cloudfront.net,ChumoGH-ADM
- DOMAIN-KEYWORD,voddazn,ChumoGH-ADM
# > Disney+
# USER-AGENT,Disney+*,ChumoGH-ADM
- DOMAIN-SUFFIX,bamgrid.com,ChumoGH-ADM
- DOMAIN-SUFFIX,disney-plus.net,ChumoGH-ADM
- DOMAIN-SUFFIX,disneyplus.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dssott.com,ChumoGH-ADM
- DOMAIN,cdn.registerdisney.go.com,ChumoGH-ADM
# > encoreTVB
# USER-AGENT,encoreTVB*,ChumoGH-ADM
- DOMAIN-SUFFIX,encoretvb.com,ChumoGH-ADM
- DOMAIN,edge.api.brightcove.com,ChumoGH-ADM
- DOMAIN,bcbolt446c5271-a.akamaihd.net,ChumoGH-ADM
# > FOX NOW
# USER-AGENT,FOX%20NOW*,ChumoGH-ADM
- DOMAIN-SUFFIX,fox.com,ChumoGH-ADM
- DOMAIN-SUFFIX,foxdcg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,theplatform.com,ChumoGH-ADM
- DOMAIN-SUFFIX,uplynk.com,ChumoGH-ADM
# > HBO NOW
# USER-AGENT,HBO%20NOW*,ChumoGH-ADM
- DOMAIN-SUFFIX,hbo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hbogo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hbonow.com,ChumoGH-ADM
# > HBO GO HKG
# USER-AGENT,HBO%20GO%20PROD%20HKG*,ChumoGH-ADM
- DOMAIN-SUFFIX,hbogoasia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hbogoasia.hk,ChumoGH-ADM
- DOMAIN,bcbolthboa-a.akamaihd.net,ChumoGH-ADM
- DOMAIN,players.brightcove.net,ChumoGH-ADM
- DOMAIN,s3-ap-southeast-1.amazonaws.com,ChumoGH-ADM
- DOMAIN,dai3fd1oh325y.cloudfront.net,ChumoGH-ADM
- DOMAIN,44wilhpljf.execute-api.ap-southeast-1.amazonaws.com,ChumoGH-ADM
- DOMAIN,hboasia1-i.akamaihd.net,ChumoGH-ADM
- DOMAIN,hboasia2-i.akamaihd.net,ChumoGH-ADM
- DOMAIN,hboasia3-i.akamaihd.net,ChumoGH-ADM
- DOMAIN,hboasia4-i.akamaihd.net,ChumoGH-ADM
- DOMAIN,hboasia5-i.akamaihd.net,ChumoGH-ADM
- DOMAIN,cf-images.ap-southeast-1.prod.boltdns.net,ChumoGH-ADM
# > 华文电视
# USER-AGENT,HWTVMobile*,ChumoGH-ADM
- DOMAIN-SUFFIX,5itv.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,ocnttv.com,ChumoGH-ADM
# > Hulu
- DOMAIN-SUFFIX,hulu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,huluim.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hulustream.com,ChumoGH-ADM
# > Hulu(フールー)
- DOMAIN-SUFFIX,happyon.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,hulu.jp,ChumoGH-ADM
# > ITV
# USER-AGENT,ITV_Player*,ChumoGH-ADM
- DOMAIN-SUFFIX,itv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,itvstatic.com,ChumoGH-ADM
- DOMAIN,itvpnpmobile-a.akamaihd.net,ChumoGH-ADM
# > KKTV
# USER-AGENT,KKTV*,ChumoGH-ADM
# USER-AGENT,com.kktv.ios.kktv*,ChumoGH-ADM
- DOMAIN-SUFFIX,kktv.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,kktv.me,ChumoGH-ADM
- DOMAIN,kktv-theater.kk.stream,ChumoGH-ADM
# > Line TV
# USER-AGENT,LINE%20TV*,ChumoGH-ADM
- DOMAIN-SUFFIX,linetv.tw,ChumoGH-ADM
- DOMAIN,d3c7rimkq79yfu.cloudfront.net,ChumoGH-ADM
# > LiTV
- DOMAIN-SUFFIX,litv.tv,ChumoGH-ADM
- DOMAIN,litvfreemobile-hichannel.cdn.hinet.net,ChumoGH-ADM
# > My5
# USER-AGENT,My5*,ChumoGH-ADM
- DOMAIN-SUFFIX,channel5.com,ChumoGH-ADM
- DOMAIN-SUFFIX,my5.tv,ChumoGH-ADM
- DOMAIN,d349g9zuie06uo.cloudfront.net,ChumoGH-ADM
# > myTV SUPER
# USER-AGENT,mytv*,ChumoGH-ADM
- DOMAIN-SUFFIX,mytvsuper.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tvb.com,ChumoGH-ADM
# > Netflix
# USER-AGENT,Argo*,ChumoGH-ADM
- DOMAIN-SUFFIX,netflix.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflix.net,ChumoGH-ADM
- DOMAIN-SUFFIX,nflxext.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nflximg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nflximg.net,ChumoGH-ADM
- DOMAIN-SUFFIX,nflxso.net,ChumoGH-ADM
- DOMAIN-SUFFIX,nflxvideo.net,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest0.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest1.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest2.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest3.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest4.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest5.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest6.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest7.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest8.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netflixdnstest9.com,ChumoGH-ADM
- IP-CIDR,23.246.0.0/18,ChumoGH-ADM,no-resolve
- IP-CIDR,37.77.184.0/21,ChumoGH-ADM,no-resolve
- IP-CIDR,45.57.0.0/17,ChumoGH-ADM,no-resolve
- IP-CIDR,64.120.128.0/17,ChumoGH-ADM,no-resolve
- IP-CIDR,66.197.128.0/17,ChumoGH-ADM,no-resolve
- IP-CIDR,108.175.32.0/20,ChumoGH-ADM,no-resolve
- IP-CIDR,192.173.64.0/18,ChumoGH-ADM,no-resolve
- IP-CIDR,198.38.96.0/19,ChumoGH-ADM,no-resolve
- IP-CIDR,198.45.48.0/20,ChumoGH-ADM,no-resolve
# > niconico
# USER-AGENT,Niconico*,ChumoGH-ADM
- DOMAIN-SUFFIX,dmc.nico,ChumoGH-ADM
- DOMAIN-SUFFIX,nicovideo.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,nimg.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,socdm.com,ChumoGH-ADM
# > PBS
# USER-AGENT,PBS*,ChumoGH-ADM
- DOMAIN-SUFFIX,pbs.org,ChumoGH-ADM
# > Pornhub
- DOMAIN-SUFFIX,phncdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pornhub.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pornhubpremium.com,ChumoGH-ADM
# > 台湾好
# USER-AGENT,TaiwanGood*,ChumoGH-ADM
- DOMAIN-SUFFIX,skyking.com.tw,ChumoGH-ADM
- DOMAIN,hamifans.emome.net,ChumoGH-ADM
# > Twitch
- DOMAIN-SUFFIX,twitch.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,twitchcdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,ttvnw.net,ChumoGH-ADM
- DOMAIN-SUFFIX,jtvnw.net,ChumoGH-ADM
# > ViuTV
# USER-AGENT,Viu*,ChumoGH-ADM
# USER-AGENT,ViuTV*,ChumoGH-ADM
- DOMAIN-SUFFIX,viu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,viu.tv,ChumoGH-ADM
- DOMAIN,api.viu.now.com,ChumoGH-ADM
- DOMAIN,d1k2us671qcoau.cloudfront.net,ChumoGH-ADM
- DOMAIN,d2anahhhmp1ffz.cloudfront.net,ChumoGH-ADM
- DOMAIN,dfp6rglgjqszk.cloudfront.net,ChumoGH-ADM
# > YouTube
# USER-AGENT,com.google.ios.youtube*,ChumoGH-ADM
# USER-AGENT,YouTube*,ChumoGH-ADM
- DOMAIN-SUFFIX,googlevideo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,youtube.com,ChumoGH-ADM
- DOMAIN,youtubei.googleapis.com,ChumoGH-ADM

# (ChumoGH-ADM)
# > 愛奇藝台灣站
- DOMAIN,cache.video.iqiyi.com,ChumoGH-ADM
# > bilibili
- DOMAIN-SUFFIX,bilibili.com,ChumoGH-ADM
- DOMAIN,upos-hz-mirrorakam.akamaized.net,ChumoGH-ADM

# (DNS Cache Pollution Protection)
# > Google
- DOMAIN-SUFFIX,ampproject.org,ChumoGH-ADM
- DOMAIN-SUFFIX,appspot.com,ChumoGH-ADM
- DOMAIN-SUFFIX,blogger.com,ChumoGH-ADM
- DOMAIN-SUFFIX,getoutline.org,ChumoGH-ADM
- DOMAIN-SUFFIX,gvt0.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gvt1.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gvt3.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xn--ngstr-lra8j.com,ChumoGH-ADM
- DOMAIN-KEYWORD,google,ChumoGH-ADM
- DOMAIN-KEYWORD,blogspot,ChumoGH-ADM
# > Microsoft
- DOMAIN-SUFFIX,onedrive.live.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xboxlive.com,ChumoGH-ADM
# > Facebook
- DOMAIN-SUFFIX,cdninstagram.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fb.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fb.me,ChumoGH-ADM
- DOMAIN-SUFFIX,fbaddins.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fbcdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,fbsbx.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fbworkmail.com,ChumoGH-ADM
- DOMAIN-SUFFIX,instagram.com,ChumoGH-ADM
- DOMAIN-SUFFIX,m.me,ChumoGH-ADM
- DOMAIN-SUFFIX,messenger.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oculus.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oculuscdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,rocksdb.org,ChumoGH-ADM
- DOMAIN-SUFFIX,whatsapp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,whatsapp.net,ChumoGH-ADM
- DOMAIN-KEYWORD,facebook,ChumoGH-ADM
- IP-CIDR,3.123.36.126/32,ChumoGH-ADM,no-resolve
- IP-CIDR,35.157.215.84/32,ChumoGH-ADM,no-resolve
- IP-CIDR,35.157.217.255/32,ChumoGH-ADM,no-resolve
- IP-CIDR,52.58.209.134/32,ChumoGH-ADM,no-resolve
- IP-CIDR,54.93.124.31/32,ChumoGH-ADM,no-resolve
- IP-CIDR,54.162.243.80/32,ChumoGH-ADM,no-resolve
- IP-CIDR,54.173.34.141/32,ChumoGH-ADM,no-resolve
- IP-CIDR,54.235.23.242/32,ChumoGH-ADM,no-resolve
- IP-CIDR,169.45.248.118/32,ChumoGH-ADM,no-resolve
# > Twitter
- DOMAIN-SUFFIX,pscp.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,periscope.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,t.co,ChumoGH-ADM
- DOMAIN-SUFFIX,twimg.co,ChumoGH-ADM
- DOMAIN-SUFFIX,twimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,twitpic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,vine.co,ChumoGH-ADM
- DOMAIN-KEYWORD,twitter,ChumoGH-ADM
# > Telegram
- DOMAIN-SUFFIX,t.me,ChumoGH-ADM
- DOMAIN-SUFFIX,tdesktop.com,ChumoGH-ADM
- DOMAIN-SUFFIX,telegra.ph,ChumoGH-ADM
- DOMAIN-SUFFIX,telegram.me,ChumoGH-ADM
- DOMAIN-SUFFIX,telegram.org,ChumoGH-ADM
- IP-CIDR,91.108.4.0/22,ChumoGH-ADM,no-resolve
- IP-CIDR,91.108.8.0/22,ChumoGH-ADM,no-resolve
- IP-CIDR,91.108.12.0/22,ChumoGH-ADM,no-resolve
- IP-CIDR,91.108.16.0/22,ChumoGH-ADM,no-resolve
- IP-CIDR,91.108.56.0/22,ChumoGH-ADM,no-resolve
- IP-CIDR,149.154.160.0/20,ChumoGH-ADM,no-resolve
# > Line
- DOMAIN-SUFFIX,line.me,ChumoGH-ADM
- DOMAIN-SUFFIX,line-apps.com,ChumoGH-ADM
- DOMAIN-SUFFIX,line-scdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,naver.jp,ChumoGH-ADM
- IP-CIDR,103.2.30.0/23,ChumoGH-ADM,no-resolve
- IP-CIDR,125.209.208.0/20,ChumoGH-ADM,no-resolve
- IP-CIDR,147.92.128.0/17,ChumoGH-ADM,no-resolve
- IP-CIDR,203.104.144.0/21,ChumoGH-ADM,no-resolve
# > Other
- DOMAIN-SUFFIX,4shared.com,ChumoGH-ADM
- DOMAIN-SUFFIX,520cc.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,881903.com,ChumoGH-ADM
- DOMAIN-SUFFIX,9cache.com,ChumoGH-ADM
- DOMAIN-SUFFIX,9gag.com,ChumoGH-ADM
- DOMAIN-SUFFIX,abc.com,ChumoGH-ADM
- DOMAIN-SUFFIX,abc.net.au,ChumoGH-ADM
- DOMAIN-SUFFIX,abebooks.com,ChumoGH-ADM
- DOMAIN-SUFFIX,amazon.co.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,apigee.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apk-dl.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apkfind.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apkmirror.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apkmonk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apkpure.com,ChumoGH-ADM
- DOMAIN-SUFFIX,aptoide.com,ChumoGH-ADM
- DOMAIN-SUFFIX,archive.is,ChumoGH-ADM
- DOMAIN-SUFFIX,archive.org,ChumoGH-ADM
- DOMAIN-SUFFIX,arte.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,artstation.com,ChumoGH-ADM
- DOMAIN-SUFFIX,arukas.io,ChumoGH-ADM
- DOMAIN-SUFFIX,ask.com,ChumoGH-ADM
- DOMAIN-SUFFIX,avg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,avgle.com,ChumoGH-ADM
- DOMAIN-SUFFIX,badoo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bandwagonhost.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bbc.com,ChumoGH-ADM
- DOMAIN-SUFFIX,behance.net,ChumoGH-ADM
- DOMAIN-SUFFIX,bibox.com,ChumoGH-ADM
- DOMAIN-SUFFIX,biggo.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,binance.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bitcointalk.org,ChumoGH-ADM
- DOMAIN-SUFFIX,bitfinex.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bitmex.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bit-z.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bloglovin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bloomberg.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,bloomberg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,blubrry.com,ChumoGH-ADM
- DOMAIN-SUFFIX,book.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,booklive.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,books.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,boslife.net,ChumoGH-ADM
- DOMAIN-SUFFIX,box.com,ChumoGH-ADM
- DOMAIN-SUFFIX,businessinsider.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bwh1.net,ChumoGH-ADM
- DOMAIN-SUFFIX,castbox.fm,ChumoGH-ADM
- DOMAIN-SUFFIX,cbc.ca,ChumoGH-ADM
- DOMAIN-SUFFIX,cdw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,change.org,ChumoGH-ADM
- DOMAIN-SUFFIX,channelnewsasia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ck101.com,ChumoGH-ADM
- DOMAIN-SUFFIX,clarionproject.org,ChumoGH-ADM
- DOMAIN-SUFFIX,clyp.it,ChumoGH-ADM
- DOMAIN-SUFFIX,cna.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,comparitech.com,ChumoGH-ADM
- DOMAIN-SUFFIX,conoha.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,crucial.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cts.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,cw.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,cyberctm.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dailymotion.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dailyview.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,daum.net,ChumoGH-ADM
- DOMAIN-SUFFIX,daumcdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,dcard.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,deepdiscount.com,ChumoGH-ADM
- DOMAIN-SUFFIX,depositphotos.com,ChumoGH-ADM
- DOMAIN-SUFFIX,deviantart.com,ChumoGH-ADM
- DOMAIN-SUFFIX,disconnect.me,ChumoGH-ADM
- DOMAIN-SUFFIX,discordapp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,discordapp.net,ChumoGH-ADM
- DOMAIN-SUFFIX,disqus.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dlercloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dns2go.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dowjones.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dropbox.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dropboxusercontent.com,ChumoGH-ADM
- DOMAIN-SUFFIX,duckduckgo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dynu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,earthcam.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ebookservice.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,economist.com,ChumoGH-ADM
- DOMAIN-SUFFIX,edgecastcdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,edu,ChumoGH-ADM
- DOMAIN-SUFFIX,elpais.com,ChumoGH-ADM
- DOMAIN-SUFFIX,enanyang.my,ChumoGH-ADM
- DOMAIN-SUFFIX,encyclopedia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,esoir.be,ChumoGH-ADM
- DOMAIN-SUFFIX,etherscan.io,ChumoGH-ADM
- DOMAIN-SUFFIX,euronews.com,ChumoGH-ADM
- DOMAIN-SUFFIX,evozi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,feedly.com,ChumoGH-ADM
- DOMAIN-SUFFIX,firech.at,ChumoGH-ADM
- DOMAIN-SUFFIX,flickr.com,ChumoGH-ADM
- DOMAIN-SUFFIX,flitto.com,ChumoGH-ADM
- DOMAIN-SUFFIX,foreignpolicy.com,ChumoGH-ADM
- DOMAIN-SUFFIX,freebrowser.org,ChumoGH-ADM
- DOMAIN-SUFFIX,freewechat.com,ChumoGH-ADM
- DOMAIN-SUFFIX,freeweibo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,friday.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,ftchinese.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ftimg.net,ChumoGH-ADM
- DOMAIN-SUFFIX,gate.io,ChumoGH-ADM
- DOMAIN-SUFFIX,getlantern.org,ChumoGH-ADM
- DOMAIN-SUFFIX,getsync.com,ChumoGH-ADM
- DOMAIN-SUFFIX,globalvoices.org,ChumoGH-ADM
- DOMAIN-SUFFIX,goo.ne.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,goodreads.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gov,ChumoGH-ADM
- DOMAIN-SUFFIX,gov.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,greatfire.org,ChumoGH-ADM
- DOMAIN-SUFFIX,gumroad.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hbg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,heroku.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hightail.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hk01.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hkbf.org,ChumoGH-ADM
- DOMAIN-SUFFIX,hkbookcity.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hkej.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hket.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hkgolden.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hootsuite.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hudson.org,ChumoGH-ADM
- DOMAIN-SUFFIX,hyread.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,ibtimes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,i-cable.com,ChumoGH-ADM
- DOMAIN-SUFFIX,icij.org,ChumoGH-ADM
- DOMAIN-SUFFIX,icoco.com,ChumoGH-ADM
- DOMAIN-SUFFIX,imgur.com,ChumoGH-ADM
- DOMAIN-SUFFIX,initiummall.com,ChumoGH-ADM
- DOMAIN-SUFFIX,insecam.org,ChumoGH-ADM
- DOMAIN-SUFFIX,ipfs.io,ChumoGH-ADM
- DOMAIN-SUFFIX,issuu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,istockphoto.com,ChumoGH-ADM
- DOMAIN-SUFFIX,japantimes.co.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,jiji.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jinx.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jkforum.net,ChumoGH-ADM
- DOMAIN-SUFFIX,joinmastodon.org,ChumoGH-ADM
- DOMAIN-SUFFIX,justmysocks.net,ChumoGH-ADM
- DOMAIN-SUFFIX,justpaste.it,ChumoGH-ADM
- DOMAIN-SUFFIX,kakao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kakaocorp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kik.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kobo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kobobooks.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kodingen.com,ChumoGH-ADM
- DOMAIN-SUFFIX,lemonde.fr,ChumoGH-ADM
- DOMAIN-SUFFIX,lepoint.fr,ChumoGH-ADM
- DOMAIN-SUFFIX,lihkg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,listennotes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,livestream.com,ChumoGH-ADM
- DOMAIN-SUFFIX,logmein.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mail.ru,ChumoGH-ADM
- DOMAIN-SUFFIX,mailchimp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,marc.info,ChumoGH-ADM
- DOMAIN-SUFFIX,matters.news,ChumoGH-ADM
- DOMAIN-SUFFIX,maying.co,ChumoGH-ADM
- DOMAIN-SUFFIX,medium.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mega.nz,ChumoGH-ADM
- DOMAIN-SUFFIX,mil,ChumoGH-ADM
- DOMAIN-SUFFIX,mingpao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mobile01.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myspace.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myspacecdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nanyang.com,ChumoGH-ADM
- DOMAIN-SUFFIX,naver.com,ChumoGH-ADM
- DOMAIN-SUFFIX,neowin.net,ChumoGH-ADM
- DOMAIN-SUFFIX,newstapa.org,ChumoGH-ADM
- DOMAIN-SUFFIX,nexitally.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nhk.or.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,nicovideo.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,nii.ac.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,nikkei.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nofile.io,ChumoGH-ADM
- DOMAIN-SUFFIX,now.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nrk.no,ChumoGH-ADM
- DOMAIN-SUFFIX,nyt.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytcn.me,ChumoGH-ADM
- DOMAIN-SUFFIX,nytco.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytimes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytlog.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nytstyle.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ok.ru,ChumoGH-ADM
- DOMAIN-SUFFIX,okex.com,ChumoGH-ADM
- DOMAIN-SUFFIX,on.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,orientaldaily.com.my,ChumoGH-ADM
- DOMAIN-SUFFIX,overcast.fm,ChumoGH-ADM
- DOMAIN-SUFFIX,paltalk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pao-pao.net,ChumoGH-ADM
- DOMAIN-SUFFIX,parsevideo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pbxes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pcdvd.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,pchome.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,pcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,picacomic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pinimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pixiv.net,ChumoGH-ADM
- DOMAIN-SUFFIX,player.fm,ChumoGH-ADM
- DOMAIN-SUFFIX,plurk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,po18.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,potato.im,ChumoGH-ADM
- DOMAIN-SUFFIX,potatso.com,ChumoGH-ADM
- DOMAIN-SUFFIX,prism-break.org,ChumoGH-ADM
- DOMAIN-SUFFIX,proxifier.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pt.im,ChumoGH-ADM
- DOMAIN-SUFFIX,pts.org.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,pubu.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,pubu.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,pureapk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,quora.com,ChumoGH-ADM
- DOMAIN-SUFFIX,quoracdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,rakuten.co.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,readingtimes.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,readmoo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,redbubble.com,ChumoGH-ADM
- DOMAIN-SUFFIX,reddit.com,ChumoGH-ADM
- DOMAIN-SUFFIX,redditmedia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,resilio.com,ChumoGH-ADM
- DOMAIN-SUFFIX,reuters.com,ChumoGH-ADM
- DOMAIN-SUFFIX,reutersmedia.net,ChumoGH-ADM
- DOMAIN-SUFFIX,rfi.fr,ChumoGH-ADM
- DOMAIN-SUFFIX,rixcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,roadshow.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,scmp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,scribd.com,ChumoGH-ADM
- DOMAIN-SUFFIX,seatguru.com,ChumoGH-ADM
- DOMAIN-SUFFIX,shadowsocks.org,ChumoGH-ADM
- DOMAIN-SUFFIX,shopee.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,slideshare.net,ChumoGH-ADM
- DOMAIN-SUFFIX,softfamous.com,ChumoGH-ADM
- DOMAIN-SUFFIX,soundcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ssrcloud.org,ChumoGH-ADM
- DOMAIN-SUFFIX,startpage.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamcommunity.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steemit.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steemitwallet.com,ChumoGH-ADM
- DOMAIN-SUFFIX,t66y.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tapatalk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,teco-hk.org,ChumoGH-ADM
- DOMAIN-SUFFIX,teco-mo.org,ChumoGH-ADM
- DOMAIN-SUFFIX,teddysun.com,ChumoGH-ADM
- DOMAIN-SUFFIX,textnow.me,ChumoGH-ADM
- DOMAIN-SUFFIX,theguardian.com,ChumoGH-ADM
- DOMAIN-SUFFIX,theinitium.com,ChumoGH-ADM
- DOMAIN-SUFFIX,thetvdb.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tineye.com,ChumoGH-ADM
- DOMAIN-SUFFIX,torproject.org,ChumoGH-ADM
- DOMAIN-SUFFIX,tumblr.com,ChumoGH-ADM
- DOMAIN-SUFFIX,turbobit.net,ChumoGH-ADM
- DOMAIN-SUFFIX,tutanota.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tvboxnow.com,ChumoGH-ADM
- DOMAIN-SUFFIX,udn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,unseen.is,ChumoGH-ADM
- DOMAIN-SUFFIX,upmedia.mg,ChumoGH-ADM
- DOMAIN-SUFFIX,uptodown.com,ChumoGH-ADM
- DOMAIN-SUFFIX,urbandictionary.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ustream.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,uwants.com,ChumoGH-ADM
- DOMAIN-SUFFIX,v2ray.com,ChumoGH-ADM
- DOMAIN-SUFFIX,viber.com,ChumoGH-ADM
- DOMAIN-SUFFIX,videopress.com,ChumoGH-ADM
- DOMAIN-SUFFIX,vimeo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,voachinese.com,ChumoGH-ADM
- DOMAIN-SUFFIX,voanews.com,ChumoGH-ADM
- DOMAIN-SUFFIX,voxer.com,ChumoGH-ADM
- DOMAIN-SUFFIX,vzw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,w3schools.com,ChumoGH-ADM
- DOMAIN-SUFFIX,washingtonpost.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wattpad.com,ChumoGH-ADM
- DOMAIN-SUFFIX,whoer.net,ChumoGH-ADM
- DOMAIN-SUFFIX,wikimapia.org,ChumoGH-ADM
- DOMAIN-SUFFIX,wikipedia.org,ChumoGH-ADM
- DOMAIN-SUFFIX,wikiquote.org,ChumoGH-ADM
- DOMAIN-SUFFIX,wikiwand.com,ChumoGH-ADM
- DOMAIN-SUFFIX,winudf.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wire.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wordpress.com,ChumoGH-ADM
- DOMAIN-SUFFIX,workflow.is,ChumoGH-ADM
- DOMAIN-SUFFIX,worldcat.org,ChumoGH-ADM
- DOMAIN-SUFFIX,wsj.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wsj.net,ChumoGH-ADM
- DOMAIN-SUFFIX,xhamster.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xn--90wwvt03e.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xn--i2ru8q2qg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xnxx.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xvideos.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yahoo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yandex.ru,ChumoGH-ADM
- DOMAIN-SUFFIX,ycombinator.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yesasia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yes-news.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yomiuri.co.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,you-get.org,ChumoGH-ADM
- DOMAIN-SUFFIX,zaobao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zb.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zello.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zeronet.io,ChumoGH-ADM
- DOMAIN-SUFFIX,zoom.us,ChumoGH-ADM
- DOMAIN-KEYWORD,github,ChumoGH-ADM
- DOMAIN-KEYWORD,jav,ChumoGH-ADM
- DOMAIN-KEYWORD,pinterest,ChumoGH-ADM
- DOMAIN-KEYWORD,porn,ChumoGH-ADM
- DOMAIN-KEYWORD,wikileaks,ChumoGH-ADM

# (Region-Restricted Access Denied)
- DOMAIN-SUFFIX,apartmentratings.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apartments.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bankmobilevibe.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bing.com,ChumoGH-ADM
- DOMAIN-SUFFIX,booktopia.com.au,ChumoGH-ADM
- DOMAIN-SUFFIX,cccat.io,ChumoGH-ADM
- DOMAIN-SUFFIX,centauro.com.br,ChumoGH-ADM
- DOMAIN-SUFFIX,clearsurance.com,ChumoGH-ADM
- DOMAIN-SUFFIX,costco.com,ChumoGH-ADM
- DOMAIN-SUFFIX,crackle.com,ChumoGH-ADM
- DOMAIN-SUFFIX,depositphotos.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,dish.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dmm.co.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,dmm.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dnvod.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,esurance.com,ChumoGH-ADM
- DOMAIN-SUFFIX,extmatrix.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fastpic.ru,ChumoGH-ADM
- DOMAIN-SUFFIX,flipboard.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fnac.be,ChumoGH-ADM
- DOMAIN-SUFFIX,fnac.com,ChumoGH-ADM
- DOMAIN-SUFFIX,funkyimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fxnetworks.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gettyimages.com,ChumoGH-ADM
- DOMAIN-SUFFIX,go.com,ChumoGH-ADM
- DOMAIN-SUFFIX,here.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jcpenney.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jiehua.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,mailfence.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nationwide.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nbc.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nexon.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nordstrom.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nordstromimage.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nordstromrack.com,ChumoGH-ADM
- DOMAIN-SUFFIX,superpages.com,ChumoGH-ADM
- DOMAIN-SUFFIX,target.com,ChumoGH-ADM
- DOMAIN-SUFFIX,thinkgeek.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tracfone.com,ChumoGH-ADM
- DOMAIN-SUFFIX,unity3d.com,ChumoGH-ADM
- DOMAIN-SUFFIX,uploader.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,vevo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,viu.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,vk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,vsco.co,ChumoGH-ADM
- DOMAIN-SUFFIX,xfinity.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zattoo.com,ChumoGH-ADM
# USER-AGENT,Roam*,ChumoGH-ADM

# (The Most Popular Sites)
# > ChumoGH-ADM
# >> TestFlight
- DOMAIN,testflight.apple.com,ChumoGH-ADM
# >> ChumoGH-ADM URL Shortener
- DOMAIN-SUFFIX,appsto.re,ChumoGH-ADM
# >> iBooks Store download
- DOMAIN,books.itunes.apple.com,ChumoGH-ADM
# >> iTunes Store Moveis Trailers
- DOMAIN,hls.itunes.apple.com,ChumoGH-ADM
# >> App Store Preview
- DOMAIN,apps.apple.com,ChumoGH-ADM
- DOMAIN,itunes.apple.com,ChumoGH-ADM
# >> Spotlight
- DOMAIN,api-glb-sea.smoot.apple.com,ChumoGH-ADM
# >> Dictionary
- DOMAIN,lookup-api.apple.com,ChumoGH-ADM
# > Google
- DOMAIN-SUFFIX,abc.xyz,ChumoGH-ADM
- DOMAIN-SUFFIX,android.com,ChumoGH-ADM
- DOMAIN-SUFFIX,androidify.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dialogflow.com,ChumoGH-ADM
- DOMAIN-SUFFIX,autodraw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,capitalg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,certificate-transparency.org,ChumoGH-ADM
- DOMAIN-SUFFIX,chrome.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chromeexperiments.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chromestatus.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chromium.org,ChumoGH-ADM
- DOMAIN-SUFFIX,creativelab5.com,ChumoGH-ADM
- DOMAIN-SUFFIX,debug.com,ChumoGH-ADM
- DOMAIN-SUFFIX,deepmind.com,ChumoGH-ADM
- DOMAIN-SUFFIX,firebaseio.com,ChumoGH-ADM
- DOMAIN-SUFFIX,getmdl.io,ChumoGH-ADM
- DOMAIN-SUFFIX,ggpht.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gmail.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gmodules.com,ChumoGH-ADM
- DOMAIN-SUFFIX,godoc.org,ChumoGH-ADM
- DOMAIN-SUFFIX,golang.org,ChumoGH-ADM
- DOMAIN-SUFFIX,gstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gwtproject.org,ChumoGH-ADM
- DOMAIN-SUFFIX,itasoftware.com,ChumoGH-ADM
- DOMAIN-SUFFIX,madewithcode.com,ChumoGH-ADM
- DOMAIN-SUFFIX,material.io,ChumoGH-ADM
- DOMAIN-SUFFIX,polymer-project.org,ChumoGH-ADM
- DOMAIN-SUFFIX,admin.recaptcha.net,ChumoGH-ADM
- DOMAIN-SUFFIX,recaptcha.net,ChumoGH-ADM
- DOMAIN-SUFFIX,shattered.io,ChumoGH-ADM
- DOMAIN-SUFFIX,synergyse.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tensorflow.org,ChumoGH-ADM
- DOMAIN-SUFFIX,tfhub.dev,ChumoGH-ADM
- DOMAIN-SUFFIX,tiltbrush.com,ChumoGH-ADM
- DOMAIN-SUFFIX,waveprotocol.org,ChumoGH-ADM
- DOMAIN-SUFFIX,waymo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,webmproject.org,ChumoGH-ADM
- DOMAIN-SUFFIX,webrtc.org,ChumoGH-ADM
- DOMAIN-SUFFIX,whatbrowser.org,ChumoGH-ADM
- DOMAIN-SUFFIX,widevine.com,ChumoGH-ADM
- DOMAIN-SUFFIX,x.company,ChumoGH-ADM
- DOMAIN-SUFFIX,youtu.be,ChumoGH-ADM
- DOMAIN-SUFFIX,yt.be,ChumoGH-ADM
- DOMAIN-SUFFIX,ytimg.com,ChumoGH-ADM
# > Microsoft
# >> Microsoft OneDrive
- DOMAIN-SUFFIX,1drv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,1drv.ms,ChumoGH-ADM
- DOMAIN-SUFFIX,blob.core.windows.net,ChumoGH-ADM
- DOMAIN-SUFFIX,livefilestore.com,ChumoGH-ADM
- DOMAIN-SUFFIX,onedrive.com,ChumoGH-ADM
- DOMAIN-SUFFIX,storage.live.com,ChumoGH-ADM
- DOMAIN-SUFFIX,storage.msn.com,ChumoGH-ADM
- DOMAIN,oneclient.sfx.ms,ChumoGH-ADM
# > Other
- DOMAIN-SUFFIX,0rz.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,4bluestones.biz,ChumoGH-ADM
- DOMAIN-SUFFIX,9bis.net,ChumoGH-ADM
- DOMAIN-SUFFIX,allconnected.co,ChumoGH-ADM
- DOMAIN-SUFFIX,aol.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bcc.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,bit.ly,ChumoGH-ADM
- DOMAIN-SUFFIX,bitshare.com,ChumoGH-ADM
- DOMAIN-SUFFIX,blog.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,blogimg.jp,ChumoGH-ADM
- DOMAIN-SUFFIX,blogtd.org,ChumoGH-ADM
- DOMAIN-SUFFIX,broadcast.co.nz,ChumoGH-ADM
- DOMAIN-SUFFIX,camfrog.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cfos.de,ChumoGH-ADM
- DOMAIN-SUFFIX,citypopulation.de,ChumoGH-ADM
- DOMAIN-SUFFIX,cloudfront.net,ChumoGH-ADM
- DOMAIN-SUFFIX,ctitv.com.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,cuhk.edu.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,cusu.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,discord.gg,ChumoGH-ADM
- DOMAIN-SUFFIX,discuss.com.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,dropboxapi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,duolingo.cn,ChumoGH-ADM
- DOMAIN-SUFFIX,edditstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,flickriver.com,ChumoGH-ADM
- DOMAIN-SUFFIX,focustaiwan.tw,ChumoGH-ADM
- DOMAIN-SUFFIX,free.fr,ChumoGH-ADM
- DOMAIN-SUFFIX,gigacircle.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hk-pub.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hosting.co.uk,ChumoGH-ADM
- DOMAIN-SUFFIX,hwcdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,ifixit.com,ChumoGH-ADM
- DOMAIN-SUFFIX,iphone4hongkong.com,ChumoGH-ADM
- DOMAIN-SUFFIX,iphonetaiwan.org,ChumoGH-ADM
- DOMAIN-SUFFIX,iptvbin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,linksalpha.com,ChumoGH-ADM
- DOMAIN-SUFFIX,manyvids.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myactimes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,newsblur.com,ChumoGH-ADM
- DOMAIN-SUFFIX,now.im,ChumoGH-ADM
- DOMAIN-SUFFIX,nowe.com,ChumoGH-ADM
- DOMAIN-SUFFIX,redditlist.com,ChumoGH-ADM
- DOMAIN-SUFFIX,s3.amazonaws.com,ChumoGH-ADM
- DOMAIN-SUFFIX,signal.org,ChumoGH-ADM
- DOMAIN-SUFFIX,smartmailcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sparknotes.com,ChumoGH-ADM
- DOMAIN-SUFFIX,streetvoice.com,ChumoGH-ADM
- DOMAIN-SUFFIX,supertop.co,ChumoGH-ADM
- DOMAIN-SUFFIX,tv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,typepad.com,ChumoGH-ADM
- DOMAIN-SUFFIX,udnbkk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,urbanairship.com,ChumoGH-ADM
- DOMAIN-SUFFIX,whispersystems.org,ChumoGH-ADM
- DOMAIN-SUFFIX,wikia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wolframalpha.com,ChumoGH-ADM
- DOMAIN-SUFFIX,x-art.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yimg.com,ChumoGH-ADM
- DOMAIN,api.steampowered.com,ChumoGH-ADM
- DOMAIN,store.steampowered.com,ChumoGH-ADM

# China Area Network
# > 360
- DOMAIN-SUFFIX,qhres.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qhimg.com,ChumoGH-ADM
# > Akamai
- DOMAIN-SUFFIX,akadns.net,ChumoGH-ADM
# - DOMAIN-SUFFIX,akamai.net,ChumoGH-ADM
# - DOMAIN-SUFFIX,akamaiedge.net,ChumoGH-ADM
# - DOMAIN-SUFFIX,akamaihd.net,ChumoGH-ADM
# - DOMAIN-SUFFIX,akamaistream.net,ChumoGH-ADM
# - DOMAIN-SUFFIX,akamaized.net,ChumoGH-ADM
# > Alibaba
# USER-AGENT,%E4%BC%98%E9%85%B7*,ChumoGH-ADM
- DOMAIN-SUFFIX,alibaba.com,ChumoGH-ADM
- DOMAIN-SUFFIX,alicdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,alikunlun.com,ChumoGH-ADM
- DOMAIN-SUFFIX,alipay.com,ChumoGH-ADM
- DOMAIN-SUFFIX,amap.com,ChumoGH-ADM
- DOMAIN-SUFFIX,autonavi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dingtalk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mxhichina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,soku.com,ChumoGH-ADM
- DOMAIN-SUFFIX,taobao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tmall.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tmall.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,ykimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,youku.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xiami.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xiami.net,ChumoGH-ADM
# > Baidu
- DOMAIN-SUFFIX,baidu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,baidubcr.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bdstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yunjiasu-cdn.net,ChumoGH-ADM
# > bilibili
- DOMAIN-SUFFIX,acgvideo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,biliapi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,biliapi.net,ChumoGH-ADM
- DOMAIN-SUFFIX,bilibili.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bilibili.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,hdslb.com,ChumoGH-ADM
# > Blizzard
- DOMAIN-SUFFIX,blizzard.com,ChumoGH-ADM
- DOMAIN-SUFFIX,battle.net,ChumoGH-ADM
- DOMAIN,blzddist1-a.akamaihd.net,ChumoGH-ADM
# > ByteDance
- DOMAIN-SUFFIX,feiliao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pstatp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,snssdk.com,ChumoGH-ADM
- DOMAIN-SUFFIX,iesdouyin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,toutiao.com,ChumoGH-ADM
# > CCTV
- DOMAIN-SUFFIX,cctv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cctvpic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,livechina.com,ChumoGH-ADM
# > DiDi
- DOMAIN-SUFFIX,didialift.com,ChumoGH-ADM
- DOMAIN-SUFFIX,didiglobal.com,ChumoGH-ADM
- DOMAIN-SUFFIX,udache.com,ChumoGH-ADM
# > 蛋蛋赞
- DOMAIN-SUFFIX,343480.com,ChumoGH-ADM
- DOMAIN-SUFFIX,baduziyuan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,com-hs-hkdy.com,ChumoGH-ADM
- DOMAIN-SUFFIX,czybjz.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dandanzan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fjhps.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kuyunbo.club,ChumoGH-ADM
# > ChinaNet
- DOMAIN-SUFFIX,21cn.com,ChumoGH-ADM
# > HunanTV
- DOMAIN-SUFFIX,hitv.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mgtv.com,ChumoGH-ADM
# > iQiyi
- DOMAIN-SUFFIX,iqiyi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,iqiyipic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,71.am.com,ChumoGH-ADM
# > JD
- DOMAIN-SUFFIX,jd.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jd.hk,ChumoGH-ADM
- DOMAIN-SUFFIX,jdpay.com,ChumoGH-ADM
- DOMAIN-SUFFIX,360buyimg.com,ChumoGH-ADM
# > Kingsoft
- DOMAIN-SUFFIX,iciba.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ksosoft.com,ChumoGH-ADM
# > Meitu
- DOMAIN-SUFFIX,meitu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,meitudata.com,ChumoGH-ADM
- DOMAIN-SUFFIX,meitustat.com,ChumoGH-ADM
- DOMAIN-SUFFIX,meipai.com,ChumoGH-ADM
# > MI
- DOMAIN-SUFFIX,duokan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mi-img.com,ChumoGH-ADM
- DOMAIN-SUFFIX,miui.com,ChumoGH-ADM
- DOMAIN-SUFFIX,miwifi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xiaomi.com,ChumoGH-ADM
# > Microsoft
- DOMAIN-SUFFIX,microsoft.com,ChumoGH-ADM
- DOMAIN-SUFFIX,msecnd.net,ChumoGH-ADM
- DOMAIN-SUFFIX,office365.com,ChumoGH-ADM
- DOMAIN-SUFFIX,outlook.com,ChumoGH-ADM
- DOMAIN-SUFFIX,s-microsoft.com,ChumoGH-ADM
- DOMAIN-SUFFIX,visualstudio.com,ChumoGH-ADM
- DOMAIN-SUFFIX,windows.com,ChumoGH-ADM
- DOMAIN-SUFFIX,windowsupdate.com,ChumoGH-ADM
- DOMAIN,officecdn-microsoft-com.akamaized.net,ChumoGH-ADM
# > NetEase
# USER-AGENT,NeteaseMusic*,ChumoGH-ADM
# USER-AGENT,%E7%BD%91%E6%98%93%E4%BA%91%E9%9F%B3%E4%B9%90*,ChumoGH-ADM
- DOMAIN-SUFFIX,163.com,ChumoGH-ADM
- DOMAIN-SUFFIX,126.net,ChumoGH-ADM
- DOMAIN-SUFFIX,127.net,ChumoGH-ADM
- DOMAIN-SUFFIX,163yun.com,ChumoGH-ADM
- DOMAIN-SUFFIX,lofter.com,ChumoGH-ADM
- DOMAIN-SUFFIX,netease.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ydstatic.com,ChumoGH-ADM
# > Sina
- DOMAIN-SUFFIX,sina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,weibo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,weibocdn.com,ChumoGH-ADM
# > Sohu
- DOMAIN-SUFFIX,sohu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sohucs.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sohu-inc.com,ChumoGH-ADM
- DOMAIN-SUFFIX,v-56.com,ChumoGH-ADM
# > Sogo
- DOMAIN-SUFFIX,sogo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sogou.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sogoucdn.com,ChumoGH-ADM
# > Steam
- DOMAIN-SUFFIX,steampowered.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steam-chat.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamgames.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamusercontent.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamcontent.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,steamcdn-a.akamaihd.net,ChumoGH-ADM
- DOMAIN-SUFFIX,steamstat.us,ChumoGH-ADM
# > Tencent
# USER-AGENT,MicroMessenger%20Client,ChumoGH-ADM
# USER-AGENT,WeChat*,ChumoGH-ADM
- DOMAIN-SUFFIX,gtimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,idqqimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,igamecj.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myapp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myqcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qq.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tencent.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tencent-cloud.net,ChumoGH-ADM
# > YYeTs
# USER-AGENT,YYeTs*,ChumoGH-ADM
- DOMAIN-SUFFIX,jstucdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zimuzu.io,ChumoGH-ADM
- DOMAIN-SUFFIX,zimuzu.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,zmz2019.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zmzapi.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zmzapi.net,ChumoGH-ADM
- DOMAIN-SUFFIX,zmzfile.com,ChumoGH-ADM
# > Content Delivery Network
- DOMAIN-SUFFIX,ccgslb.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ccgslb.net,ChumoGH-ADM
- DOMAIN-SUFFIX,chinanetcenter.com,ChumoGH-ADM
- DOMAIN-SUFFIX,meixincdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ourdvs.com,ChumoGH-ADM
- DOMAIN-SUFFIX,staticdn.net,ChumoGH-ADM
- DOMAIN-SUFFIX,wangsu.com,ChumoGH-ADM
# > IP Query
- DOMAIN-SUFFIX,ipip.net,ChumoGH-ADM
- DOMAIN-SUFFIX,ip.la,ChumoGH-ADM
- DOMAIN-SUFFIX,ip-cdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ipv6-test.com,ChumoGH-ADM
- DOMAIN-SUFFIX,test-ipv6.com,ChumoGH-ADM
- DOMAIN-SUFFIX,whatismyip.com,ChumoGH-ADM
# > Speed Test
# - DOMAIN-SUFFIX,speedtest.net,ChumoGH-ADM
- DOMAIN-SUFFIX,netspeedtestmaster.com,ChumoGH-ADM
- DOMAIN,speedtest.macpaw.com,ChumoGH-ADM
# > Private Tracker
- DOMAIN-SUFFIX,awesome-hd.me,ChumoGH-ADM
- DOMAIN-SUFFIX,broadcasthe.net,ChumoGH-ADM
- DOMAIN-SUFFIX,chdbits.co,ChumoGH-ADM
- DOMAIN-SUFFIX,classix-unlimited.co.uk,ChumoGH-ADM
- DOMAIN-SUFFIX,empornium.me,ChumoGH-ADM
- DOMAIN-SUFFIX,gazellegames.net,ChumoGH-ADM
- DOMAIN-SUFFIX,hdchina.org,ChumoGH-ADM
- DOMAIN-SUFFIX,hdsky.me,ChumoGH-ADM
- DOMAIN-SUFFIX,icetorrent.org,ChumoGH-ADM
- DOMAIN-SUFFIX,jpopsuki.eu,ChumoGH-ADM
- DOMAIN-SUFFIX,keepfrds.com,ChumoGH-ADM
- DOMAIN-SUFFIX,madsrevolution.net,ChumoGH-ADM
- DOMAIN-SUFFIX,m-team.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,nanyangpt.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ncore.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,open.cd,ChumoGH-ADM
- DOMAIN-SUFFIX,ourbits.club,ChumoGH-ADM
- DOMAIN-SUFFIX,passthepopcorn.me,ChumoGH-ADM
- DOMAIN-SUFFIX,privatehd.to,ChumoGH-ADM
- DOMAIN-SUFFIX,redacted.ch,ChumoGH-ADM
- DOMAIN-SUFFIX,springsunday.net,ChumoGH-ADM
- DOMAIN-SUFFIX,tjupt.org,ChumoGH-ADM
- DOMAIN-SUFFIX,totheglory.im,ChumoGH-ADM
# > Scholar
- DOMAIN-SUFFIX,acm.org,ChumoGH-ADM
- DOMAIN-SUFFIX,acs.org,ChumoGH-ADM
- DOMAIN-SUFFIX,aip.org,ChumoGH-ADM
- DOMAIN-SUFFIX,ams.org,ChumoGH-ADM
- DOMAIN-SUFFIX,annualreviews.org,ChumoGH-ADM
- DOMAIN-SUFFIX,aps.org,ChumoGH-ADM
- DOMAIN-SUFFIX,ascelibrary.org,ChumoGH-ADM
- DOMAIN-SUFFIX,asm.org,ChumoGH-ADM
- DOMAIN-SUFFIX,asme.org,ChumoGH-ADM
- DOMAIN-SUFFIX,astm.org,ChumoGH-ADM
- DOMAIN-SUFFIX,bmj.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cambridge.org,ChumoGH-ADM
- DOMAIN-SUFFIX,cas.org,ChumoGH-ADM
- DOMAIN-SUFFIX,clarivate.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ebscohost.com,ChumoGH-ADM
- DOMAIN-SUFFIX,emerald.com,ChumoGH-ADM
- DOMAIN-SUFFIX,engineeringvillage.com,ChumoGH-ADM
- DOMAIN-SUFFIX,icevirtuallibrary.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ieee.org,ChumoGH-ADM
- DOMAIN-SUFFIX,imf.org,ChumoGH-ADM
- DOMAIN-SUFFIX,iop.org,ChumoGH-ADM
- DOMAIN-SUFFIX,jamanetwork.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jhu.edu,ChumoGH-ADM
- DOMAIN-SUFFIX,jstor.org,ChumoGH-ADM
- DOMAIN-SUFFIX,karger.com,ChumoGH-ADM
- DOMAIN-SUFFIX,libguides.com,ChumoGH-ADM
- DOMAIN-SUFFIX,madsrevolution.net,ChumoGH-ADM
- DOMAIN-SUFFIX,mpg.de,ChumoGH-ADM
- DOMAIN-SUFFIX,myilibrary.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nature.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oecd-ilibrary.org,ChumoGH-ADM
- DOMAIN-SUFFIX,osapublishing.org,ChumoGH-ADM
- DOMAIN-SUFFIX,oup.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ovid.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oxfordartonline.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oxfordbibliographies.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oxfordmusiconline.com,ChumoGH-ADM
- DOMAIN-SUFFIX,pnas.org,ChumoGH-ADM
- DOMAIN-SUFFIX,proquest.com,ChumoGH-ADM
- DOMAIN-SUFFIX,rsc.org,ChumoGH-ADM
- DOMAIN-SUFFIX,sagepub.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sciencedirect.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sciencemag.org,ChumoGH-ADM
- DOMAIN-SUFFIX,scopus.com,ChumoGH-ADM
- DOMAIN-SUFFIX,siam.org,ChumoGH-ADM
- DOMAIN-SUFFIX,spiedigitallibrary.org,ChumoGH-ADM
- DOMAIN-SUFFIX,springer.com,ChumoGH-ADM
- DOMAIN-SUFFIX,springerlink.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tandfonline.com,ChumoGH-ADM
- DOMAIN-SUFFIX,un.org,ChumoGH-ADM
- DOMAIN-SUFFIX,uni-bielefeld.de,ChumoGH-ADM
- DOMAIN-SUFFIX,webofknowledge.com,ChumoGH-ADM
- DOMAIN-SUFFIX,westlaw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,wiley.com,ChumoGH-ADM
- DOMAIN-SUFFIX,worldbank.org,ChumoGH-ADM
- DOMAIN-SUFFIX,worldscientific.com,ChumoGH-ADM
# > Plex Media Server
- DOMAIN-SUFFIX,plex.tv,ChumoGH-ADM
# > Other
- DOMAIN-SUFFIX,cn,ChumoGH-ADM
- DOMAIN-SUFFIX,360in.com,ChumoGH-ADM
- DOMAIN-SUFFIX,51ym.me,ChumoGH-ADM
- DOMAIN-SUFFIX,8686c.com,ChumoGH-ADM
- DOMAIN-SUFFIX,abchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,accuweather.com,ChumoGH-ADM
- DOMAIN-SUFFIX,aicoinstorge.com,ChumoGH-ADM
- DOMAIN-SUFFIX,air-matters.com,ChumoGH-ADM
- DOMAIN-SUFFIX,air-matters.io,ChumoGH-ADM
- DOMAIN-SUFFIX,aixifan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,amd.com,ChumoGH-ADM
- DOMAIN-SUFFIX,b612.net,ChumoGH-ADM
- DOMAIN-SUFFIX,bdatu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,beitaichufang.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bjango.com,ChumoGH-ADM
- DOMAIN-SUFFIX,booking.com,ChumoGH-ADM
- DOMAIN-SUFFIX,bstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cailianpress.com,ChumoGH-ADM
- DOMAIN-SUFFIX,camera360.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chinaso.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chua.pro,ChumoGH-ADM
- DOMAIN-SUFFIX,chuimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,chunyu.mobi,ChumoGH-ADM
- DOMAIN-SUFFIX,chushou.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,cmbchina.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cmbimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ctrip.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dfcfw.com,ChumoGH-ADM
- DOMAIN-SUFFIX,docschina.org,ChumoGH-ADM
- DOMAIN-SUFFIX,douban.com,ChumoGH-ADM
- DOMAIN-SUFFIX,doubanio.com,ChumoGH-ADM
- DOMAIN-SUFFIX,douyu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dxycdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,dytt8.net,ChumoGH-ADM
- DOMAIN-SUFFIX,eastmoney.com,ChumoGH-ADM
- DOMAIN-SUFFIX,eudic.net,ChumoGH-ADM
- DOMAIN-SUFFIX,feng.com,ChumoGH-ADM
- DOMAIN-SUFFIX,fengkongcloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,frdic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,futu5.com,ChumoGH-ADM
- DOMAIN-SUFFIX,futunn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gandi.net,ChumoGH-ADM
- DOMAIN-SUFFIX,geilicdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,getpricetag.com,ChumoGH-ADM
- DOMAIN-SUFFIX,gifshow.com,ChumoGH-ADM
- DOMAIN-SUFFIX,godic.net,ChumoGH-ADM
- DOMAIN-SUFFIX,hicloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hongxiu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,hostbuf.com,ChumoGH-ADM
- DOMAIN-SUFFIX,huxiucdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,huya.com,ChumoGH-ADM
- DOMAIN-SUFFIX,infinitynewtab.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ithome.com,ChumoGH-ADM
- DOMAIN-SUFFIX,java.com,ChumoGH-ADM
- DOMAIN-SUFFIX,jidian.im,ChumoGH-ADM
- DOMAIN-SUFFIX,kaiyanapp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kaspersky-labs.com,ChumoGH-ADM
- DOMAIN-SUFFIX,keepcdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,kkmh.com,ChumoGH-ADM
- DOMAIN-SUFFIX,licdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,linkedin.com,ChumoGH-ADM
- DOMAIN-SUFFIX,loli.net,ChumoGH-ADM
- DOMAIN-SUFFIX,luojilab.com,ChumoGH-ADM
- DOMAIN-SUFFIX,maoyan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,maoyun.tv,ChumoGH-ADM
- DOMAIN-SUFFIX,meituan.com,ChumoGH-ADM
- DOMAIN-SUFFIX,meituan.net,ChumoGH-ADM
- DOMAIN-SUFFIX,mobike.com,ChumoGH-ADM
- DOMAIN-SUFFIX,moke.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mubu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,myzaker.com,ChumoGH-ADM
- DOMAIN-SUFFIX,nim-lang-cn.org,ChumoGH-ADM
- DOMAIN-SUFFIX,nvidia.com,ChumoGH-ADM
- DOMAIN-SUFFIX,oracle.com,ChumoGH-ADM
- DOMAIN-SUFFIX,paypal.com,ChumoGH-ADM
- DOMAIN-SUFFIX,paypalobjects.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qdaily.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qidian.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qyer.com,ChumoGH-ADM
- DOMAIN-SUFFIX,qyerstatic.com,ChumoGH-ADM
- DOMAIN-SUFFIX,raychase.net,ChumoGH-ADM
- DOMAIN-SUFFIX,ronghub.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ruguoapp.com,ChumoGH-ADM
- DOMAIN-SUFFIX,s-reader.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sankuai.com,ChumoGH-ADM
- DOMAIN-SUFFIX,scomper.me,ChumoGH-ADM
- DOMAIN-SUFFIX,seafile.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sm.ms,ChumoGH-ADM
- DOMAIN-SUFFIX,smzdm.com,ChumoGH-ADM
- DOMAIN-SUFFIX,snapdrop.net,ChumoGH-ADM
- DOMAIN-SUFFIX,snwx.com,ChumoGH-ADM
- DOMAIN-SUFFIX,sspai.com,ChumoGH-ADM
- DOMAIN-SUFFIX,takungpao.com,ChumoGH-ADM
- DOMAIN-SUFFIX,teamviewer.com,ChumoGH-ADM
- DOMAIN-SUFFIX,tianyancha.com,ChumoGH-ADM
- DOMAIN-SUFFIX,udacity.com,ChumoGH-ADM
- DOMAIN-SUFFIX,uning.com,ChumoGH-ADM
- DOMAIN-SUFFIX,vmware.com,ChumoGH-ADM
- DOMAIN-SUFFIX,weather.com,ChumoGH-ADM
- DOMAIN-SUFFIX,weico.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,weidian.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xiachufang.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ximalaya.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xinhuanet.com,ChumoGH-ADM
- DOMAIN-SUFFIX,xmcdn.com,ChumoGH-ADM
- DOMAIN-SUFFIX,yangkeduo.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zhangzishi.cc,ChumoGH-ADM
- DOMAIN-SUFFIX,zhihu.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zhimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,zhuihd.com,ChumoGH-ADM
- DOMAIN,download.jetbrains.com,ChumoGH-ADM
- DOMAIN,images-cn.ssl-images-amazon.com,ChumoGH-ADM

# > ChumoGH-ADM
- DOMAIN-SUFFIX,aaplimg.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apple.co,ChumoGH-ADM
- DOMAIN-SUFFIX,apple.com,ChumoGH-ADM
- DOMAIN-SUFFIX,apple-cloudkit.com,ChumoGH-ADM
- DOMAIN-SUFFIX,appstore.com,ChumoGH-ADM
- DOMAIN-SUFFIX,cdn-apple.com,ChumoGH-ADM
- DOMAIN-SUFFIX,crashlytics.com,ChumoGH-ADM
- DOMAIN-SUFFIX,icloud.com,ChumoGH-ADM
- DOMAIN-SUFFIX,icloud-content.com,ChumoGH-ADM
- DOMAIN-SUFFIX,me.com,ChumoGH-ADM
- DOMAIN-SUFFIX,mzstatic.com,ChumoGH-ADM
- DOMAIN,www-cdn.icloud.com.akadns.net,ChumoGH-ADM
- DOMAIN,clash.razord.top,ChumoGH-ADM
- DOMAIN,v2ex.com,ChumoGH-ADM
- IP-CIDR,17.0.0.0/8,ChumoGH-ADM,no-resolve

# Local Area Network
- IP-CIDR,192.168.0.0/16,ChumoGH-ADM
- IP-CIDR,10.0.0.0/8,ChumoGH-ADM
- IP-CIDR,172.16.0.0/12,ChumoGH-ADM
- IP-CIDR,127.0.0.0/8,ChumoGH-ADM
- IP-CIDR,100.64.0.0/10,ChumoGH-ADM

# DNSPod Public DNS+
- IP-CIDR,119.28.28.28/32,ChumoGH-ADM,no-resolve
# GeoIP China
- GEOIP,CN,ChumoGH-ADM

- MATCH,ChumoGH-ADM

proxies:' >> /root/.config/clash/config.yaml 
[[ $mode = 2 ]] && echo -e '
proxies:' >> /root/.config/clash/config.yaml 
}

conFIN() {
confRULE
[[ ! -z ${proTRO} ]] && echo -e "${proTRO}" >> /root/.config/clash/config.yaml
[[ ! -z ${proV2R} ]] && echo -e "${proV2R}" >> /root/.config/clash/config.yaml

#echo ''

echo "#POWER BY @ChumoGH" >> /root/.config/clash/config.yaml
}

enon(){
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * clash.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
enoff(){
rm -f /bin/clash.sh
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de clash.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}

enttrada () {
echo 'source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/CLASH/ClashForAndroidGLOBAL.sh)' > /bin/clash.sh && chmod +x /bin/clash.sh
}

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}
title(){
	msg -bar3
	blanco "$1"
	msg -bar3
}
col(){
	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}
col2(){
	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}
vacio(){
blanco "\n no se puede ingresar campos vacios..."
}
cancelar(){
echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}
continuar(){
echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}
userDat(){
	blanco "	NÂ°    Usuarios 		  fech exp   dias"
	msg -bar3
}
view_usert(){
configt="/usr/local/etc/trojan/config.json"
tempt="/etc/trojan/temp.json"
trojdirt="/etc/trojan" 
user_conft="/etc/trojan/user"
backdirt="/etc/trojan/back" 
tmpdirt="$backdir/tmp"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /bin/ejecutar/trojanports.txt && cat /bin/ejecutar/trojanports.txt`;
troport=$(cat /bin/ejecutar/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	unset seg
	seg=$(date +%s)
	while :
	do
	nick="$(cat $configt | grep ',"')"
	users="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
		title "	ESCOJE USUARIO TROJAN"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = "chumoghscript" ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conft}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "SELECCIONA USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && tropass="user_null" && break
		n=1
		unset i
		for i in $users
		do
		[[ $n = $opcion ]] && tropass=$i
			let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		echo "USER SELECIONADO : $tropass " 
		break
	done
}

view_user(){
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)
		echo "Usuario $ps Seleccionado" 
		break
	done
}

[[ ! -d /root/.config/clash ]] && fun_insta || fun_ip
clear
[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChumoGHðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
fileon=$(ls -la /var/www/html | grep "yaml" | wc -l)
filelo=$(ls -la /root/.config/clash | grep "yaml" | wc -l)
cd
msg -bar3
echo -e "\033[1;37m ✬  Linux Dist: $(less /etc/issue.net)\033[0m"
msg -bar3
echo -e "\033[1;37m ✬ Ficheros Online:	$fileon  ✬ Ficheros Locales: $filelo\033[0m"
msg -bar3
echo -e "\033[1;37m - Menu Iterativo Clash for Android - ChumoGH \033[0m"
msg -bar3
echo -e "\033[1;37mSeleccione :    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
unset yesno
echo -e " DESEAS CONTINUAR CON LA CARGA DE CONFIG CLASH?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno numwt
#[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChumoGHðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa tu Whatsapp junto a tu codigo de Pais"
read -p " Ejemplo: +593987072611 : " numwt
if [[ -z $numwt ]]; then
numwt='+593987072611'
fi
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa Clase de Servidor ( Gratis - PREMIUM )"
read -p " Ejemplo: PREMIUM : " srvip
if [[ -z $srvip ]]; then
srvip="NewADM"
fi
	while :
	do
	[[ -z ${opcion} ]] || break
		clear
		echo -e " ESCOJE TU METODO DE SELECCION "
		echo -e "  "
		echo -e " SINO CONOCES DE ESTO, ESCOJE 2 "
		echo -e "  "
		msg -bar
		echo -e "1 - SELECTOR RULES"
		echo -e "2 - SELECTOR GLOBAL"
		msg -bar
		echo -e " 0) CANCELAR"
		msg -bar
		read -p " ESCOJE : " opcion
		case $opcion in
			1)configINIT_rule "$opcion"
			break;;
			2)configINIT_global "$opcion"
			break;;
			0) break;;
			*) echo -e "\n selecione una opcion del 0 al 2" && sleep 0.3s;;
		esac
	done
INITClash
fi
