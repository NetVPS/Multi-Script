#!/bin/bash

function blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
function version_lt(){
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; 
}
#copy from 秋水逸冰 ss scripts
if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
fi
systempwd="/etc/systemd/system/"

#install & config trojan
function install_trojan(){
$systemPackage install -y nginx
systemctl stop nginx
sleep 5
cat > /etc/nginx/nginx.conf <<-EOF
user  root;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    keepalive_timeout  120;
    client_max_body_size 20m;
    #gzip  on;
    server {
        listen       80;
        server_name  $your_domain;
        root /usr/share/nginx/html;
        index index.php index.html index.htm;
    }
}
EOF
	#设置伪装站
	rm -rf /usr/share/nginx/html/*
	cd /usr/share/nginx/html/
	wget https://www.dropbox.com/s/m6d5gniodueiumv/web.zip >/dev/null 2>&1
    	unzip web.zip >/dev/null 2>&1
	sleep 5
	#申请https证书
	if [ ! -d "/usr/src" ]; then
	    mkdir /usr/src
	fi
	mkdir /usr/src/trojan-cert /usr/src/trojan-temp
	curl https://get.acme.sh | sh
	~/.acme.sh/acme.sh  --issue  -d $your_domain  --standalone
	if test -s /root/.acme.sh/$your_domain/fullchain.cer; then
	systemctl start nginx
        cd /usr/src
	#wget https://github.com/trojan-gfw/trojan/releases/download/v1.13.0/trojan-1.13.0-linux-amd64.tar.xz
	wget https://api.github.com/repos/trojan-gfw/trojan/releases/latest >/dev/null 2>&1
	latest_version=`grep tag_name latest| awk -F '[:,"v]' '{print $6}'`
	rm -f latest
	wget https://www.dropbox.com/s/70swgj1gods17xu/trojan-1.13.0-linux-amd64.tar.xz >/dev/null 2>&1
	tar xf trojan-1.13.0-linux-amd64.tar.xz >/dev/null 2>&1
	#下载trojan客户端
	wget https://www.dropbox.com/s/yegoxa4hfo5sf2z/trojan-cli.zip >/dev/null 2>&1
	wget -P /usr/src/trojan-temp https://github.com/trojan-gfw/trojan/releases/download/v${latest_version}/trojan-${latest_version}-win.zip >/dev/null 2>&1
	unzip trojan-cli.zip >/dev/null 2>&1
	unzip /usr/src/trojan-temp/trojan-${latest_version}-win.zip -d /usr/src/trojan-temp/ >/dev/null 2>&1
	mv -f /usr/src/trojan-temp/trojan/trojan.exe /usr/src/trojan-cli/ 
	trojan_passwd=$(cat /dev/urandom | head -1 | md5sum | head -c 8)
	unset porta
	echo "================================================================="
	read -p " INGRESE PUERTO TROJAN A USAR : " porta
	echo "================================================================="
	[[ -z $porta ]] && porta="443"
	cat > /usr/src/trojan-cli/config.yml <<-EOF
port: 7890
socks-port: 7891
redir-port: 7892
allow-lan: true
mode: Global
log-level: info
external-controller: '0.0.0.0:9090'
secret: ''

dns:
  enable: true
  nameserver:
    - 1.1.1.1
	- 1.0.0.1

proxies:
- name: Trojan 
  type: "trojan"
  server: $your_domain
  port: 443
  password: $trojan_passwd
  udp: true
  sni: www.tuhost.com
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true

# Eliminar "#" si configura v2ray
#- name: V2ray
#  type: vmess
#  server: 123.0.0.0
#  port: 
#  uuid: 
#  alterId: 
#  cipher: auto
#  udp: true
#  tls: true
#  skip-cert-verify: true
#  network: ws
#  ws-path: /
#  ws-headers: {host: www.tuhost.com}
  
###################################
EOF
	rm -rf /usr/local/etc/trojan/config.json
	cat > /usr/local/etc/trojan/config.json <<-EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "$trojan_passwd"
		 ,"chumoghscript"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/src/trojan-cert/fullchain.cer",
        "key": "/usr/src/trojan-cert/private.key",
        "key_password": "",
        "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
	"prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": ""
    }
}
EOF
	cd /usr/src/trojan-cli/
	config.yml /usr/src/trojan-cli/
	trojan_path=$(cat /dev/urandom | head -1 | md5sum | head -c 16)
	mkdir /usr/share/nginx/html/${trojan_path}
	mv /usr/src/trojan-cli/config.yml /usr/share/nginx/html/${trojan_path}/
	#增加启动脚本
	
cat > ${systempwd}trojan.service <<-EOF
[Unit]  
Description=trojan  
After=network.target  
   
[Service]  
Type=simple  
PIDFile=/usr/src/trojan/trojan/trojan.pid
ExecStart=/usr/src/trojan/trojan -c "/usr/local/etc/trojan/config.json"  
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
RestartSec=1s
   
[Install]  
WantedBy=multi-user.target
EOF

	chmod +x ${systempwd}trojan.service
	systemctl enable trojan.service
	cd /root
	~/.acme.sh/acme.sh  --installcert  -d  $your_domain   \
        --key-file   /usr/src/trojan-cert/private.key \
        --fullchain-file  /usr/src/trojan-cert/fullchain.cer \
	--reloadcmd  "systemctl restart trojan"	
	green "=============================================================="
	green "Se ha instalado trojan, utilice el siguiente enlace para\ndescargar el archivo .yml para configurar en Clash."
	blue "http://${your_domain}/$trojan_path/config.yml"
	red "Link único y generado de manera aleatoria."
	green "=============================================================="
	green "Puede modificar el archivo .yml abriéndolo como Texto. "
	green "Recuerde modificar el dominio por la ip en el archivo yml. "
	green "Todo viene configurado, pero para que funcione correctamente\ntiene que modificar el host."
	green "=============================================================="
	red "Si gusta configurar manualmente, esta es la información:"
	blue "Dominio: $your_domain"
	blue "Puerto: 443"
	blue "Contraseña: $trojan_passwd"
	green "=============================================================="
	else
        red "==================================="
	red "Si el certificado https no obtuvo resultados\nde solicitud y la instalación automática falló"
	green "No se preocupe, puede reparar manualmente la solicitud del certificado."
	green "1. Reinicie la VPS."
	green "2. Vuelva a ejecutar el script y use la función de reparación de certificado."
	red "==================================="
	fi
}
function preinstall_check(){

nginx_status=`ps -aux | grep "nginx: worker" |grep -v "grep"`
if [ -n "$nginx_status" ]; then
    systemctl stop nginx
fi
$systemPackage -y install net-tools socat
Port80=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w 80`
Port443=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w 443`
if [ -n "$Port80" ]; then
    process80=`netstat -tlpn | awk -F '[: ]+' '$5=="80"{print $9}'`
    red "==========================================================="
    red "Se detectó que el puerto 80 está ocupado, el proceso que lo\nocupa es:${process80}，La instalación ha finalizado."
    red "==========================================================="
    exit 1
fi
if [ -n "$Port443" ]; then
    process443=`netstat -tlpn | awk -F '[: ]+' '$5=="443"{print $9}'`
    red "============================================================="
    red "Se detectó que el puerto 443 está ocupado, el proceso que lo\nocupa es:：${process443}，La instalación ha finalizado."
    red "============================================================="
    exit 1
fi
if [ -f "/etc/selinux/config" ]; then
    CHECK=$(grep SELINUX= /etc/selinux/config | grep -v "#")
    if [ "$CHECK" != "SELINUX=disabled" ]; then
        green "Se detectó que SELinux está activado, se agregaran las reglas del puerto 80/443"
        yum install -y policycoreutils-python >/dev/null 2>&1
        semanage port -m -t http_port_t -p tcp 80
        semanage port -m -t http_port_t -p tcp 443
    fi
fi
if [ "$release" == "centos" ]; then
    if  [ -n "$(grep ' 6\.' /etc/redhat-release)" ] ;then
    red "==============="
    red "El sistema actual no es compatible."
    red "==============="
    exit
    fi
    if  [ -n "$(grep ' 5\.' /etc/redhat-release)" ] ;then
    red "==============="
    red "El sistema actual no es compatible."
    red "==============="
    exit
    fi
    firewall_status=`systemctl status firewalld | grep "Active: active"`
    if [ -n "$firewall_status" ]; then
        green "Se detectó que el firewall está activado, se agregaran las reglas del puerto 80/443"
        firewall-cmd --zone=public --add-port=80/tcp --permanent
	firewall-cmd --zone=public --add-port=443/tcp --permanent
	firewall-cmd --reload
    fi
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
elif [ "$release" == "ubuntu" ]; then
    if  [ -n "$(grep ' 14\.' /etc/os-release)" ] ;then
    red "==============="
    red "El sistema actual no es compatible."
    red "==============="
    exit
    fi
    if  [ -n "$(grep ' 12\.' /etc/os-release)" ] ;then
    red "==============="
    red "El sistema actual no es compatible."
    red "==============="
    exit
    fi
    ufw_status=`systemctl status ufw | grep "Active: active"`
    if [ -n "$ufw_status" ]; then
        ufw allow 80/tcp
        ufw allow 443/tcp
    fi
    apt-get update
elif [ "$release" == "debian" ]; then
    ufw_status=`systemctl status ufw | grep "Active: active"`
    if [ -n "$ufw_status" ]; then
        ufw allow 80/tcp
        ufw allow 443/tcp
    fi
    apt-get update
fi
$systemPackage -y install  wget unzip zip curl tar >/dev/null 2>&1
green "======================="
blue "Ingrese el dominio vinculado a esta VPS " && read -p ": " your_domain
green "======================="

real_addr=`ping ${your_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
local_addr=`curl ipv4.icanhazip.com`
if [ $real_addr == $local_addr ] ; then
	green "=========================================="
	green "La resolución del dominio es normal, se intalará trojan"
	green "=========================================="
	sleep 1s
        install_trojan
	
else
        red "===================================="
	red "La resolución de dominio es inconsistente con la dirección IP de la VPS"
	red "Si cree que el análisis es correcto, puede forzar a que el script continúe"
	red "===================================="
	read -p "¿Forzar el script? Seleccione [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
            green "Forzar el script"
	    sleep 1s
	    install_trojan
	else
	    exit 1
	fi
fi
}

function repair_cert(){
systemctl stop nginx
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
Port80=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w 80`
if [ -n "$Port80" ]; then
    process80=`netstat -tlpn | awk -F '[: ]+' '$5=="80"{print $9}'`
    red "==========================================================="
    red "Se detectó que el puerto 80 está ocupado, el proceso que lo\nocupa es:${process80}，La instalación ha finalizado."
    red "==========================================================="
    exit 1
fi
green "======================="
blue "Ingrese el dominio vinculado a esta VPS."
blue "Debe ser el mismo dominio que no pudo usar antes."
green "======================="
read your_domain
real_addr=`ping ${your_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
local_addr=`curl ipv4.icanhazip.com`
if [ $real_addr == $local_addr ] ; then
    ~/.acme.sh/acme.sh  --issue  -d $your_domain  --standalone
    ~/.acme.sh/acme.sh  --installcert  -d  $your_domain   \
        --key-file   /usr/src/trojan-cert/private.key \
        --fullchain-file /usr/src/trojan-cert/fullchain.cer \
	--reloadcmd  "systemctl restart trojan"
    if test -s /usr/src/trojan-cert/fullchain.cer; then
        green "Solicitud de certificado exitosa."
	green "Descargue fullchain.cer en /usr/src/trojan-cert/ en la carpeta del cliente trojan-cli"
	systemctl restart trojan
	systemctl start nginx
    else
    	red "No se pudo solicitar el certificado."
    fi
else
    red "================================"
    red "La resolución de dominio es inconsistente con la dirección IP de la VPS"
    red "La instalación falló, asegúrese de que la resolución del dominio sea normal"
    red "================================"
fi	
}

function remove_trojan(){
    red "================================"
    red "Trojan se desintalará"
    red "Nginx también se desintalará"
    red "================================"
    systemctl stop trojan
    systemctl disable trojan
    rm -f ${systempwd}trojan.service
    if [ "$release" == "centos" ]; then
        yum remove -y nginx
    else
        apt autoremove -y nginx
    fi
    rm -rf /usr/src/trojan*
    rm -rf /usr/share/nginx/html/*
    rm -rf /root/.acme.sh/
    green "=============="
    green "Trojan desinstalado."
    green "=============="
}

function update_trojan(){
    /usr/src/trojan/trojan -v 2>trojan.tmp
    curr_version=`cat trojan.tmp | grep "trojan" | awk '{print $4}'`
    wget https://api.github.com/repos/trojan-gfw/trojan/releases/latest >/dev/null 2>&1
    latest_version=`grep tag_name latest| awk -F '[:,"v]' '{print $6}'`
    rm -f latest
    rm -f trojan.tmp
    if version_lt "$curr_version" "$latest_version"; then
        green "Versión actual: $curr_version, Última versión: $latest_version, actualizando……"
        mkdir trojan_update_temp && cd trojan_update_temp
        wget https://github.com/trojan-gfw/trojan/releases/download/v${latest_version}/trojan-${latest_version}-linux-amd64.tar.xz >/dev/null 2>&1
        tar xf trojan-${latest_version}-linux-amd64.tar.xz >/dev/null 2>&1
        mv ./trojan/trojan /usr/src/trojan/
        cd .. && rm -rf trojan_update_temp
        systemctl restart trojan
	/usr/src/trojan/trojan -v 2>trojan.tmp
	green "Se completó la actualización de trojan, la versión actual es:`cat trojan.tmp | grep "trojan" | awk '{print $4}'`"
	rm -f trojan.tmp
    else
        green "Versión actual: $curr_version, Última versión: $latest_version, no es necesario actualizar."
    fi
   
   
}

start_menu(){
    clear
    green " ======================================="
    green " Script de Instalación de Trojan      "
    green " Sistemas：centos7+/debian9+/ubuntu16.04+"
    green " Edicion ChumoGH - ADM         "
    blue " Declaración："
    red " *No use este script en ningún entorno de producción."
    red " *No debe tener ocupados los puertos 80/443."
	red " *Siga las instrucciones."
    green " ======================================="
    echo
    green " 1. Instalar trojan"
    red " 2. Desinstalar trojan"
    green " 3. Actualizar trojan"
    green " 4. Reparar certificado"
    blue " 0. Salir del script"
    echo
    read -p "Ingrese una opción:" num
    case "$num" in
    1)
    preinstall_check
    ;;
    2)
    remove_trojan 
    ;;
    3)
    update_trojan 
    ;;
    4)
    repair_cert 
    ;;
    0)
    adm 1
    ;;
    *)
    clear
    red "Ingrese una opción correcta."
    sleep 1s
    start_menu
    ;;
    esac
}

start_menu
