#!/bin/bash
ll="/usr/local/include/snaps" && [[ ! -d ${ll} ]] && exit
clear
clear

SCPdir="/etc/VPS-MX"
tmp="/etc/VPS-MX/crt" && [[ ! -d ${tmp} ]] && mkdir ${tmp}
tmp_crt="/etc/VPS-MX/crt/certificados" && [[ ! -d ${tmp_crt} ]] && mkdir ${tmp_crt}
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${SCPdir}/protocolos"&& [[ ! -d ${SCPinst} ]] && exit
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" [5]="\e[1;36m" )

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
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ifconfig.me)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
#======cloudflare========
export correo='lacasitamx93@gmail.com'
export _dns='2973fe5da34aa6c4a8ead51cd124973f' #id de zona
export apikey='1829594c1de4cb59a0f795d780cb61332b64a' #api key
export _domain='lacasitamx.host'
export url='https://api.cloudflare.com/client/v4/zones'
# 
#========================
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<20; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.5
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
fun_ip &>/dev/null
crear_subdominio(){
clear
clear
apt install jq -y &>/dev/null
msg -tit
	echo -e "       \e[91m\e[43mGENERADOR DE SUB-DOMINIOS\e[0m"
	msg -verd " Verificando direccion ip..."
	sleep 2

	ls_dom=$(curl -s -X GET "$url/$_dns/dns_records?per_page=100" \
     -H "X-Auth-Email: $correo" \
     -H "X-Auth-Key: $apikey" \
     -H "Content-Type: application/json" | jq '.')

    num_line=$(echo $ls_dom | jq '.result | length')
    ls_domi=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')
    my_ip=$(wget -qO- ipv4.icanhazip.com)

	if [[ $(echo "$ls_ip"|grep -w "$my_ip") = "$my_ip" ]];then
		for (( i = 0; i < $num_line; i++ )); do
			if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$my_ip") = "$my_ip" ]]; then
				domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
				echo "$domain" > /etc/VPS-MX/tmp/dominio.txt
				break
			fi
		done
		tput cuu1 && tput dl1
		msg -verm2 " ya existe un sub-dominio asociado a esta IP"
		msg -bar
		echo -e " $(msg -ama "sub-dominio:") $(msg -verd "$domain")"
		msg -bar
		exit
    fi

    if [[ -z $name ]]; then
    	tput cuu1 && tput dl1
		echo -e " $(msg -azu "El dominio principal es:") $(msg -verd "$_domain")\n $(msg -azu "El sub-dominio sera:") $(msg -verd "mivps.$_domain")"
		msg -bar
    	while [[ -z "$name" ]]; do
    		msg -ne " Nombre (ejemplo: mivps)  "
    		read name
    		tput cuu1 && tput dl1

    		name=$(echo "$name" | tr -d '[[:space:]]')

    		if [[ -z $name ]]; then
    			msg -verm2 " ingresar un nombre...!"
    			unset name
    			sleep 2
    			tput cuu1 && tput dl1
    			continue
    		elif [[ ! $name =~ $tx_num ]]; then
    			msg -verm2 " ingresa solo letras y numeros...!"
    			unset name
    			sleep 2
    			tput cuu1 && tput dl1
    			continue
    		elif [[ "${#name}" -lt "3" ]]; then
    			msg -verm2 " nombre demaciado corto!"
    			sleep 2
    			tput cuu1 && tput dl1
    			unset name
    			continue
    		else
    			domain="$name.$_domain"
    			msg -ama " Verificando disponibiliad..."
    			sleep 2
    			tput cuu1 && tput dl1
    			if [[ $(echo "$ls_domi" | grep "$domain") = "" ]]; then
    				echo -e " $(msg -verd "[ok]") $(msg -azu "sub-dominio disponible")"
    				sleep 2
    			else
    				echo -e " $(msg -verm2 "[fail]") $(msg -azu "sub-dominio NO disponible")"
    				unset name
    				sleep 2
    				tput cuu1 && tput dl1
    				continue
    			fi
    		fi
    	done
    fi
    tput cuu1 && tput dl1
    echo -e " $(msg -azu " El sub-dominio sera:") $(msg -verd "$domain")"
    msg -bar
    msg -ne " Continuar...[S/N]: "
    read opcion
    [[ $opcion = @(n|N) ]] && return 1
    tput cuu1 && tput dl1
    msg -azu " Creando sub-dominio"
    sleep 1

    var=$(cat <<EOF
{
  "type": "A",
  "name": "$name",
  "content": "$my_ip",
  "ttl": 1,
  "priority": 10,
  "proxied": false
}
EOF
)
    chek_domain=$(curl -s -X POST "$url/$_dns/dns_records" \
    -H "X-Auth-Email: $correo" \
    -H "X-Auth-Key: $apikey" \
    -H "Content-Type: application/json" \
    -d $(echo $var|jq -c '.')|jq '.')

    tput cuu1 && tput dl1
    if [[ "$(echo $chek_domain|jq -r '.success')" = "true" ]]; then
    	echo "$(echo $chek_domain|jq -r '.result.name')" > /etc/VPS-MX/tmp/dominio.txt
    	msg -verd " Sub-dominio creado con exito!"
    		userid="${SCPdir}/ID"
    if [[ $(cat ${userid}|grep "605531451") = "" ]]; then
			
			activ=$(cat ${userid})
 		 TOKEN="1235413737:AAEWLffj1FO4GQ5Iwoo4XvIm4ESlFjHA0_A"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG="🔰SUB-DOMINIO CREADO 🔰
╔═════ ▓▓ ࿇ ▓▓ ═════╗
 ══════◄••❀••►══════
 User ID: $(cat ${userid})
 ══════◄••❀••►══════
 IP: $(cat ${SCPdir}/MEUIPvps)
 ══════◄••❀••►══════
 SUB-DOMINIO: $(cat /etc/VPS-MX/tmp/dominio.txt)
 ══════◄••❀••►══════
╚═════ ▓▓ ࿇ ▓▓ ═════╝
"
curl -s --max-time 10 -d "chat_id=$activ&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
curl -s --max-time 10 -d "chat_id=605531451&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
else
TOKEN="1235413737:AAEWLffj1FO4GQ5Iwoo4XvIm4ESlFjHA0_A"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG="🔰SUB-DOMINIO CREADO 🔰
╔═════ ▓▓ ࿇ ▓▓ ═════╗
 ══════◄••❀••►══════
 User ID: $(cat ${userid})
 ══════◄••❀••►══════
 IP: $(cat ${SCPdir}/MEUIPvps)
 ══════◄••❀••►══════
 SUB-DOMINIO: $(cat /etc/VPS-MX/tmp/dominio.txt)
 ══════◄••❀••►══════
╚═════ ▓▓ ࿇ ▓▓ ═════╝
"
curl -s --max-time 10 -d "chat_id=605531451&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
fi
  #  read -p " enter para continuar"
    else
    	echo "" > /etc/VPS-MX/tmp/dominio.txt
    	msg -ama " Falla al crear Sub-dominio!" 	
    fi
 
}
ssl_stunel () {
[[ $(mportas|grep stunnel4|head -1) ]] && {
echo -e "\033[1;33m $(fun_trans  "Deteniendo Stunnel")"
msg -bar
service stunnel4 stop > /dev/null 2>&1
service stunnel stop &>/dev/null
apt-get purge stunnel4 -y &>/dev/null && echo -e "\e[31m DETENIENDO SERVICIO SSL" | pv -qL10
apt-get purge stunnel -y &>/dev/null

if [[ ! -z $(crontab -l|grep -w "onssl.sh") ]]; then
#si existe
crontab -l > /root/cron; sed -i '/onssl.sh/ d' /root/cron; crontab /root/cron; rm /tmp/st/onssl.sh
rm -rf /tmp/st
fi #saltando

msg -bar
echo -e "\033[1;33m $(fun_trans  "Detenido Con Exito!")"
msg -bar
return 0
}
clear
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Un puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Puerto Local: " redir
		 echo ""
         if [[ ! -z $redir ]]; then
             if [[ $(echo $redir|grep [0-9]) ]]; then
                [[ $(mportas|grep $redir|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerto Invalido")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $redir|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Que Puerto sera SSL")"
msg -bar
    while true; do
	echo -ne "\033[1;37m"
    read -p " Puerto SSL: " SSLPORT
	echo ""
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
inst(){
apt-get install stunnel -y
apt-get install stunnel4 -y
}
inst &>/dev/null && echo -e "\e[1;92m INICIANDO SSL" | pv -qL10
#echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\ndelay = yes\nciphers = ALL\nsslVersion = ALL\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
####
certactivo(){
msg -bar
echo -ne " Ya Creastes El certificado en ( let's Encrypt? o en Zero SSL? )\n Si Aun No Lo Instala Por Favor Precione N [S/N]: "; read seg
		[[ $seg = @(n|N) ]] && msg -bar && crearcert
db="$(ls ${tmp_crt})"
  #  opcion="n"
    if [[ ! "$(echo "$db"|grep ".crt")" = "" ]]; then
        cert=$(echo "$db"|grep ".crt")
        key=$(echo "$db"|grep ".key")
        msg -bar
        msg -azu "CERTIFICADO SSL ENCONTRADO"
        msg -bar
        echo -e "$(msg -azu "CERT:") $(msg -ama "$cert")"
        echo -e "$(msg -azu "KEY:")  $(msg -ama "$key")"
        msg -bar
            cp ${tmp_crt}/$cert ${tmp}/stunnel.crt
            cp ${tmp_crt}/$key ${tmp}/stunnel.key
            cat ${tmp}/stunnel.key ${tmp}/stunnel.crt > /etc/stunnel/stunnel.pem
            
	sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
	
	msg -bar
	echo -e "\033[1;33m $(fun_trans  "CERTIFICADO INSTALADO CON EXITO")"
	msg -bar

	rm -rf ${tmp_crt}/stunnel.crt > /dev/null 2>&1
    rm -rf ${tmp_crt}/stunnel.key > /dev/null 2>&1
        fi
    return 0
}
crearcert(){
        openssl genrsa -out ${tmp}/stunnel.key 2048 > /dev/null 2>&1
        (echo "mx" ; echo "mx" ; echo "Speed" ; echo "@conectedmx_bot" ; echo "@conectedmx" ; echo "@lacasitamx" ; echo "@conectedmx_vip" )|openssl req -new -key ${tmp}/stunnel.key -x509 -days 1000 -out ${tmp}/stunnel.crt > /dev/null 2>&1
        
    cat ${tmp}/stunnel.key ${tmp}/stunnel.crt > /etc/stunnel/stunnel.pem
######-------
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null

msg -bar
echo -e "\033[1;33m $(fun_trans  "SSL INSTALADO CON EXITO")"
msg -bar

rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
clear
msg -tit
echo -e "$(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "CERIFICADO SSL STUNNEL4 ")"
echo -e "$(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "Certificado Existen de Zero ssl | Let's Encrypt")"
msg -bar
echo -ne "\033[1;37mSelecione Una Opcion: "
read opcao
case $opcao in
1)crearcert ;;
2)certactivo ;;
esac
}
SPR &
ssl_stunel_2 () {
echo -e "\033[1;32m $(fun_trans  "             AGREGAR MAS PUERTOS SSL")"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Un puerto SSH/DROPBEAR/SQUID/OPENVPN/SSL")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Puerto-Local: " portx
		 echo ""
         if [[ ! -z $portx ]]; then
             if [[ $(echo $portx|grep [0-9]) ]]; then
                [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerto Invalido")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Que Puerto sera SSL")"
msg -bar
    while true; do
	echo -ne "\033[1;37m"
    read -p " Listen-SSL: " SSLPORT
	echo ""
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
apt-get install stunnel4 -y &>/dev/null && echo -e "\e[1;92m INICIANDO SSL" | pv -qL10
echo -e "client = no\n[stunnel+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf
######
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
msg -bar
echo -e "${cor[4]}            INSTALADO CON EXITO"
msg -bar

rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
sslpython(){
msg -bar
echo -e "\033[1;37mSe Requiere tener el puerto 80 y el 443 libres"
echo -ne " Desea Continuar? [S/N]: "; read seg
[[ $seg = @(n|N) ]] && msg -bar && return
clear
install_python(){ 
 apt-get install python -y &>/dev/null && echo -e "\033[1;97m Activando Python Directo ►80\n" | pv -qL 10
 
 sleep 2
 	echo -e "[Unit]\nDescription=python.py Service by @lacasitamx\nAfter=network.target\nStartLimitIntervalSec=0\n\n[Service]\nType=simple\nUser=root\nWorkingDirectory=/root\nExecStart=/usr/bin/python ${SCPinst}/python.py 80 @lacasitamx\nRestart=always\nRestartSec=3s\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/python.PD.service
    systemctl enable python.PD &>/dev/null
    systemctl start python.PD &>/dev/null
    echo "80 @LACASITAMX" >/etc/VPS-MX/PortPD.log
	echo "80 @LACASITAMX" > /etc/VPS-MX/PySSL.log
 msg -bar
 } 
 
 install_ssl(){  
 apt-get install stunnel4 -y &>/dev/null && echo -e "\033[1;97m Activando Servicios SSL ►443\n" | pv -qL 12
 
 apt-get install stunnel4 -y > /dev/null 2>&1 
 #echo -e "client = no\ncert = /etc/stunnel/stunnel.pem\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n[http]\naccept = 443\nconnect = $IP:80" >/etc/stunnel/stunnel.conf
 echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\ndelay = yes\nciphers = ALL\nsslVersion = ALL\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[http]\nconnect = 127.0.0.1:80\naccept = 443" > /etc/stunnel/stunnel.conf
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1 
 (echo mx; echo @lacasitamx; echo Full; echo speed; echo internet; echo @conectedmx; echo @conectedmx_bot)|openssl req -new -key stunnel.key -x509 -days 1095 -out stunnel.crt > /dev/null 2>&1
 cat stunnel.crt stunnel.key > stunnel.pem   
 mv stunnel.pem /etc/stunnel/ 
 ######------- 
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
 rm -rf /root/stunnel.crt > /dev/null 2>&1 
 rm -rf /root/stunnel.key > /dev/null 2>&1 
 } 
install_python 
install_ssl 
msg -bar
echo -e "${cor[4]}               INSTALACION COMPLETA"
msg -bar
}
l="/usr/local/lib/sped" && [[ ! -d ${l} ]] && exit
unistall(){
clear
msg -bar
msg -ama "DETENIENDO SERVICIOS SSL Y PYTHON"
msg -bar
			service stunnel4 stop > /dev/null 2>&1
			apt-get purge stunnel4 -y &>/dev/null
			apt-get purge stunnel -y &>/dev/null
			kill -9 $(ps aux |grep -v grep |grep -w "python.py"|grep dmS|awk '{print $2}') &>/dev/null
			systemctl stop python.PD &>/dev/null
            systemctl disable python.PD &>/dev/null
            rm /etc/systemd/system/python.PD.service &>/dev/null
            rm /etc/VPS-MX/PortPD.log &>/dev/null
           
			rm /etc/VPS-MX/PySSL.log &>/dev/null
			#rm -rf /etc/stunnel/certificado.zip private.key certificate.crt ca_bundle.crt &>/dev/null
clear
msg -bar
msg -verd "LOS SERVICIOS SE HAN DETENIDO"
msg -bar
}

#
certif(){
if [ -f /etc/stunnel/stunnel.conf ]; then
msg -bar
msg -tit
echo -e "\e[1;37m ACONTINUACION ES TENER LISTO EL LINK DEL CERTIFICADO.zip\n VERIFICADO EN ZEROSSL, DESCARGALO Y SUBELO\n EN TU GITHUB O DROPBOX"
echo -ne " Desea Continuar? [S/N]: "; read seg
[[ $seg = @(n|N) ]] && msg -bar && return
clear
####Cerrificado ssl/tls#####
msg -bar
echo -e "\e[1;33m👇 LINK DEL CERTIFICADO.zip 👇           \n     \e[0m"
echo -ne "\e[1;36m LINK\e[37m: \e[34m"
#extraer certificado.zip
read linkd
wget $linkd -O /etc/stunnel/certificado.zip
cd /etc/stunnel/
unzip certificado.zip 
cat private.key certificate.crt ca_bundle.crt > stunnel.pem
#
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
msg -bar
echo -e "${cor[4]} CERTIFICADO INSTALADO CON EXITO \e[0m" 
msg -bar
else
msg -bar
echo -e "${cor[3]} SERVICIO SSL NO ESTÁ INSTALADO \e[0m"
msg -bar
fi
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
apt install apache2 -y
echo "Listen 80

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule> " > /etc/apache2/ports.conf
service apache2 restart
}
clear
msg -bar
insapa2 &>/dev/null && echo -e " \e[1;33mAGREGANDO RECURSOS " | pv -qL 10
msg -bar
echo -e "\e[1;37m Verificar dominio \e[0m\n\n"
echo -e "\e[1;37m TIENES QUE MODIFICAR EL ARCHIVO DESCARGADO\n EJEMPLO: 530DDCDC3 comodoca.com 7bac5e210\e[0m"
msg -bar
read -p " LLAVE > Nombre Del Archivo: " keyy
msg -bar
read -p " DATOS > De La LLAVE: " dat2w
[[ ! -d /var/www/html/.well-known ]] && mkdir /var/www/html/.well-known
[[ ! -d /var/www/html/.well-known/pki-validation ]] && mkdir /var/www/html/.well-known/pki-validation
datfr1=$(echo "$dat2w"|awk '{print $1}')
datfr2=$(echo "$dat2w"|awk '{print $2}')
datfr3=$(echo "$dat2w"|awk '{print $3}')
echo -ne "${datfr1}\n${datfr2}\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt
msg -bar
echo -e "\e[1;37m VERIFIQUE EN LA PÁGINA ZEROSSL \e[0m"
msg -bar
read -p " ENTER PARA CONTINUAR"
clear
msg -bar
echo -e "\e[1;33m👇 LINK DEL CERTIFICADO 👇       \n     \e[0m"
echo -e "\e[1;36m LINK\e[37m: \e[34m"
read link
incertis(){
wget $link -O /etc/stunnel/certificado.zip
cd /etc/stunnel/
unzip certificado.zip 
cat private.key certificate.crt ca_bundle.crt > stunnel.pem
#
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
	echo "ENABLED=1" >> /etc/default/stunnel4
	systemctl start stunnel4 &>/dev/null
	systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
}
incertis &>/dev/null && echo -e " \e[1;33mEXTRAYENDO CERTIFICADO " | pv -qL 10
msg -bar
echo -e "${cor[4]} CERTIFICADO INSTALADO \e[0m" 
msg -bar

for pid in $(pgrep apache2);do
kill $pid
done
apt install apache2 -y &>/dev/null
echo "Listen 81

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule> " > /etc/apache2/ports.conf
service apache2 restart &>/dev/null
service dropbear start &>/dev/null
service dropbear restart &>/dev/null
for port in $(cat /etc/VPS-MX/PortPD.log| grep -v "nobody" |cut -d' ' -f1)
do
PIDVRF3="$(ps aux|grep pid-"$port" |grep -v grep|awk '{print $2}')"
Portd="$(cat /etc/VPS-MX/PortPD.log|grep -v "nobody" |cut -d' ' -f1)"
if [[ -z ${Portd} ]]; then
    systemctl start python.PD &>/dev/null
#screen -dmS pydic-"$port" python /etc/VPS-MX/protocolos/python.py "$port"
else
    systemctl start python.PD &>/dev/null
fi
done
else
msg -bar
echo -e "${cor[3]} SSL/TLS NO INSTALADO \e[0m"
msg -bar
fi
}
#
stop_port(){
	msg -bar
	msg -ama " Comprovando puertos..."
	ports=('80' '443')

	for i in ${ports[@]}; do
		if [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]]; then
			msg -bar
			echo -ne "$(msg -ama " Liberando puerto: $i")"
			lsof -i:$i | awk '{print $2}' | grep -v "PID" | xargs kill -9
			sleep 1s
			if [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]];then
				tput cuu1 && tput dl1
				msg -verm2 "ERROR AL LIBERAR PURTO $i"
				msg -bar
				msg -ama " Puerto $i en uso."
				msg -ama " auto-liberacion fallida"
				msg -ama " detenga el puerto $i manualmente"
				msg -ama " e intentar nuevamente..."
				msg -bar
				
				return 1			
			fi
		fi
	done
 }
 
acme_install(){

    if [[ ! -e $HOME/.acme.sh/acme.sh ]];then
    	msg -bar3
    	msg -ama " INSTALANDO SCRIPT ACME"
    	curl -s "https://get.acme.sh" | sh &>/dev/null
    fi
    if [[ ! -z "${mail}" ]]; then
    msg -bar
    	msg -ama " LOGEANDO EN Zerossl"
    	sleep 1
    	$HOME/.acme.sh/acme.sh --register-account  -m ${mail} --server zerossl
    	$HOME/.acme.sh/acme.sh --set-default-ca --server zerossl
    	
    else
    msg -bar
    msg -ama " APLICANDO SERVIDOR letsencrypt"
    msg -bar
    	sleep 1
    	$HOME/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    	
    fi
    msg -bar
    msg -ama " GENERANDO CERTIFICADO SSL"
    msg -bar
    sleep 1
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
    	"$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath ${tmp_crt}/${domain}.crt --keypath ${tmp_crt}/${domain}.key --ecc --force &>/dev/null
    
    	rm -rf $HOME/.acme.sh/${domain}_ecc
    	msg -bar
    	msg -verd " Certificado SSL se genero con éxito"
    	msg -bar
    	
    else
    	rm -rf "$HOME/.acme.sh/${domain}_ecc"
    	msg -bar
    	msg -verm2 "Error al generar el certificado SSL"
    	msg -bar
    	msg -ama " verifique los posibles error"
    	msg -ama " o intente de nuevo"
    	
    	
    fi
 }
 
 gerar_cert(){
	clear
	case $1 in
		1)
	msg -bar
	msg -ama "Generador De Certificado Let's Encrypt"
	msg -bar;;
		2)
	msg -bar
	msg -ama "Generador De Certificado Zerossl"
	msg -bar;;
	esac
	msg -ama "Requiere ingresar un dominio."
	msg -ama "el mismo solo deve resolver DNS, y apuntar"
	msg -ama "a la direccion ip de este servidor."
	msg -bar
	msg -ama "Temporalmente requiere tener"
	msg -ama "los puertos 80 y 443 libres."
	if [[ $1 = 2 ]]; then
		msg -bar
		msg -ama "Requiere tener una cuenta Zerossl."
	fi
	msg -bar
 	msg -ne " Continuar [S/N]: "
	read opcion
	[[ $opcion != @(s|S|y|Y) ]] && return 1

	if [[ $1 = 2 ]]; then
     while [[ -z $mail ]]; do
     	clear
		msg -bar
		msg -ama "ingresa tu correo usado en Zerossl"
		msg -bar3
		msg -ne " >>> "
		read mail
	 done
	fi

	if [[ -e ${tmp_crt}/dominio.txt ]]; then
		domain=$(cat ${tmp_crt}/dominio.txt)
		[[ $domain = "multi-domain" ]] && unset domain
		if [[ ! -z $domain ]]; then
			clear
			msg -bar
			msg -azu "Dominio asociado a esta ip"
			msg -bar
			echo -e "$(msg -verm2 " >>> ") $(msg -ama "$domain")"
			msg -ne "Continuar, usando este dominio? [S/N]: "
			read opcion
			tput cuu1 && tput dl1
			[[ $opcion != @(S|s|Y|y) ]] && unset domain
		fi
	fi

	while [[ -z $domain ]]; do
		clear
		msg -bar
		msg -ama "ingresa tu dominio"
		msg -bar
		msg -ne " >>> "
		read domain
	done
	msg -bar
	msg -ama " Comprovando direccion IP ..."
	local_ip=$(wget -qO- ipv4.icanhazip.com)
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
    sleep 1
    [[ -z "${domain_ip}" ]] && domain_ip="ip no encontrada"
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -ne $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
    	clear
    	msg -bar
    	msg -verm2 "ERROR DE DIRECCION IP"
    	msg -bar
    	msg -ama " La direccion ip de su dominio\n no coincide con la de su servidor."
    	msg -bar
    	echo -e " $(msg -azu "IP dominio:  ")$(msg -verm2 "${domain_ip}")"
    	echo -e " $(msg -azu "IP servidor: ")$(msg -verm2 "${local_ip}")"
    	msg -bar
    	msg -ama " Verifique su dominio, e intente de nuevo."
    	msg -bar
    	
    	
    fi

    
    stop_port
    acme_install
    echo "$domain" > ${tmp_crt}/dominio.txt
    
}
if [[ ! -z $(crontab -l|grep -w "onssl.sh") ]]; then
ons="\e[1;92m[ON]"
else
ons="\e[1;91m[OFF]"
fi
clear
[[ $(ps x | grep stunnel4 | grep -v grep | awk '{print $1}') ]] && stunel4="\e[1;32m[ ON ]" || stunel4="\e[1;31m[ OFF ]"

#msg -bar
msg -bar3
msg -tit
msg -bar
echo -e "       \e[91m\e[43mINSTALADOR MULTI SSL\e[0m "
msg -bar
echo -e "$(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "INICIAR |DETENER SSL") $stunel4"
echo -e "$(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "AGREGAR + PUERTOS SSL")"
msg -bar
echo -e "$(msg -verd "[3]")$(msg -verm2 "➛ ")$(msg -azu "SSL+Websocket Auto-Config 80➮443    ")"
echo -e "$(msg -verd "[4]")$(msg -verm2 "➛ ")$(msg -azu "\e[1;31mDETENER SERVICIO SSL+Websocket  ")"
msg -bar
echo -e "$(msg -verd "[5]")$(msg -verm2 "➛ ")$(msg -azu "CREAR SUBDOMINIO") \e[1;92m( Nuevo )"
msg -bar
echo -e "$(msg -verd "[6]")$(msg -verm2 "➛ ")$(msg -azu "CERTIFICADO SSL/TLS")"
echo -e "$(msg -verd "[7]")$(msg -verm2 "➛ ")$(msg -azu "ENCENDER SSL")"
echo -e "$(msg -verd "[8]")$(msg -verm2 "➛ ")$(msg -azu "AUTO-MANTENIMIENTO SSL") $ons"
[[ -e /etc/stunnel/private.key ]] && echo -e "$(msg -verd "[9]")$(msg -verm2 "➛ ")$(msg -azu "Usar Certificado Zerossl")"
msg -bar
echo -ne "\033[1;37mSelecione Una Opcion: "
read opcao
case $opcao in
1)
msg -bar
ssl_stunel

;;
2)
msg -bar
ssl_stunel_2
sleep 3
exit
;;
3)
sslpython
exit
;;
4) unistall ;;
5)
crear_subdominio
exit
;;
6)
clear
msg -bar
echo -e "	\e[91m\e[43mCERTIFICADO SSL/TLS\e[0m"
msg -bar
echo -e "$(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "CERTIFICADO ZIP DIRECTO")"
echo -e "$(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "CERTIFICADO MANUAL ZEROSSL")"
echo -e "$(msg -verd "[3]")$(msg -verm2 "➛ ")$(msg -azu "GENERAR CERTIFICADO SSL (Let's Encrypt)")"
echo -e "$(msg -verd "[4]")$(msg -verm2 "➛ ")$(msg -azu "GENERAR CERTIFICADO SSL (Zerossl Directo)")"
msg -bar
echo -ne "\033[1;37mSelecione Una Opcion : "
read opc
case $opc in
1)
certif
exit
;;
2)
certificadom
exit
;;
3)
gerar_cert 1
exit 
;;
4)
gerar_cert 2
exit
;;
esac
;;
7)
clear
msg -bar
msg -ama "	START STUNNEL\n	ESTA OPCION ES SOLO SI LLEGA A DETENER EL PUERTO"
msg -ama
echo -ne " Desea Continuar? [S/N]: "; read seg
[[ $seg = @(n|N) ]] && msg -bar && return
clear
	#systemctl start stunnel4 &>/dev/null
	#systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
msg -bar
msg -verd "	SERVICIOS STUNNEL REINICIADOS"
msg -bar
;;
8)
clear
msg -tit
if [[ ! -z $(crontab -l|grep -w "onssl.sh") ]]; then
    msg -azu " Auto-Inicio SSL programada cada $(msg -verd "[ $(crontab -l|grep -w "onssl.sh"|awk '{print $2}'|sed $'s/[^[:alnum:]\t]//g')HS ]")"
    msg -bar
    while :
    do
    echo -ne "$(msg -azu " Detener Auto-Inicio SSL [S/N]: ")" && read yesno
    tput cuu1 && tput dl1
    case $yesno in
      s|S) crontab -l > /root/cron && sed -i '/onssl.sh/ d' /root/cron && crontab /root/cron && rm /tmp/st/onssl.sh
           msg -azu " Auto-Inicio SSL Detenida!" && msg -bar && sleep 2
           return 1;;
      n|N)return 1;;
      *)return 1 ;;
    esac
    done
  fi 
  clear
  msg -bar
msg -ama "	  \e[1;97m\e[2;100mAUTO-INICIAR SSL \e[0m"
msg -bar 
echo -ne "$(msg -azu "Desea programar El Auto-Inicio SSL [s/n]:") "
  read initio
  if [[ $initio = @(s|S|y|Y) ]]; then
    tput cuu1 && tput dl1
    echo -ne "$(msg -azu " PONGA UN NÚMERO, EJEMPLO [1-12HORAS]:") "
    read initio
    if [[ $initio =~ ^[0-9]+$ ]]; then
      crontab -l > /root/cron
      [[ ! -d /tmp/st ]] && mkdir /tmp/st
	[[ ! -e /tmp/st/onssl.sh ]] && wget -O /tmp/st/onssl.sh https://www.dropbox.com/s/sjbulk4bz6wu2p0/onssl.sh &>/dev/null
	chmod 777 /tmp/st/onssl.sh
      echo "0 */$initio * * * bash /tmp/st/onssl.sh" >> /root/cron
      crontab /root/cron
      
      service cron restart
      rm /root/cron
      tput cuu1 && tput dl1
      msg -azu " Auto-Limpieza programada cada: $(msg -verd "${initio} HORAS")" && msg -bar && sleep 2
    else
      tput cuu1 && tput dl1
      msg -verm2 " ingresar solo numeros entre 1 y 12"
      sleep 2
      msg -bar
    fi
  fi
  return 1
;;
9)
clear
msg -bar
msg -ama "	CERTIFICADOS ALMACENADOS de Zerossl\n	QUIERES USAR EL CERTIFICADO DE ZEROSSL?\n  private.key certificate.crt ca_bundle.crt"
msg -ama
echo -ne " Desea Continuar? [S/N]: "; read seg
[[ $seg = @(n|N) ]] && msg -bar && return
clear
cd /etc/stunnel/
cat private.key certificate.crt ca_bundle.crt > stunnel.pem
#systemctl start stunnel4 &>/dev/null
	#systemctl start stunnel &>/dev/null
	systemctl restart stunnel4 &>/dev/null
	systemctl restart stunnel &>/dev/null
msg -bar
msg -verd "	CERTIFICADO ZEROSSL AGREGADO\n	SERVICIO SSL INICIADO"
msg -bar
;;
esac