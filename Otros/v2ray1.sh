#!/bin/bash
#24/10/2022
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg) > /dev/null
clear&&clear
funINIT() {
[[ $1 == 1 ]] && {
echo 'source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh)' > /bin/v2ray.menu
chmod +x /bin/v2ray.menu 
echo -e " RECUERDA QUE PARA UN INICIO RAPIDO SOLO DIJITA"
msg -bar
print_center -verm2 "v2ray.menu"
msg -bar
msg -ne "Enter Para Continuar" && read enter
echo "v2ray" >> /etc/checkV
				} 
[[ $1 == 2 ]] && {
[[ $(cat /etc/checkV | wc -l) > 4 ]] && return
echo -e " RECUERDA QUE PARA UN INICIO RAPIDO SOLO DIJITA"
msg -bar
print_center -verm2 "v2ray.menu"
msg -bar
msg -ne "Enter Para Continuar" && read enter
echo "v2ray" >> /etc/checkV
				}
}
blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
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

title2(){
v2rayports=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep v2ray | awk '{print substr($9,3); }' > /tmp/v2ray.txt && echo | cat /tmp/v2ray.txt | tr '\n' ' ' > /etc/adm-lite/v2rayports.txt && cat /etc/adm-lite/v2rayports.txt` > /dev/null 2>&1 
v2rayports=$(echo $v2rayports | awk {'print $1'})
_tconex=$(netstat -nap | grep "$v2rayports" | grep v2ray | grep ESTABLISHED| grep tcp6 | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	msg -bar
	[[ $v1 = $v2 ]] && echo -e "   \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] \033[0m" || echo -e " \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] >> \033[1;92m[$v2] \033[0m"
[[ ! -z $v2rayports ]] && echo -e "       \e[97m\033[1;41mPUERTO ACTIVO :\033[0m \033[3;32m$v2rayports\033[0m   \e[97m\033[1;41m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "  \e[97m\033[1;41mERROR A INICIAR V2RAY : \033[0m \033[3;32m FAIL\033[3;32m"
	}

title(){
	msg -bar
	blanco "$1"
	msg -bar
}

userDat(){
	blanco "	N°    Usuarios 		  fech exp   dias"
	msg -bar
}


[[ ! -e /bin/v2ray.menu ]] && funINIT "1" || funINIT "2"
clear&&clear
install_ini () {
sudo apt-get install software-properties-common -y
add-apt-repository universe
apt update -y; apt upgrade -y
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python............... $ESTATUS "
#pip
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || apt-get install python-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python-pip........... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3.............. $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3-pip.......... $ESTATUS "
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
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "

echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}


SCPdir="/etc/adm-lite"
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]]
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="${SCPdir}/protocolos" && [[ ! -d ${SCPinst} ]] 
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
user_conf="/etc/adm-lite/RegV2ray" && [[ ! -e $user_conf ]] && touch $user_conf
user_confEX="/etc/adm-lite/RegV2ray.exp" && [[ ! -e $user_confEX ]] && touch $user_confEX
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
err_fun () {
     case $1 in
     1)msg -verm "-Usuario Nulo-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     2)msg -verm "-Nombre muy corto (MIN: 2 CARACTERES)-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     3)msg -verm "-Nombre muy grande (MAX: 5 CARACTERES)-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     4)msg -verm "-Contraseña Nula-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     5)msg -verm "-Contraseña muy corta-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     6)msg -verm "-Contraseña muy grande-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     7)msg -verm "-Duracion Nula-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     8)msg -verm "-Duracion invalida utilize numeros-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     9)msg -verm "-Duracion maxima y de un año-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     11)msg -verm "-Limite Nulo-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     12)msg -verm "-Limite invalido utilize numeros-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     13)msg -verm "-Limite maximo de 999-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     14)msg -verm "-Usuario Ya Existe-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 15)msg -verm "-(Solo numeros) GB = Min: 1gb Max: 1000gb-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 16)msg -verm "-(Solo numeros)-"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 17)msg -verm "-(Sin Informacion - Para Cancelar Digite CRTL + C)-"; sleep 4s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     esac
}
intallv2ray () {
install_ini
source <(curl -sSL https://www.dropbox.com/s/q6mpwhfgt1665pl/v2ray.sh)
#source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ADMRufu/main/Utils/v2ray/v2ray.sh)
[[ -e "$config" ]] && jq 'del(.inbounds[].streamSettings.kcpSettings[])' < /etc/v2ray/config.json >> /etc/v2ray/tmp.json
#rm -rf /etc/v2ray/config.json
#[[ -e "$config" ]] && jq '.inbounds[].streamSettings += {"network":"ws","wsSettings":{"path": "/ADMcgh/","headers": {"Host": "ejemplo.com"}}}' < /etc/v2ray/tmp.json >> /etc/v2ray/config.json
#v2ray new
[[ -e "$config" ]] && chmod 777 /etc/v2ray/config.json
echo '[Unit]
Description=V2Ray Service
After=network.target nss-lookup.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json
Restart=always
RestartSec=3s


[Install]
WantedBy=multi-user.target' > /etc/systemd/system/v2ray.service
systemctl daemon-reload &>/dev/null
systemctl start v2ray &>/dev/null
systemctl enable v2ray &>/dev/null
systemctl restart v2ray.service
msg -ama "-Intalado con Exito-!"
USRdatabase="/etc/adm-lite/RegV2ray"
[[ ! -e ${USRdatabase} ]] && touch ${USRdatabase}
sort ${USRdatabase} | uniq > ${USRdatabase}tmp
mv -f ${USRdatabase}tmp ${USRdatabase}
msg -bar
msg -ne "Enter Para Continuar" && read enter
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
[[ ! -d /etc/adm-lite/v2ray ]] && mkdir /etc/adm-lite/v2ray
echo 'source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh)' > /bin/v2ray.menu
chmod +x /bin/v2ray.menu
}
protocolv2ray () {
msg -ama "-Escojer opcion 3 y poner el dominio de nuestra IP-!"
msg -bar
v2ray stream
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
dirapache="/usr/local/lib/ubuntn/apache/ver" && [[ ! -d ${dirapache} ]]
tls () {
msg -ama "-Activar o Desactivar TLS-!"
#msg -bar
#echo -e "Ingrese Correo Temporal o Fijo \n  Para Validar su Cerficicado SSL " 
#read -p " Ejemplo email=my@example.com : " crreo
#echo -e $barra
#wget -O -  https://get.acme.sh | sh -s email=$crreo
msg -bar
v2ray tls
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
portv () {
msg -ama "-Cambiar Puerto v2ray-!"
msg -bar
v2ray port
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
stats () {
#msg -ama "-Estadisticas de Consumo-!"
#msg -bar
#v2ray stats
usrCONEC
#msg -bar
#msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
unistallv2 () {
source <(curl -sSL https://www.dropbox.com/s/q6mpwhfgt1665pl/v2ray.sh) --remove > /dev/null 2>&1
#source <(curl -sSL https://www.dropbox.com/s/cx8xhq3s53x3a75/insta-gen.sh)
rm -rf /etc/adm-lite/RegV2ray > /dev/null 2>&1
echo -e "\033[1;92m                  V2RAY REMOVIDO OK "
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
infocuenta () {
v2ray info
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
addusr () {
clear 
clear
msg -bar
msg -tit
msg -ama "             AGREGAR USUARIO | UUID V2RAY"
msg -bar
echo ""
while true; do
echo -ne "\e[91m >> Digita un Nombre: \033[1;92m"
     read -p ": " nick
     nick="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
     if [[ -z $nick ]]; then
     err_fun 17 && continue
     elif [[ "${#nick}" -lt "1" ]]; then
     err_fun 2 && continue
     elif [[ "${#nick}" -gt "9" ]]; then
     err_fun 3 && continue
     fi
     break
done
##DAIS
valid=$(date '+%C%y-%m-%d' -d " +31 days")		  
##CORREO		  
#MAILITO=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)
MAILITO="${nick}"
##ADDUSERV2RAY		  
UUID=`uuidgen`	  
sed -i '13i\           \{' /etc/v2ray/config.json
sed -i '14i\           \"alterId": 0,' /etc/v2ray/config.json
sed -i '15i\           \"id": "'$UUID'",' /etc/v2ray/config.json
sed -i '16i\           \"email": "'$MAILITO'"' /etc/v2ray/config.json
sed -i '17i\           \},' /etc/v2ray/config.json
echo -e "\e[91m >> Agregado UUID: \e[92m$UUID "
while true; do
     echo -ne "\e[91m >> Duracion de UUID (Dias):\033[1;92m " && read diasuser
     if [[ -z "$diasuser" ]]; then
     err_fun 17 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     err_fun 9 && continue
     fi 
     break
done
#Lim
[[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
valid=$(date '+%C%y-%m-%d' -d " +$diasuser days") && datexp=$(date "+%F" -d " + $diasuser days")
echo -e "\e[91m >> Expira el : \e[92m$datexp "
##Registro
echo "  $UUID | $nick | $valid " >> /etc/adm-lite/RegV2ray
v2ray restart > /dev/null 2>&1
echo ""
v2ray info > /etc/adm-lite/v2ray/confuuid.log
lineP=$(sed -n '/'${UUID}'/=' /etc/adm-lite/v2ray/confuuid.log)
numl1=4
let suma=$lineP+$numl1
sed -n ${suma}p /etc/adm-lite/v2ray/confuuid.log 
echo ""
msg -bar
echo -e "\e[92m           UUID AGREGEGADO CON EXITO "
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}

add_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"

	title "		CREAR USUARIO V2RAY"
	userDat

	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "$i" "$DateExp" "$exp"
		}
		let n++
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NOMBRE DEL NUEVO USUARIO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue

	[[ $opcion = 0 ]] && break

	blanco "DURACION EN DIAS" 0
	read dias

	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios

	mv $config $temp
	num=$(jq '.inbounds[].settings.clients | length' $temp)
	new=".inbounds[].settings.clients[$num]"
	new_id=$(uuidgen)
	new_mail="email:\"$opcion\""
	aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
	echo jq \'$new += \{alterId:${aid},id:\"$new_id\","$new_mail"\}\' $temp \> $config | bash
	echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "	Usuario $opcion creado Exitosamente"
	msg -bar
	restart_v2r
	sleep 0.2
    done
}


usrCONEC() {
CGHlog='/var/log/v2ray/access.log'
[[ $log0 -le 1 ]] && {
v2ray restart &> /dev/null
v2ray clean &> /dev/null && let log0++ && clear 
}
msg -bar3
echo -e ""
echo -e " ESPERANDO A LA VERIFICACION DE IPS Y USUARIOS "
echo -e "      ESPERE UN MOMENTO PORFAVOR $log0"
echo -e ""
msg -bar3
fun_bar
msg -bar3
sleep 5s
clear&&clear
title2
msg -bar3
users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"
IP_tconex=$(netstat -nap | grep "$v2rayports"| grep v2ray | grep ESTABLISHED | grep tcp6 | awk {'print $5'}| awk -F ":" '{print $1}' | sort | uniq)
n=1
[[ -z $IP_tconex ]] && echo -e " NO HAY USUARIOS CONECTADOS!"
for i in $IP_tconex
do
	USERauth=$(cat ${CGHlog} | grep $i | grep accepted |awk '{print $7}'| sort | uniq)
	Users+="$USERauth\n"
done
echo -e " N) -|- USER -|- CONEXIONES "|column -t -s '-'
msg -bar3
for U in $users
	do
	CConT=$(echo -e "$Users" | grep $U |wc -l)
	[[ $CConT = 0 ]] && continue
	UConc+=" $n) -|- $U -|- $CConT\n"
	let n++
done
echo -e "$UConc"|column -t -s '-'
msg -bar3
continuar
read foo
}


renewusr () {
clear 
clear
msg -bar
msg -tit
msg -ama "         USUARIOS REGISTRADOS | UUID V2RAY"
msg -bar
# usersss=$(cat /etc/adm-lite/RegV2ray|cut -d '|' -f1)
# cat /etc/adm-lite/RegV2ray|cut -d'|' -f3
VPSsec=$(date +%s)
local HOST="/etc/adm-lite/RegV2ray.exp"
local HOST2="/etc/adm-lite/RegV2ray.exp"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN USER EXPIRADO -----"
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
else
i=1
echo -e "\e[97m                 UUID                | USER | DATA \e[93m"
msg -bar
while read hostreturn ; do
DateExp="$(cat /etc/adm-lite/RegV2ray.exp|grep -w "$hostreturn"|cut -d'|' -f3)"
if [[ ! -z $DateExp ]]; then             
DataSec=$(date +%s --date="$DateExp")
[[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="\e[91m[Caducado]\e[97m" || EXPTIME="\e[92m[$(($(($DataSec - $VPSsec)) / 86400))]\e[97m Dias"
else
EXPTIME="\e[91m[ S/R ]"
fi 
usris="$(cat /etc/adm-lite/RegV2ray.exp|grep -w "$hostreturn"|cut -d'|' -f2)"
local contador_secuencial+="\e[93m$hostreturn \e[97m|\e[93m$usris\e[97m|\e[93m $EXPTIME \n"           
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat /etc/adm-lite/RegV2ray.exp | wc -l)
	      echo -e "$contador_secuencial \n Numero de Registrados: $linesss"
	}
fi

read -p "" 
return
msg -bar
msg -tit
msg -ama "             AGREGAR USUARIO | UUID V2RAY"
msg -bar
##DAIS
valid=$(date '+%C%y-%m-%d' -d " +31 days")		  
##CORREO		  
MAILITO=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)
##ADDUSERV2RAY		  
UUID=`uuidgen`	  
sed -i '13i\           \{' /etc/v2ray/config.json
sed -i '14i\           \"alterId": 0,' /etc/v2ray/config.json
sed -i '15i\           \"id": "'$UUID'",' /etc/v2ray/config.json
sed -i '16i\           \"email": "'$MAILITO'@gmail.com"' /etc/v2ray/config.json
sed -i '17i\           \},' /etc/v2ray/config.json
echo ""
echo -e "\e[91m >> Agregado UUID: \e[92m$UUID "
while true; do
     echo -ne "\e[91m >> Duracion de UUID (Dias):\033[1;92m " && read diasuser
     if [[ -z "$diasuser" ]]; then
     err_fun 17 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     err_fun 9 && continue
     fi 
     break
done
#Lim
[[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
valid=$(date '+%C%y-%m-%d' -d " +$diasuser days") && datexp=$(date "+%F" -d " + $diasuser days")
echo -e "\e[91m >> Expira el : \e[92m$datexp "
##Registro
echo "  $UUID | $nick | $valid " >> /etc/adm-lite/RegV2ray
v2ray restart > /dev/null 2>&1
echo ""
v2ray info > /etc/adm-lite/v2ray/confuuid.log
lineP=$(sed -n '/'${UUID}'/=' /etc/adm-lite/v2ray/confuuid.log)
numl1=4
let suma=$lineP+$numl1
sed -n ${suma}p /etc/adm-lite/v2ray/confuuid.log 
echo ""
msg -bar
echo -e "\e[92m           UUID AGREGEGADO CON EXITO "
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}


renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d " " -f1 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$i
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		msg -bar
		col "0)" "VOLVER"
		msg -bar
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.2
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.2
		} || {
			blanco "DURACION EN DIAS" 0
			read dias

			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			msg -bar
			blanco "	Usuario ${user[$opcion]} renovado Exitosamente"
			msg -bar
			restart_v2r
			sleep 0.2
		  }
		}
	done
}



delusr () {
clear 
clear
invaliduuid () {
msg -bar
echo -e "\e[91m                    UUID INVALIDO \n$(msg -bar)"
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
msg -bar
msg -tit
msg -ama "             ELIMINAR USUARIO | UUID V2RAY"
msg -bar
echo -e "\e[97m               USUARIOS REGISTRADOS"
echo -e "\e[33m$(cat /etc/adm-lite/RegV2ray|cut -d '|' -f2,1)" 
msg -bar
echo -ne "\e[91m >> Digita el UUID a elininar:\n \033[1;92m " && read uuidel
[[ $(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json|head -1) ]] || invaliduuid
lineP=$(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json)
linePre=$(sed -n '/'${uuidel}'/=' /etc/adm-lite/RegV2ray)
sed -i "${linePre}d" /etc/adm-lite/RegV2ray
numl1=2
let resta=$lineP-$numl1
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
v2ray restart > /dev/null 2>&1
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

	title "	ELIMINAR USUARIO V2RAY"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d " " -f 1 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
		}
		let n++
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.2
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.2
		} || {
			[[ $opcion>=${p} ]] && {
				sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			sed -i "/${userd[$opcion]}/d" $user_conf
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			clear
			msg -bar
			blanco "	Usuario eliminado"
			msg -bar
			v2ray restart & > /dev/null
			}
			sleep 0.2
		}
	}
	done
}

_delUSR () {
clear&&clear
msg -bar
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m  BORRAR POR UUID DE USUARIO\033[1;32m "
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m  BORRAR POR NUMERO DE USUARIO \033[1;32m "
msg -bar
selection=$(selection_fun 2)
case ${selection} in
1)dell_user;;
2)delusr;;
*)return;;
esac
return
}

autoDel(){
	seg=$(date +%s)
	while :
	do
		unset users
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
		n=0
		for i in $users
		do
			[[ ! $i = null ]] && {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				[[ "$seg" -gt "$seg_exp" ]] && {
				    #echo "$(cat ${user_conf}|grep -w "${i}")" >> ${user_conf}.exp
					#sed -i "/${i}/d" $user_conf
					mv $config $temp
					echo jq \'del\(.inbounds[].settings.clients[$n]\)\' $temp \> $config | bash
					chmod 777 $config
					rm $temp
					continue
				}
			}
			let n++
			done
			break
		done
#v2ray restart
	}

mosusr_kk() {
clear 
clear
msg -bar
msg -tit
msg -ama "         USUARIOS REGISTRADOS | UUID V2RAY"
msg -bar
# usersss=$(cat /etc/adm-lite/RegV2ray|cut -d '|' -f1)
# cat /etc/adm-lite/RegV2ray|cut -d'|' -f3
VPSsec=$(date +%s)
local HOST="/etc/adm-lite/RegV2ray"
local HOST2="/etc/adm-lite/RegV2ray"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN USER REGISTRADO -----"
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
else
i=1
echo -e "\e[97m                 UUID                | USER | EXPIRACION \e[93m"
msg -bar
while read hostreturn ; do
DateExp="$(cat /etc/adm-lite/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f3)"
if [[ ! -z $DateExp ]]; then             
DataSec=$(date +%s --date="$DateExp")
[[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="\e[91m[Caducado]\e[97m" || EXPTIME="\e[92m[$(($(($DataSec - $VPSsec)) / 86400))]\e[97m Dias"
else
EXPTIME="\e[91m[ S/R ]"
fi 
usris="$(cat /etc/adm-lite/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f2)"
local contador_secuencial+="\e[93m$hostreturn \e[97m|\e[93m$usris\e[97m|\e[93m $EXPTIME \n"           
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat /etc/adm-lite/RegV2ray | wc -l)
	      echo -e "$contador_secuencial \n Numero de Registrados: $linesss"
	}
fi
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
lim_port () {
clear 
clear
msg -bar
msg -tit
msg -ama "          LIMITAR MB X PORT | UUID V2RAY"
msg -bar
###VER
estarts () {
VPSsec=$(date +%s)
local HOST="/etc/adm-lite/v2ray/lisportt.log"
local HOST2="/etc/adm-lite/v2ray/lisportt.log"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN PUERTO REGISTRADO -----"
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
else
i=1
while read hostreturn ; do
iptables -n -v -L > /etc/adm-lite/v2ray/data1.log 
statsss=$(cat /etc/adm-lite/v2ray/data1.log|grep -w "tcp spt:$hostreturn quota:"|cut -d' ' -f3,4,5)
gblim=$(cat /etc/adm-lite/v2ray/lisportt.log|grep -w "$hostreturn"|cut -d'|' -f2)
local contador_secuencial+="         \e[97mPUERTO: \e[93m$hostreturn \e[97m|\e[93m$statsss \e[97m|\e[93m $gblim GB  \n"          
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat /etc/adm-lite/v2ray/lisportt.log | wc -l)
	      echo -e "$contador_secuencial \n Puertos Limitados: $linesss"
	}
fi
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
###LIM
liport () {
while true; do
     echo -ne "\e[91m >> Digite Port a Limitar:\033[1;92m " && read portbg
     if [[ -z "$portbg" ]]; then
     err_fun 17 && continue
     elif [[ "$portbg" != +([0-9]) ]]; then
     err_fun 16 && continue
     elif [[ "$portbg" -gt "1000" ]]; then
     err_fun 16 && continue
     fi 
     break
done
while true; do
     echo -ne "\e[91m >> Digite Cantidad de GB:\033[1;92m " && read capgb
     if [[ -z "$capgb" ]]; then
     err_fun 17 && continue
     elif [[ "$capgb" != +([0-9]) ]]; then
     err_fun 15 && continue
     elif [[ "$capgb" -gt "1000" ]]; then
     err_fun 15 && continue
     fi 
     break
done
uml1=1073741824
gbuser="$capgb"
let multiplicacion=$uml1*$gbuser
sudo iptables -I OUTPUT -p tcp --sport $portbg -j DROP
sudo iptables -I OUTPUT -p tcp --sport $portbg -m quota --quota $multiplicacion -j ACCEPT
iptables-save > /etc/iptables/rules.v4
echo ""
echo -e " Port Seleccionado: $portbg | Cantidad de GB: $gbuser"
echo ""
echo " $portbg | $gbuser | $multiplicacion " >> /etc/adm-lite/v2ray/lisportt.log 
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
###RES
resdata () {
VPSsec=$(date +%s)
local HOST="/etc/adm-lite/v2ray/lisportt.log"
local HOST2="/etc/adm-lite/v2ray/lisportt.log"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN PUERTO REGISTRADO -----"
return 0
else
i=1
while read hostreturn ; do
iptables -n -v -L > /etc/adm-lite/v2ray/data1.log 
statsss=$(cat /etc/adm-lite/v2ray/data1.log|grep -w "tcp spt:$hostreturn quota:"|cut -d' ' -f3,4,5)
gblim=$(cat /etc/adm-lite/v2ray/lisportt.log|grep -w "$hostreturn"|cut -d'|' -f2)
local contador_secuencial+="         \e[97mPUERTO: \e[93m$hostreturn \e[97m|\e[93m$statsss \e[97m|\e[93m $gblim GB  \n"  
        
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat /etc/adm-lite/v2ray/lisportt.log | wc -l)
	      echo -e "$contador_secuencial \n Puertos Limitados: $linesss"
	}
fi
msg -bar

while true; do
     echo -ne "\e[91m >> Digite Puerto a Limpiar:\033[1;92m " && read portbg
     if [[ -z "$portbg" ]]; then
     err_fun 17 && continue
     elif [[ "$portbg" != +([0-9]) ]]; then
     err_fun 16 && continue
     elif [[ "$portbg" -gt "1000" ]]; then
     err_fun 16 && continue
     fi 
     break
done
invaliduuid () {
msg -bar
echo -e "\e[91m                PUERTO INVALIDO \n$(msg -bar)"
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}
[[ $(sed -n '/'${portbg}'/=' /etc/adm-lite/v2ray/lisportt.log|head -1) ]] || invaliduuid
gblim=$(cat /etc/adm-lite/v2ray/lisportt.log|grep -w "$portbg"|cut -d'|' -f3)
sudo iptables -D OUTPUT -p tcp --sport $portbg -j DROP
sudo iptables -D OUTPUT -p tcp --sport $portbg -m quota --quota $gblim -j ACCEPT
iptables-save > /etc/iptables/rules.v4
lineP=$(sed -n '/'${portbg}'/=' /etc/adm-lite/v2ray/lisportt.log)
sed -i "${linePre}d" /etc/adm-lite/v2ray/lisportt.log
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu 
}
## MENU
echo -ne "\033[1;32m [1] > " && msg -azu "-LIMITAR DATA x PORT"
echo -ne "\033[1;32m [2] > " && msg -azu "-RESETEAR DATA DE PORT- "
echo -ne "\033[1;32m [3] > " && msg -azu "-VER DATOS CONSUMIDOS- "
echo -ne "$(msg -bar)\n\033[1;32m [0] > " && msg -bra "\e[97m\033[1;41m VOLVER \033[1;37m"
msg -bar
selection=$(selection_fun 3)
case ${selection} in
1)liport ;;
2)resdata;;
3)estarts;;
0)
source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh)
;;
esac
}

limpiador_activador () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "limv2ray")
if [[ ! $PIDGEN ]]; then
screen -dmS limv2ray watch -n 21600 limv2ray
else
#killall screen
screen -S limv2ray -p 0 -X quit
fi
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "limv2ray")
[[ ! $PID_GEN ]] && PID_GEN="\e[91m [ DESACTIVADO ] " || PID_GEN="\e[92m [ ACTIVADO ] "
statgen="$(echo $PID_GEN)"
clear 
clear
msg -bar
msg -tit
msg -ama "          ELIMINAR EXPIRADOS | UUID V2RAY"
msg -bar
echo ""
echo -e "                    $statgen " 
echo "" 						
msg -bar
msg -ne "Enter Para Continuar" && read enter
v2ray.menu
}

	[[ ! -e $config ]] && {
		clear
		msg -bar
		blanco " No se encontro ningun archivo de configracion v2ray"
		msg -bar
		blanco "	  No instalo v2ray o esta usando\n	     una vercion diferente!!!"
		msg -bar
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion v2ray diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar
msg -ne "Enter Para Continuar" && read enter
clear&&clear
	}

_fixv2() {
unset opcion
clear
	title "   restablecer ajustes v2ray"
	echo -e " \033[0;31mEsto va a restablecer los\n ajustes predeterminados de v2ray"
	echo -e " Se perdera ajuste previos,\n incluido los Usuarios\033[0m"
	echo -e "  LUEGO DE ESTO, DEBERAS RECONFIGURAR TU METODO\n\033[0m"
	msg -bar
	blanco "quiere continuar? [S/N]" 0
	read opcion
	msg -bar
	case $opcion in
		[Ss]|[Yy]) 
		v2ray new 
		echo "" > /etc/adm-lite/RegV2ray
		echo "" > /etc/adm-lite/RegV2ray.exp
		;;
		[Nn]) continuar && read foo;;
	esac
}

_tools(){

echo -e "         \e[97m1 CREAR: "
echo -e "         \e[97m2 RENOVAR: "
echo -e "         \e[97m3 ELIMINAR: "
echo -e "         \e[97mEstado actual: "

selection=$(selection_fun 4)
case ${selection} in
1)add_user;;
2)renew;;
3)dell_user;;
3)portv;;
esac
}

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m- ► Escoje -: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

[[ $1 = "autoDel" ]] && {
	autoDel
} || {
	autoDel
}
clear&&clear
[[ ! -e $config ]] && {
v2ray="\033[1;31m[OFF]"
msg -bar
msg -tit
msg -ama "      PANNEL V2RAY Mod ChumoGH ${vesaoSCT} "
msg -bar
## INSTALADOR
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m  INSTALAR V2RAY         $v2ray"
echo -ne "$(msg -bar)\n\033[1;32m [0] > " && msg -bra "\e[97m\033[1;41m VOLVER \033[1;37m"
msg -bar
pid_inst () {
[[ $1 = "" ]] && echo -e "\033[1;31m[OFF]" && return 0
unset portas
portas_var=$(lsof -V -i -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep $1)
[[ ! -z ${portas_var} ]] && echo -e "\033[1;32m[ Servicio Activo ]" || echo -e "\033[1;31m[ Servicio Desactivado ]"
}
echo -e "         \e[97mEstado actual: $(pid_inst v2ray)"
unset selection
selection=$(selection_fun 1)
case ${selection} in
1)intallv2ray;;
esac
} || {
PID_GEN=$(ps x|grep -v grep|grep "limv2ray")
[[ ! $PID_GEN ]] && PID_GEN="\e[91m [ OFF ] " || PID_GEN="\e[92m [ ON ] "
statgen="$(echo $PID_GEN)"
[[ $(cat /etc/v2ray/config.json | jq '.inbounds[].streamSettings.security') = '"tls"' ]] && _tlsN=" \033[1;32m [ \033[0;34m ACTIVO \033[1;32m ]" || _tlsN=" \033[1;32m [ \033[0;33m CERRADO\033[1;32m ]"
[[ -e /etc/v2ray/config.json ]] && _netW="$(cat /etc/v2ray/config.json | jq '.inbounds[].streamSettings.network')" || _netW="\033[0;32mnull"
[[ -e /etc/v2ray/config.json ]] && _v2Reg="$(cat /etc/v2ray/config.json | jq .inbounds[].settings.clients[].email|wc -l)" || _v2Reg="\033[0;32mnull"
_v2RegE=$(cat $user_confEX | wc -l)
v1=$(cat /bin/ejecutar/v-new.log)
v2=$(cat /etc/adm-lite/v-local.log)
[[ $v1 = $v2 ]] && vesaoSCT="\033[0;33m ($v2)" || vesaoSCT="\033[0;33m($v2) ► \033[1;32m($v1)\033[1;31m"
v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
[[ -z $(echo "$v2rayports" | awk {'print $1'}) ]] && _v2rayports="null" || _v2rayports=$(echo "$v2rayports" | awk {'print $1'})
_tconex=$(netstat -nap | grep "$_v2rayports" | grep v2ray | grep ESTABLISHED |grep tcp6| awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
#SPR & 
msg -bar3
msg -bar
msg -tit
msg -ama "      PANNEL V2RAY Mod ChumoGH ${vesaoSCT} "
[[ ! -z $_v2rayports ]] && echo -e "       \e[97m\033[1;41mPUERTO ACTIVO :\033[0m \033[3;32m$_v2rayports\033[0m   \e[97m\033[1;41m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "  \e[97m\033[1;41mERROR A INICIAR V2RAY : \033[0m \033[3;32m FAIL\033[3;32m"
msg -bar
bg=0
## INSTALADOR
[[ $(v2ray info |grep Group | wc -l) > 0 ]] || {
echo -e "\033[0;35m[\033[0;36m12\033[0;35m] \033[0;34m<\033[0;33m V2RAY BUGEADO \033[1;32m [ \033[0;34mFIX INSTALL \033[1;32m ]" 
bg=1
} 
[[ $bg = 0 ]] && {
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m  CAMBIAR PROTOCOLO  -> \033[1;32m [ \033[0;34m${_netW} \033[1;32m ]" 
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m  TLS ESTADO : -> ${_tlsN}"
echo -e "\033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;33m  CAMBIAR PUERTO V2RAY \033[1;32m [ \033[0;32m$_v2rayports \033[1;32m]\n$(msg -bar) "
## CONTROLER \033[0;31m [\033[0;32mON\033[0;31m] 
echo -e "\033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m<\033[0;33m  AÑADIR USUARIO UUID "
#echo -e "\033[0;35m[\033[0;36mG\033[0;35m] \033[0;34m<\033[0;33m  AÑADIR USUARIO POR GRUPOS "
echo -e "\033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m<\033[0;33m  ELIMINAR USUARIO UUID "
echo -e "\033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m<\033[0;33m  RENOVAR USUARIO \033[1;32m ( ${_v2RegE} )"
echo -e "\033[0;35m[\033[0;36m7\033[0;35m] \033[0;34m<\033[0;33m  USUARIOS REGISTRADOS \033[1;32m ( ${_v2Reg} )"
echo -e "\033[0;35m[\033[0;36m8\033[0;35m] \033[0;34m<\033[0;33m  INFORMACION DE CUENTAS "
#echo -e "\033[0;35m[\033[0;36m9\033[0;35m] \033[0;34m<\033[0;33m  ESTADISTICAS DE CONSUMO "
echo -e "\033[0;35m[\033[0;36m9\033[0;35m] \033[0;34m<\033[0;33m  USUARIOS CONECTADOS "
#echo -ne "\033[1;32m [10] > " && msg -azu " LIMITADOR POR CONSUMO \033[1;33m( #BETA )"
echo -e "\033[0;35m[\033[0;36m10\033[0;35m] \033[0;34m<\033[0;33m  LIMPIADOR DE EXPIRADOS $statgen\n$(msg -bar)"
echo -e "\033[0;35m[\033[0;36m13\033[0;35m] \033[0;34m<\033[0;33m  FUNCIONES BETAS \n$(msg -bar)"
} || {
clear&&clear
	title "   V2RAY CON UN BUG - PARA FIXEAR"
	echo -e " \033[0;31m Selecciona, la opcion disponible"
	echo -e " y recuerda leer las indicaciones que sugiere\n"
	echo -e "  LUEGO DE ESTO, DEBERAS RECONFIGURAR TU METODO\n\033[0m"
	msg -bar
echo -e "\033[0;35m[\033[0;36m12\033[0;35m] \033[0;34m<\033[0;33m V2RAY BUGEADO \033[1;32m [ \033[0;34mFIX INSTALL \033[1;32m ]" 
}
## DESISNTALAR
echo -ne "\033[1;32m [11] > " && msg -azu "\033[1;31mDESINSTALAR V2RAY"
echo -ne "$(msg -bar)\n\033[1;32m [0] > " && msg -bra "\e[97m\033[1;41m VOLVER \033[1;37m"
msg -bar
pid_inst () {
[[ $1 = "" ]] && echo -e "\033[1;31m[OFF]" && return 0
unset portas
portas_var=$(lsof -V -i -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep $1)
[[ ! -z ${portas_var} ]] && echo -e "\033[1;32m[ Servicio Activo ]" || echo -e "\033[1;31m[ Servicio Desactivado ]"
}
echo -e "         \e[97mEstado actual: $(pid_inst v2ray)"
unset selection
selection=$(selection_fun 13)
case ${selection} in
0)v2ray restart && exit ;;
1)protocolv2ray;;
2)tls;;
3)portv;;
4)addusr;;
5)_delUSR;;
6)echo -e " ANALIZANDO USUARIOS CADUCADOS"
renew;;
7)mosusr_kk;;
8)infocuenta;;
9)stats;;
#10)lim_port;;
10)limpiador_activador;;
11)unistallv2;;
12)_fixv2;;
13)_tools;;
esac
}
