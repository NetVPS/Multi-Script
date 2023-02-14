#!/bin/bash
#
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

#!/bin/bash 
#25/01/2021 by @Kalix1 
clear 
clear 
SCPdir="/etc/adm-lite" 
SCPfrm="${SCPdir}" && [[ ! -d ${SCPfrm} ]] && exit 
SCPinst="${SCPdir}"&& [[ ! -d ${SCPinst} ]] && exit 
declare -A cor=( 
[0]="\033[1;37m" 
[1]="\033[1;34m" 
[2]="\033[1;31m" 
[3]="\033[1;33m" 
[4]="\033[1;32m" 
[5]="\e[1;36m" )  

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

fun_bar () { 
comando="$1"  _=$( $comando > /dev/null 2>&1 ) & > /dev/null 
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
ssl_stunel () { 
[[ $(mportas|grep stunnel4|head -1) ]] && { 
echo -e "\033[1;33m Deteniendo Stunnel"
msg -bar 
service stunnel4 stop > /dev/null 2>&1 
rm -rf /etc/stunnel/stunnel.conf 
apt-get purge stunnel4 -y &>/dev/null && echo -e "\e[31m DETENIENDO SERVICIO SSL" | pv -qL 10 
apt-get purge stunnel4 &>/dev/null 
apt-get remove stunnel4 &>/dev/null 
msg -bar 
echo -e "\033[1;33m Detenido Con Exito!"
msg -bar 
return 0 
} 
clear 
msg -bar 
echo -e "\033[1;33m Seleccione una puerta de redirección interna."
echo -e "\033[1;33m Un puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
	    echo " Ingresa el Puerto Local de tu VPS (Default 22) "
        read -p " Local-Port: " -e -i $pt portserv
        if [[ ! -z $portserv ]]; then
	 	 if lsof -Pi :$portserv -sTCP:LISTEN -t >/dev/null ; then
		 break
		 else
		 portserv="$pt"
		 break
		 fi
	 fi
         done
msg -bar 
DPORT="$(mportas|grep $portserv|awk '{print $2}'|head -1)" 
echo -e "\033[1;33m Ahora Que Puerto sera SSL"
msg -bar     
while true; do
    echo -e " Ingresa el Puerto SSl/TLS "
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "\033[1;33m  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	echo -e "$barra"
	return
    done
msg -bar 
echo -e "\033[1;33m Instalando SSL"
msg -bar 
fun_bar "apt-get install stunnel4 -y" 
apt-get install stunnel4 -y > /dev/null 2>&1 
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf 
####Coreccion2.0#####  
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1  
(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')" ; echo "" ; echo "$(wget -qO- ifconfig.me):81" ; echo "" ; echo "" ; echo "" ; echo "@ChumoGH")|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1  
cat stunnel.crt stunnel.key > stunnel.pem   
mv stunnel.pem /etc/stunnel/ 
######------- 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel4 restart > /dev/null 2>&1 
msg -bar 
echo -e "\033[1;33m INSTALADO CON EXITO"
msg -bar 
rm -rf /etc/adm-lite/stunnel.crt > /dev/null 2>&1 
rm -rf /etc/adm-lite/stunnel.key > /dev/null 2>&1 
rm -rf /root/stunnel.crt > /dev/null 2>&1 
rm -rf /root/stunnel.key > /dev/null 2>&1 
return 0 
} 

ssl_stunel_2 () { 
echo -e "\033[1;32m              AGREGAR MAS PUERTOS SSL"
msg -bar 
echo -e "\033[1;33m Seleccione una puerta de redirecciÃ³n interna."
echo -e "\033[1;33m Un puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
	    echo " Ingresa el Puerto Local de tu VPS (Default 22) "
        read -p " Local-Port: " -e -i $pt portserv
        if [[ ! -z $portserv ]]; then
	 	 if lsof -Pi :$portserv -sTCP:LISTEN -t >/dev/null ; then
		 break
		 else
		 portserv="$pt"
		 break
		 fi
	 fi
         done
msg -bar 
DPORT="$(mportas|grep $portserv|awk '{print $2}'|head -1)" 
echo -e "\033[1;33m Ahora Que Puerto sera SSL"
msg -bar     
while true; do
    echo -e " Ingresa el Puerto SSl/TLS "
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "\033[1;33m  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	echo -e "$barra"
	return
    done
msg -bar 
echo -e "\033[1;33m Instalando SSL"
msg -bar 
fun_bar "apt-get install stunnel4 -y" 
echo -e "client = no\n[SSL+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf 
######------- 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel4 restart > /dev/null 2>&1 
msg -bar 
echo -e "${cor[4]}            INSTALADO CON EXITO" 
msg -bar
rm -rf /etc/adm-lite/stunnel.crt > /dev/null 2>&1 
rm -rf /etc/adm-lite/stunnel.key > /dev/null 2>&1 
rm -rf /root/stunnel.crt > /dev/null 2>&1 
rm -rf /root/stunnel.key > /dev/null 2>&1 
return 0 
} 
sslpython(){ 
msg -bar 
echo -e "\033[1;37mSe Requiere tener el puerto 80 y el 443 libres" 
sleep 2 
install_python(){   
apt-get install python -y &>/dev/null && echo -e "\033[1;97m Activando Python Direc 80\n" | pv -qL 10    
sleep 3    
screen -dmS pydic-80 python ${SCPinst}/python.py 80 "@ChumoGH" && echo "80 @ChumoGH" >> /etc/adm-lite/PySSL.log
msg -bar
 }     

install_ssl(){    
apt-get install stunnel4 -y &>/dev/null && echo -e "\033[1;97m Activando Servicios SSL  443\n" | pv -qL 12    
apt-get install stunnel4 -y > /dev/null 2>&1   
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = 443\nconnect = 127.0.0.1:80" > /etc/stunnel/stunnel.conf   
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1   
(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')" ; echo "" ; echo "$(wget -qO- ifconfig.me):81" ; echo "" ; echo "" ; echo "" ; echo "@ChumoGH")|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1  
cat stunnel.crt stunnel.key > stunnel.pem     
mv stunnel.pem /etc/stunnel/   
######-------   
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4   
service stunnel4 restart > /dev/null 2>&1    
rm -rf /root/stunnel.crt > /dev/null 2>&1   
rm -rf /root/stunnel.key > /dev/null 2>&1   
}  

install_python  
install_ssl  
msg -bar 
echo -e "${cor[4]}               INSTALACION COMPLETA" 
msg -bar 

}  

unistall(){ 
clear 
msg -bar 
msg -ama "DETENIENDO SERVICIOS SSL Y PYTHON" 
msg -bar 
service stunnel4 stop > /dev/null 2>&1 
apt-get purge stunnel4 -y &>/dev/null 
apt-get purge stunnel -y &>/dev/null 
kill -9 $(ps aux |grep -v grep |grep -w "python.py"|grep dmS|awk '{print $2}') &>/dev/null 
rm /etc/adm-lite/PySSL.log &>/dev/null 
clear 
msg -bar 
msg -verd "LOS SERVICIOS SE HAN DETENIDO" 
msg -bar 
}  
# 
certif(){ 
msg -bar 
msg -tit 
echo -e "\e[1;37m ACONTINUACION ES TENER LISTO EL LINK DEL CERTIFICADO.zip\n VERIFICADO EN ZEROSSL, DESCARGALO Y SUBELO\n EN TU GITHUB O DROPBOX" 
echo -ne " Desea Continuar? [S/N]: "; read seg 
[[ $seg = @(n|N) ]] && msg -bar && return 
clear 
####Cerrificado ssl/tls##### 
msg -bar 
echo -e "\e[1;33mðŸ‘‡ LINK DEL CERTIFICADO.zip ðŸ‘‡           \n     \e[0m" 
echo -e "\e[1;36m LINK \e[37m: \e[34m\c " 
#extraer certificado.zip 
read linkd 
wget -O /etc/stunnel/certificado.zip $linkd &>/dev/null 
cd /etc/stunnel/ 
unzip certificado.zip &>/dev/null 
cat private.key certificate.crt ca_bundle.crt > stunnel.pem 
rm -rf certificado.zip 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel restart > /dev/null 2>&1 
service stunnel4 restart &>/dev/null 
msg -bar 
echo -e "${cor[4]} CERTIFICADO INSTALADO CON EXITO \e[0m"  
msg -bar 
}

certificadom(){ 
if [ -f /etc/stunnel/stunnel.conf ]; then 
insapa2(){ 
for pid in $(pgrep python);do 
kill $pid 
done
for pid in $(pgrep apache2);do
kill $pid 
done 
service dropbear stop 
echo -ne " \033[1;31m[ ! ] CONFIGURANDO APACHE" # Generate CA Config
apt install apache2 -y
echo "Listen 80  <IfModule ssl_module>
         Listen 443 </IfModule>  
		 <IfModule mod_gnutls.c>         
		 Listen 443 </IfModule> 
		 " > /etc/apache2/ports.conf 
		 service apache2 restart 
#) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
		 } 
clear 
msg -bar 
insapa2 &>/dev/null && echo -e " \e[1;33mAGREGANDO RECURSOS " | pv -qL 10 
msg -bar 
echo -e "\e[1;37m Verificar dominio \e[0m" 
msg -bar 
read -p " LLAVE: " keyy 
msg -bar 
read -p " DATOS: " dat2w 
mkdir -p /var/www/html/.well-known/pki-validation/ 
datfr1=$(echo "$dat2w"|awk '{print $1}') 
datfr2=$(echo "$dat2w"|awk '{print $2}') 
datfr3=$(echo "$dat2w"|awk '{print $3}') 
echo -ne "${datfr1}\n${datfr2}\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt 
msg -bar 
echo -e "\e[1;37m VERIFIQUE EN LA PÃGINA ZEROSSL \e[0m" 
msg -bar 
read -p " ENTER PARA CONTINUAR" 
clear
msg -bar 
echo -e "\e[1;33mðŸ‘‡ LINK DEL CERTIFICADO ðŸ‘‡       \n     \e[0m" 
echo -e "\e[1;36m LINK \e[37m: \e[34m\c" 
read link 

incertis(){ 

wget $link -O /etc/stunnel/certificado.zip 
cd /etc/stunnel/ 
unzip certificado.zip  
cat private.key certificate.crt ca_bundle.crt > stunnel.pem 
service stunnel restart &>/dev/null 
service stunnel4 restart &>/dev/null 
} 

incertis &>/dev/null && echo -e " \e[1;33mEXTRAYENDO CERTIFICADO " | pv -qL 10 
msg -bar 
echo -e "${cor[4]} CERTIFICADO INSTALADO \e[0m"  
msg -bar  
for pid in $(pgrep apache2);do 
kill $pid 
done 
echo -ne " \033[1;31m[ ! ] RECONFIGURANDO APACHE" # Generate CA Config
apt install apache2 -y &>/dev/null 
echo "Listen 81  <IfModule ssl_module>
         Listen 443 </IfModule>  
		 <IfModule mod_gnutls.c>         
		 Listen 443 </IfModule> 
" > /etc/apache2/ports.conf 
service apache2 restart &>/dev/null 
#) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
service dropbear start &>/dev/null 
service dropbear restart &>/dev/null 
for port in $(cat /etc/adm-lite/PortPD.log| grep -v "nobody" |cut -d' ' -f1); do 
PIDVRF3="$(ps aux|grep pydic-"$port" |grep -v grep|awk '{print $2}')" 
if [[ -z $PIDVRF3 ]]; then 
screen -dmS pydic-"$port" python /etc/adm-lite/PDirect.py "$port" 
else 
for pid in $(echo $PIDVRF3); do
echo "" 
done
fi 
done 
else 
msg -bar 
echo -e "${cor[3]} SSL/TLS NO INSTALADO \e[0m" 
msg -bar
 fi
 }   
 clear 
if netstat -tnlp |grep 'stunnel4' &>/dev/null; then 
stunel="\e[32m[ ON ]" 
else 
stunel="\e[31m[ OFF ]" 
fi 
[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[7;49;35m    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      \033[0m"
msg -bar 
msg -bar3 
msg -tit 
echo -e "${cor[3]}         INSTALADOR MULTI SSL  By @ChumoGH" 
msg -bar 
echo -e "${cor[1]}            Escoja la opcion deseada." 
msg -bar
echo -e " \033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ➮ $(msg -azu "INICIAR || DETENER SSL") $stunel"
echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮ $(msg -azu "AGREGAR + PUERTOS SSL")"
echo -e " \033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m ➮ $(msg -azu "SSL+WEBSOCKET DIRECTO")" 
echo -e " \033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m ➮ $(msg -azu "\e[1;31mDETENER SERVICIO SSL+WEBSOCKET")"
msg -bar 
echo -e " \033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m ➮ $(msg -azu "CERTIFICADO SSL/TLS")" 
msg -bar
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar 
echo -e "\033[1;37mSelecione Una Opcion [0/5]: " 
msg -bar  
selection=$(selection_fun 5)
case ${selection} in
1) msg -bar 
ssl_stunel ;; 
2) msg -bar 
ssl_stunel_2 
sleep 3 
exit ;; 
3) sslpython 
exit ;; 
4) unistall ;; 
5) clear 
msg -bar 
msg -ama "?CERTIFICADO SSL/TLS" 
msg -bar 
echo -e "${cor[4]} 1).-\033[1;37m CERTIFICADO ZIP DIRECTO" 
echo -e "${cor[4]} 2).-\033[1;37m CERTIFICADO MANUAL ZEROSSL   " 
msg -bar 
echo -ne "\033[1;37mSelecione Una Opcion [0/2]: " 
msg -bar  
	selection=$(selection_fun 2)
	case ${selection} in
	0) return 0
	;;
	1) certif 
	exit 
	;; 
	2) certificadom 
	exit 
	;; 
	esac 
;;
esac 