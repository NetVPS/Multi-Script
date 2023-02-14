#!/bin/bash
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
barra="\033[0;31m=====================================================\033[0m"

install_ini () {
clear
echo -e "$barra"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$barra"
#dropbear
[[ $(dpkg --get-selections|grep -w "dropbear"|head -1) ]] || apt-get install dropbear -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "dropbear"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "dropbear"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install dropbear................ $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs.................. $ESTATUS "
#build-essential
[[ $(dpkg --get-selections|grep -w "build-essential"|head -1) ]] || apt-get install build-essential -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "build-essential"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "build-essential"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install build-essential......... $ESTATUS "
#PV
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || apt-get install pv -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install PV   ................... $ESTATUS "
echo -e "$barra"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$barra"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}

fun_log () {
[[ -e /bin/ejecutar/sshd_config ]] && { 
####
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] && echo -e "/bin/false" >> /etc/shells
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
} || {
cp /etc/ssh/sshd_config /bin/ejecutar/sshd_config
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] && {
sed -i "s;/bin/false;;g" /etc/shells
sed -i "s;/usr/sbin/nologin;;g" /etc/shells
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
}
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
}
######################

}

car_cert () {
[[ -e /etc/stunnel/stunnel.pem ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar
echo -e "Descarga el fichero URL del Certificado SSL " 
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
msg -bar
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar
read -p " Pega tu Link : " urlm
wget -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar 
unzip certificados.zip 1> /dev/null 2> /dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /etc/stunnel/stunnel.pem && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt >> /etc/stunnel/stunnel.pem && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip 1> /dev/null 2> /dev/null && cd $HOME
unset porta1
if [[ -z $porta1  ]]; then
	porta1="443"
fi
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo " $(source trans -b pt:${id} "Ingresa Puerto SSL a USAR ( Defauld 443 ) ") "
    read -p " Listen-Dropbear: " porta1
    [[ $(mportas|grep $porta1) ]] || break
    echo -e "\033[1;33m $(source trans -b es:${id} "El puerto seleccionado ya se encuentra en uso")"
    unset porta1
	echo -e "$barra"
	return 0
    done
unset porta1ws
echo -e "$barra"
echo -e "\033[1;33m $(source trans -b pt:${id} "Instalando SSL/TLS : ")$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
echo -e "$barra"
fun_bar "apt install stunnel4 -y"
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[WS]\nconnect = 127.0.0.1:80\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
echo -e "$barra"
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
echo -e "\033[1;33m $(source trans -b pt:${id} "INSTALACION EXITOSA")"
echo -e "$barra"
}

insta_ser () {
#sudo apt install dropbear squid stunnel cmake make gcc build-essential nodejs
#nano /etc/default/dropbear
unset porta1
if [[ -z $porta1  ]]; then
	porta1="143"
fi
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo " $(source trans -b pt:${id} "Ingresa Puerto Dropbear/SSH a USAR ( Defauld 143 ) ") "
    read -p " Listen-Dropbear: " porta1
    [[ $(mportas|grep $porta1) ]] || break
    echo -e "\033[1;33m $(source trans -b es:${id} "El puerto seleccionado ya se encuentra en uso")"
    unset porta1
	echo -e "$barra"
	return 0
    done
unset porta1ws
if [[ -z $porta1ws  ]]; then
	porta1ws="80"
fi
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo " $(source trans -b pt:${id} "Ingrese Puerto WebSocket ( Default 80 ) ") "
    read -p " Listen-WS: " porta1ws
	if lsof -Pi :$porta1ws -sTCP:LISTEN -t >/dev/null ; then
	echo -e "\033[1;33m $(source trans -b es:${id} "El puerto seleccionado ya se encuentra en uso")" 
    unset porta1ws
	echo -e "$barra"
	return 0
	else
	break
	fi
    done
echo -e "$barra"
service dropbear stop 1> /dev/null 2> /dev/null
rm -rf /etc/default/dropbear
echo -e "Habilitando Entrada Dropbear" | pv -qL 30
fun_log
echo -e "NO_START=0" > /etc/default/dropbear && echo -e "\033[1;33mExito" || echo -e "\033[0;31mFail"
echo -e "Habilitando Puerto $porta1 Dropbear" | pv -qL 30
#
echo $porta1 > /etc/default/dadd
echo -e 'DROPBEAR_EXTRA_ARGS="-p '$porta1'"' >> /etc/default/dropbear && echo -e "\033[1;33mExito" || echo -e "\033[0;31mFail"
echo -e "\033[1;32mHabilitando BannerSSH DropBear" | pv -qL 30
#
echo -e 'DROPBEAR_BANNER="/etc/bannerssh"' >> /etc/default/dropbear && touch /etc/bannerssh || echo -e "\033[0;31mFail"
echo -e "DROPBEAR_RECEIVE_WINDOW=65536" >> /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service dropbear restart 1> /dev/null 2> /dev/null && echo -e "\033[1;32mReiniciando DropBear Exitosamente" | pv -qL 30 || echo -e "\033[1;32mError al Reiniciar DropBear" | pv -qL 30
service sshd restart 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
echo -e "\033[1;31m › DROPBEAR ESCUCHA \033[0m" $porta1 " ESCOJIDO " $porta1
echo -e "$barra"
echo -e "Creando Directorios" | pv -qL 30
#
[[ -d /bin/ejecutar ]] && rm -f /bin/ejecutar/proxy3.js || mkdir /bin/ejecutar
cd /bin/ejecutar
echo -e "Descargando Ficheros JS" | pv -qL 30
wget -q https://www.dropbox.com/s/84ls4k0gcaeonq8/proxy3.js
echo -e "\033[1;32mHabilitando NODE WS" | pv -qL 30
#
echo -e "Iniciando NODE WS" | pv -qL 30
#
screen -dmS ws node /bin/ejecutar/proxy3.js -dport $porta1 -mport $porta1ws
cd $HOME
echo -e "Mostrando Status NODE WS\n  ----------- Presiona CNTRL + X para Salir ------------"
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31m   USA este Payload "
		echo -e "   En el Menu de Seleccion.\033[0m"
		echo -e $barra
echo ' GET / HTTP/1.1[crlf]Host: yourhost.com[crlf]
 Connection: Upgrade[crlf]User-Agent: [ua][crlf]
 Upgrade: websocket[crlf][crlf] '
echo -e $barra
#read -p "Presiona Enter para Continuar"
#
#[[ -e /etc/systemd/system/nodews1.service ]] && systemctl status nodews1 || echo -e "Error al Iniciar NODE WS" | pv -qL 15
echo -e $barra
echo -e "\033[1;33m › INSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}

insta_https () {
unset porta1
sslports=`netstat -tunlp | grep stunnel4 | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/ssl.txt && echo | cat /tmp/ssl.txt | tr '\n' ' ' > /etc/adm-lite/sslports.txt && cat /etc/adm-lite/sslports.txt`;
PORT=$(cat /etc/adm-lite/sslports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo -e " Ingrese Puerto SSL/SSH/Dropbear Activo"
read -p " Para Redireccionamiento ( Default $PORT ): " porta1
if [[ -z $porta1  ]]; then
	porta1="$PORT"
	echo -e "\033[1;31m › SSL ESCUCHA \033[0m $PORT "
fi
echo -e "\033[1;31m › Puerta Seleccionada \033[0m $porta1 "
unset porta1ws
#read -p "Ingrese Puerto WebSocket SSL ( Default 2083 ): " porta1ws
if [[ -z $porta1ws  ]]; then
	porta1ws="2083"
fi
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo " $(source trans -b pt:${id} "Ingrese Puerto WebSocket ( Default 80 ) ") "
    read -p " Listen-WS: " porta1ws
    [[ $(mportas|grep $porta1ws) ]] || break
    echo -e "\033[1;33m $(source trans -b es:${id} "El puerto seleccionado ya se encuentra en uso")"
    unset porta1ws
	echo -e "$barra"
	return 0
    done
echo -e "$barra"
if lsof -Pi :$porta1ws -sTCP:LISTEN -t >/dev/null ; then
echo "Ya esta en uso ese puerto"
exit
else
echo -e "Creando Directorios" | pv -qL 15
#
[[ -d /bin/ejecutar ]] && echo "Fichero Existente" || mkdir /bin/ejecutar
cd /bin/ejecutar
echo -e "Descargando Ficheros JS" | pv -qL 15
wget -O httpsProxy.js -q https://www.dropbox.com/s/84ls4k0gcaeonq8/proxy3.js
echo -e "\033[1;32mHabilitando NODE WS" | pv -qL 15
#
echo -e "Iniciando NODE WS" | pv -qL 15
#
screen -dmS httpsws node /bin/ejecutar/httpsProxy.js -dport $porta1 -mport $porta1ws
cd $HOME
echo -e "Mostrando Status NODE WS\n  ----------- Presiona CNTRL + X para Salir ------------"
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31m   USA este Payload "
		echo -e "   En el Menu de Seleccion.\033[0m"
		echo -e $barra
echo ' GET / HTTP/1.1[crlf]Host: yourhost.com[crlf]
 Connection: Upgrade[crlf]User-Agent: [ua][crlf]
 Upgrade: websocket[crlf][crlf] '
echo -e $barra
#read -p "Presiona Enter para Continuar"
#
#[[ -e /etc/systemd/system/nodews1.service ]] && systemctl status nodews1 || echo -e "Error al Iniciar NODE WS" | pv -qL 15
echo -e $barra
echo -e "\033[1;33m › INSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
fi
}


stop_ser () {
killall node 
}


unset inst
clear
echo -e "\033[1;42mBIENVENIDO NUEVAMENTE!\033[0m"
echo -e $barra
		echo -e "        \033[4;31mNOTA importante\033[0m"
		echo -e "      \033[0;31mRecomendado UBUNTU 20.04"
		echo -e " Si Aun no lo has hecho, Dijita SI o s"
		echo -e "        Para Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
echo -e "Menu de instalacion de Paquetes Necesarios  "
echo -ne "\033[97m Deseas Instalar los Paquetes Requeridos [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
clear
source cabecalho
echo -e $barra
echo -e "          \033[1;42mBIENVENIDO NUEVAMENTE!\033[0m"
echo -e $barra
echo -e " SSH OVER WEBSOCKET CDN  "
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m INICIAR WEBSOCKET CDN  (HTTP)  DROPBEAR"
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m INICIAR WEBSOCKET CDN  (HTTPS) SSL/SSH"
echo -e "\033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;33m DETENER TODOS WEBSOCKET CDN"
echo -e $barra
echo -e "\033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m SALIR"
unset inst
echo -e $barra
echo -ne "\033[97m ESCOJE [ 1 / 2 ]: "
read inst
[[ $inst = "1" ]] && insta_ser
[[ $inst = "2" ]] && insta_https
[[ $inst = "3" ]] && stop_ser
[[ $inst = "0" ]] && menu
#[[ $inst = @("1"|"01") ]] && insta_ser
echo "Instalacion Concluida con Exito"