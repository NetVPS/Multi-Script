#!/bin/bash
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
bar="$(msg -bar3)"
[[ -e /etc/systemd/system/btkill.service ]] && systemctl restart btkill.service &>/dev/null.
tr=${id}
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

# SISTEMA DE SELECAO
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37mOpcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
function_verify () {
unset keybot
echo -e "\033[7;49;35m    =====>>►► 🐲 GEN ChumoGH${TTcent}VPS 🐲 ◄◄<<=====      \033[0m"
msg -bar
[[ "$(echo "$(cat < /etc/nivbot)")" -ge "5" ]] && {
[[ -e /bin/downloadbot ]] && {
[[ -z $(cat < /bin/downloadbot) ]] && read -p " Ingresa tu Key de Autorizacion : " keybot || unset keybot
} || read -p " Key de Autorizacion : " keybot 
} || read -p " Key de Autorizacion : " keybot 
[[ -z $keybot ]] && {
rm -f /bin/downloadbot
[[ -e /bin/downloadbot ]] && link="$(cat < /bin/downloadbot)" || link='https://raw.githubusercontent.com'
permited=$(curl -sSL "${link}/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot") 
} || {
permited=$(curl -sSL "$(ofus $keybot)/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot")
}
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  echo -e "\n\n\n\e[31m====================================================="
  echo -e "\e[31m      ¡LA IP $(wget -qO- ipv4.icanhazip.com) FUE RECHAZADA!"
  echo -e "     $link No AUTORIZADA el ACCESO "
  echo -e " SI DESEAS USAR EL BOTGEN CONTACTE A @ChumoGH"
  echo -e "\e[31m=====================================================\n\n\n\e[0m"
  [[ -e "/bin/ShellBot.sh" ]] && rm -f /bin/ShellBot.sh
    exit 1
  } || {
 ### INTALAR VERCION DE SCRIPT
  clear
  echo -e "\n\n\n\e[32m====================================================="
  echo -e "\e[32m      ¡LA IP $(wget -qO- ipv4.icanhazip.com) ESTA AUTORIZADA!"
  echo -e "      Mediante  $link Autorida por @ChumoGH"
  echo -e "      SI DESEAS USAR EL BOTGEN CONTACTE A @ChumoGH"
  echo -e "\e[32m=====================================================\n\n\n\e[0m"
  CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
  [[ -e /etc/nivbot ]] && { 
  i=$(cat < /etc/nivbot)
  lv=$(($i+1))
  echo $lv > /etc/nivbot
  } || echo "1" > /etc/nivbot
  v1=$(curl -sSL "https://www.dropbox.com/s/8tizr516cvkwss6/v-new.log")
  echo "$v1" > /etc/ADM-db/vercion  
  }
}

edit_cost () {
msg -bar
echo -e "\033[1;37mRECUERDA EDITAR LOS COSTOS O TIEMPOS\n Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
echo -e " \033[1;31m[ !!! ]\033[1;33m RECUERDA, UNA VEZ EDITADO NO PODRAS VOLVER A \n TENER EL ORIGINAL, A MENOS QUE REINSTALES   \033[1;31m\033[1;33m"
msg -bar 
echo -e " \033[1;31mLuego de editar Presiona Ctrl + O y Enter \033[1;33m \033[1;31m\033[1;33m"
echo -e " \033[1;31m          Por Ultimo Ctrl + X  \033[1;33m \033[1;31m\033[1;33m"
echo -ne "\033[1;37m"
read -p " Presiona Enter para Continuar "
nano /etc/ADM-db/sources/costes
systemctl restart BotGen-server &>/dev/null
echo -e " MODIFICADO EXITOSAMENTE"
bot_gen
}

change_pay () {
unset option
clear
echo -e "$bar"
echo -e "  MENSAJE ACTUAL $(cat < /etc/mpayu)"
echo -e "$bar"
echo -e "  \033[1;37mINGRESA TU METODO DE PAGO Y/O CORREO"
echo -e "$bar\n"
echo -e "Ingresa en este Orden o Secuencia \n PAYPAL : chumogh@gmail.com \n"
echo -e "$bar"
read -p "TEXTO: " opcion
[[ -z $opcion ]] && bot_gen && exit || echo "$opcion" > /etc/mpayu && echo "TOKEN APLICADO EXITOSAMENTE"
read -p " Enter para Continuar"
echo -e "$bar"
echo -e "  \033[1;37m NUMERO DE CONTACTO ACTUAL $(cat < /etc/numctc) "
echo -e "$bar\n"
echo -e " Ingresa en este Orden o FORMATO \n   593987072611  \n"
echo -e "$bar"
read -p "TEXTO: " opcion1
opcion1="$(echo -e "$opcion1" | sed -e 's/[^0-9]//ig')"
[[ -z $opcion ]] && return || { 
echo -e "$opcion1" > /etc/numctc
chmod +x /etc/numctc
echo "TOKEN APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
echo -e "$bar\n"
echo -e " AGREGA NUEVO URL DE CATALOGO / OPCIONAL \n  https://shoppy.gg/@ChumoGH/  \n"
echo -e "$bar"
read -p "TEXTO: " nmsg
[[ -z $nmsg ]] && return || { 
echo -e "$nmsg" > /etc/urlCT
chmod +x /etc/urlCT
echo "URL APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
echo -e "$bar\n"
echo -e " AGREGA NUEVO ENLACE PARA DONACIONES / OPCIONAL \n  https://www.paypal.com/paypalme/ChumoGH  \n"
echo -e "$bar"
read -p "TEXTO: " donat
[[ -z $donat ]] && return || { 
echo -e "$donat" > /etc/urlDN
chmod +x /etc/urlDN
echo "URL APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
read -p " Enter para Continuar"
systemctl restart BotGen-server &>/dev/null
bot_gen
}

lim-bot () {
unset option
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el Limite del Bot"
echo -e "$bar"
echo -n "Limite: "
read opcion
echo "$opcion" > ${CIDdir}/limit
echo "$opcion" > /etc/limit
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "kill_drop.sh")
if [[ ! $PIDGEN ]]; then
	msg -bar
	echo -ne "\033[1;97m Poner en linea KILL ID [s/n]: "
	read bot_ini
	msg -bar
[[ $bot_ini = @(s|S|y|Y) ]] && {

	echo -e "[Unit]
Description=BotGen Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash /etc/ADM-db/sources/kill_drop.sh 
Restart=always
RestartSec=60s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/btkill.service
	systemctl enable btkill &>/dev/null
	systemctl start btkill &>/dev/null
	msg -bar
	echo -e "\033[1;31m            Bot ID KILL ACTIVADO"
	msg -bar
	}
else
killall kill_drop.sh &>/dev/null
systemctl stop btkill &>/dev/null
systemctl disable btkill &>/dev/null
rm /etc/systemd/system/btkill.service &>/dev/null
clear
msg -bar
echo -e "\033[1;31m            Bot ID KILL fuera de linea"
msg -bar
fi
read -p "Presione Enter para continuar "
bot_gen


#echo "sed -i "s/1001282138571/0/g" /etc/gerar-sh-log
#echo '#!/bin/bash -e
#sleep 24h' > ${CIDdir}/sumlimit
#echo 'newq=$(cat < /etc/ADM-db/limit)
#opcion=$(cat < /etc/limit)
#newsum=$(($newq + $opcion))
#echo "$newsum" > /etc/ADM-db/limit
#screen -dmS sumlimit bash /etc/ADM-db/sumlimit&
#exit' >> ${CIDdir}/sumlimit
#echo -e "$bar"
#read -p "Presione Enter para continuar "
#screen -dmS sumlimit bash /etc/ADM-db/sumlimit&
#bot_gen
}

veryfy_fun () {
SRC="/etc/ADM-db/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
unset ARQ
case $1 in
"BotGen.sh")ARQ="/etc/ADM-db/";;
*)ARQ="/etc/ADM-db/sources/";;
esac
mv -f $HOME/update/$1 ${ARQ}/$1 && echo -e "\033[1;31m- \033[1;32mRecibido!" || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
chmod +x ${ARQ}/$1
}

download () {
clear
msg -bar
echo -e "\033[1;33mDescargando archivos... ESPERE "
msg -bar
wget -q --no-check-certificate -O $HOME/files.tar https://www.dropbox.com/s/pf3b054mts3zrj6/files.tar
[[ -d $HOME/update ]] && rm -rf $HOME/update/* || mkdir $HOME/update
[[ -e $HOME/files.tar ]] && tar xpf $HOME/files.tar -C $HOME/update && rm -f $HOME/files.tar
echo 999 > ${CIDdir}/limit
n=1
for arqx in `ls $HOME/update`; do
echo -ne "\033[1;33mFichero \033[1;31m[${n}.bot] "
[[ -e $HOME/update/$arqx ]] && veryfy_fun $arqx
n=$(($n + 1))
done
cd $HOME && rm -rf $HOME/update && rm -f $HOME/files.tar
echo -ne "\033[1;31m[ ! ] RESTAUDANDO ADMINISTRADOR "
(
[[ -e $HOME/costes ]] && mv $HOME/costes /etc/ADM-db/sources/costes 
[[ -e $HOME/token ]] && mv $HOME/token /etc/ADM-db/token 
[[ -e $HOME/resell ]] && mv $HOME/resell /etc/ADM-db/resell
[[ -e $HOME/Admin-ID ]] && mv $HOME/Admin-ID /etc/ADM-db/Admin-ID 
[[ -e $HOME/User-ID ]] && mv $HOME/User-ID /etc/ADM-db/User-ID 
[[ -e $HOME/ress ]] && mv $HOME/ress /etc/ADM-db/ress
[[ -e $HOME/limit ]] && mv $HOME/limit /etc/ADM-db/limit
[[ -e $HOME/num-key.cont ]] && mv $HOME/num-key.cont /etc/ADM-db/num-key.cont
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
[[ ! -e ${CIDdir}/resell ]] && echo "@ChumoGH" > ${CIDdir}/resell
[[ ! -e $(cat < /etc/mpayu) ]] && echo "Paypal : chumogh@outlook.com" > /etc/mpayu && echo "593987072611" > /etc/numctc
 rm $HOME/lista-arq
 systemctl restart BotGen-server &>/dev/null
 bot_gen
}

ini_token () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el token de su bot"
echo -e "$bar"
echo -n "TOKEN: "
read opcion
echo "$opcion" > ${CIDdir}/token
echo -e "$bar"
echo -e "  \033[1;32mtoken se guardo con exito!" && echo -e "$bar" && echo -e "  \033[1;37mPara tener acceso a todos los comandos del bot\n  deve iniciar el bot en la opcion 2.\n  desde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/id\n  \033[1;37mel bot le respodera con su ID de telegram.\n  copiar el ID e ingresar el mismo en la opcion 3" && echo -e "$bar"
read -p "Presione Enter para continuar "
bot_gen
}

ini_res () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el Contacto de ADMIN de su bot"
echo -e "$bar"
echo -n "RESELLER: "
read opction
echo "$opction" > ${CIDdir}/resell
echo -e "$bar"
read -p "Presione Enter para continuar "
bot_gen
}

ini_id () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese su ID de telegram"
echo -e "$bar"
echo -n "ID: "
read opcion
echo "$opcion" > ${CIDdir}/Admin-ID
echo -e "$bar"
echo -e "  \033[1;32mID guardo con exito!" && echo -e "$bar" && echo -e "  \033[1;37mdesde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/menu\n  \033[1;37mprueve si tiene acceso al menu extendido." && echo -e "$bar"
read -p "Presione Enter para continuar "
bot_gen
}

start_bot () {
[[ ! -e "${CIDdir}/token" ]] && echo "null" > ${CIDdir}/token
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "BotGen.sh")
if [[ ! $PIDGEN ]]; then
echo -e "[Unit]
Description=BotGen Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash ${CIDdir}/BotGen.sh -start
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/BotGen-server.service

		systemctl enable BotGen-server &>/dev/null
    	systemctl start BotGen-server &>/dev/null
else
killall BotGen.sh &>/dev/null
systemctl stop BotGen-server &>/dev/null
systemctl disable BotGen-server &>/dev/null
rm /etc/systemd/system/BotGen-server.service &>/dev/null
clear
msg -bar
echo -e "\033[1;31m            BotGen fuera de linea"
msg -bar
read -p "Presione Enter para continuar "
fi
bot_gen
}

ayuda_fun () {
clear
echo -e "$bar"
echo -e "            \e[47m\e[30m Instrucciones rapidas \e[0m"
echo -e "$bar"
echo -e "\033[1;37m   Es necesario crear un bot en \033[1;32m@BotFather "
echo -e "$bar"
echo -e "\033[1;32m1- \033[1;37mEn su apps telegram ingrese a @BotFather"
echo -e "\033[1;32m2- \033[1;37mDigite el comando \033[1;31m/newbot"
echo -e "\033[1;32m3- @BotFather \033[1;37msolicitara que\n   asigne un nombre a su bot"
echo -e "\033[1;32m4- @BotFather \033[1;37msolicitara que asigne otro nombre,\n   esta vez deve finalizar en bot eje: \033[1;31mXXX_bot"
echo -e "\033[1;32m5- \033[1;37mObtener token del bot creado.\n   En \033[1;32m@BotFather \033[1;37mdigite el comando \033[1;31m/token\n   \033[1;37mseleccione el bot y copie el token."
echo -e "\033[1;32m6- \033[1;37mIngrese el token\n   en la opcion \033[1;32m[1] \033[1;31m> \033[1;37mTOKEN DEL BOT"
echo -e "\033[1;32m7- \033[1;37mPoner en linea el bot\n   en la opcion \033[1;32m[2] \033[1;31m> \033[1;37mINICIAR/PARAR BOT"
echo -e "\033[1;32m8- \033[1;37mEn su apps telegram, inicie el bot creado\n   digite el comando \033[1;31m/id \033[1;37mel bot le respondera\n   con su ID de telegran (copie el ID)"
echo -e "\033[1;32m9- \033[1;37mIngrese el ID en la\n   opcion \033[1;32m[3] \033[1;31m> \033[1;37mID DE USUARIO TELEGRAM"
echo -e "\033[1;32m10-\033[1;37mcomprueve que tiene acceso a\n   las opciones avanzadas de su bot."
echo -e "$bar"
read -p "Presione Enter para continuar "
bot_gen
}

bot_conf () {
[[ -e /etc/ADM-db/token ]] && mv /etc/ADM-db/token /root/token
[[ -e /etc/ADM-db/Admin-ID ]] && mv /etc/ADM-db/Admin-ID /root/Admin-ID
check_ip
function_verify
instaled=/etc/ADM-db/sources && [[ ! -d ${instaled} ]] && download
}

msj_prueba () {

TOKEN="$(cat /etc/ADM-db/token)"
ID="$(cat /etc/ADM-db/Admin-ID)"

[[ -z $TOKEN ]] && {
	clear
	echo -e "$bar"
	echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
	echo -e "$bar"
	read foo
} || {
	[[ -z $ID ]] && {
		clear
		echo -e "$bar"
		echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
		echo -e "$bar"
		read foo
	} || {
		MENSAJE="---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n"
		MENSAJE+="Esto es un mesaje de prueba!\n"
		MENSAJE+="$bar\n"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" &>/dev/null
		clear
		echo -e "---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n"
		echo -e "\033[1;37m Mensaje enviado Exitosamente...!"
		echo -e "$bar"
		sleep 3s
	}
}

bot_gen
}

addnewmss() {
unset yesno
unset dnew
let foc++
echo -e "$bar"
echo -e "  \033[1;37mINGRESA EL MENSAJE A ENVIAR"
echo -e "$bar"
read -p " $foc TEXTO: " addmss 
MSS+="$addmss\n"
echo -e "${cor[3]} ¿DESEAS AÑADIR OTRO SMS ? "
read -p " [S/N]: " -e -i s sshsn
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ "$sshsn" = @(s|S|y|Y) ]] && addnewmss
}



msj_ind () {
foc=1
TOKEN="$(cat /etc/ADM-db/token)"
echo -e "$bar" 
echo -e "  \033[1;37mIngrese su ID de telegram a Mensajear"
echo -e "$bar"
read -p "ID: " ID 
[[ -z $ID ]] && ID="$(cat /etc/ADM-db/Admin-ID)"
[[ -z $TOKEN ]] && {
	clear
	echo -e "$bar"
	echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
	echo -e "$bar"
	read foo
} || {
	[[ -z $ID ]] && {
		clear
		echo -e "$bar"
		echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
		echo -e "$bar"
		read foo
	} || {
		MENSAJE="Hola, Mensale de Prueba del BotGen Generador!"
echo -e "$bar"
echo -e "  \033[1;37mINGRESA EL MENSAJE A ENVIAR"
echo -e "$bar"
read -p " $foc TEXTO: " addmss 
MSS+="$addmss\n"
echo -e "${cor[3]} ¿DESEAS AÑADIR OTRO SMS ? "
read -p " [S/N]: " -e -i s sshsn
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ "$sshsn" = @(s|S|y|Y) ]] && addnewmss
MENSAJE='  ---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n'
MENSAJE+="$MSS \n "
echo -e "$bar"
echo -e "  \033[1;37mPEGA RUTA DE IMAGEN"
echo -e "$bar"
read -p "IMG: " img 
#[[ -z $img ]] && img="https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/favi.png"
#[[ -z $img ]] && img="/var/www/html/bot_vmess_qr.png"
[[ -z $MENSAJE ]] && MENSAJE="Hola, Mensale de Prueba del BotGen Generador!"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		URG="https://api.telegram.org/bot$TOKEN/sendPhoto"
		curl -s -X POST $URG -F chat_id=$ID -F photo="@$img" #-F caption="<code>New Script @ChumoGH</code>" #-F width="100" -F height="100"
		curl -s -X POST $URL -d chat_id=$ID -d text="$(echo -e "$MENSAJE")" &>/dev/null
#		clear
		echo -e "@$img"
		echo -e "$bar"
		echo -e "\033[1;37m Mensaje enviado Exitosamente...!"
		echo -e "$bar"
		read -p "ENTER PARA Continuar"
	}
}

bot_gen
}



act-bot () {
echo "Respaldando TOKEN y ADMINISTRADOR" 
[[ -e /etc/ADM-db/token ]] && mv /etc/ADM-db/token /root/token
[[ -e /etc/ADM-db/Admin-ID ]] && mv /etc/ADM-db/Admin-ID /root/Admin-ID
[[ -e /etc/ADM-db/User-ID ]] && mv /etc/ADM-db/User-ID /root/User-ID
[[ -e /etc/ADM-db/ress ]] && mv /etc/ADM-db/ress /root/ress
[[ -e /etc/ADM-db/sources/costes ]] && mv /etc/ADM-db/sources/costes /root/costes
[[ $(cat < /etc/ADM-db/resell) != "@ChumoGH" ]] && mv /etc/ADM-db/resell /root/resell
rm -rf /etc/ADM-db/sources/gerar_key && download
}

respon () {
[[ ! -e /etc/menu_ito ]] && credd=$(cat < /etc/SCRIPT/menu_credito) || credd=$(cat /etc/menu_ito ) 
[[ -e ${CIDdir}/ress ]] && {
echo -e "DESACTIVANDO RESELLER $credd FIJO EN BotGEN"
echo -e "   AHORA SE FIJARA EL NOMBRE DE QUIEN GENERE LA KEY"
read -p "ENTER PARA VOLVER"
rm -f ${CIDdir}/ress 
} || { 
echo -e "ACTIVANDO RESELLER $credd FIJO EN BotGEN"
echo -e "AHORA SE FIJARA $credd EN TODAS LAS KEYS "
read -p "ENTER PARA VOLVER"
touch ${CIDdir}/ress
}
bot_gen
}


bot_gen () {
clear
unset PID_GEN
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
PID_GEN=$(ps x|grep -v grep|grep "BotGen.sh")
PID_on=$(ps x|grep -v grep|grep "modelid")
[[ ! $PID_on ]] && PID_on="\033[1;31mOFF" || PID_on="\033[1;32mON"
[[ ! -e /etc/systemd/system/btkill.service ]] && PID_kill="\033[1;31mOFF" || PID_kill="\033[1;32mON"
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31mOFF" || PID_GEN="\033[1;32mON"
[[ -e ${CIDdir}/token ]] && tk="\033[1;32mOK" || tk="\033[1;31mNULL"
[[ -e /etc/numctc ]] && nm="\033[1;32mNUM" || nm="\033[1;31mNULL"
[[ -e /etc/urlDN ]] && dn="\033[1;32mDON" || dn="\033[1;31mNULL"
[[ -e /etc/urlCT ]] && ct="\033[1;32mCAT" || ct="\033[1;31mNULL"
[[ -e ${CIDdir}/Admin-ID ]] && adid="\033[1;32mOK" || adid="\033[1;31mNULL"
[[ -e ${CIDdir}/ress ]] && rfij="\033[1;32mRESELLER FIJO (Bot Personal )" || rfij="\033[1;31mRESELLER ALEATORIO ( Bot Custom )"
limcont=$(cat /etc/ADM-db/limit) 
[[ "${limcont}" = "999" ]] && limted=" ∞ " || limted=$(cat /etc/ADM-db/limit)
msg -bar
echo -e " \033[7;49;35m ${TTini} 🐲 BotGEN ChumoGH${TTcent}ADM $(cat ${CIDdir}/vercion) 🐲 ◄◄<===   \033[0m"
msg -bar
echo -e "  - LIMITADOR \033[1;32m ( $limted ) \033[1;37m KILL ID VENCIDOS ${PID_kill} "
msg -bar 
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;35m> \033[1;37m TOKEN DEL BOT $tk "
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;35m> \033[1;37m INICIAR/PARAR BOT $PID_GEN\033[0m"
echo -e "\033[0;35m[\033[0;36m3\033[0;35m] \033[0;35m> \033[1;37m ID DE USUARIO TELEGRAM  $adid"
echo -e "\033[0;35m[\033[0;36m4\033[0;35m] \033[0;35m> \033[1;37m Cambiar Contacto -> $(cat < ${CIDdir}/resell)"
echo -e "\033[0;35m[\033[0;36m5\033[0;35m] \033[0;35m> \033[1;37m MENSAJE DE PRUEBA"
echo -e "\033[0;35m[\033[0;36m6\033[0;35m] \033[0;36m> \033[1;37m MANUAL De Uso"
echo -e "\033[0;35m[\033[0;36m7\033[0;35m] \033[0;35m> \033[1;37m Limite de KEYS "
echo -e "\033[0;35m[\033[0;36m8\033[0;35m] \033[0;35m> \033[1;37m ENLACES $nm | $dn | $ct "
echo -e "\033[0;35m[\033[0;36m9\033[0;35m] \033[0;35m> \033[1;37m $rfij"
echo -e "\033[0;35m[\033[0;36m10\033[0;35m] \033[0;35m> \033[1;37m MSG POR ID"
echo -e "\033[0;35m[\033[0;36m11\033[0;35m] \033[0;35m> \033[1;37m Modificar COSTES DEL BOT"
msg -bar
echo -e "\033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m SALIR"
msg -bar
selection=$(selection_fun 11)
case ${selection} in
0) gerar && exit ;;
1) ini_token;;
2) start_bot;;
3) ini_id;;
4) ini_res;;
5) msj_prueba;;
6) ayuda_fun;;
#7) source <(curl -sSL https://www.dropbox.com/s/f5mlwun3hkpq6k8/bot-permited.sh) ;;
#8) act-bot ;;
7) lim-bot ;;
8) change_pay;;
9) respon;;
10)msj_ind;;
11)edit_cost;;
*) bot_gen;;
esac
}
