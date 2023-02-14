#!/bin/bash
start_menu () {
source /etc/adm-lite/cabecalho
echo -e "${cor[2]} ⌐╦╦═─ ${cor[5]} MENÚ HERRAMIENTAS By $(cat /etc/adm-lite/menu_credito)"
msg -bar 
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ➮${cor[3]} Bloqueo Torrent y Palabras Claves \033[0;33m( #BETA )"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮${cor[3]} FIX PassWD Vultr"
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m ➮${cor[3]} Bad-VPN (Juegos Online/VideoCalls) $_badvpn"
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m ➮${cor[3]} TCP SPEED ( BBR ) $_tcpspeed"
echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m ➮${cor[3]} FAILBAN\033[0;32m ( Secure IP ) $fail_b"
echo -e "\033[0;35m [\033[0;36m6\033[0;35m]\033[0;31m ➮${cor[3]} DETALLES DEL VPS "
echo -e "\033[0;35m [\033[0;36m7\033[0;35m]\033[0;31m ➮${cor[3]} TEST DE VELOCIDAD DEL SERVIDOR"
echo -e "\033[0;35m [\033[0;36m8\033[0;35m]\033[0;31m ➮${cor[3]} COMPARTIR ARCHIVO ONLINE"
echo -e "\033[0;35m [\033[0;36m9\033[0;35m]\033[0;31m ➮${cor[3]} GENERADOR DE PAYLOAD"
echo -e "\033[0;35m [\033[0;36m10\033[0;35m]\033[0;31m ➮${cor[3]} ULTRA HOST DE DOMINIOS "
echo -e "\033[0;35m [\033[0;36m11\033[0;35m]\033[0;31m ➮${cor[3]} CAPTURAR SUBDOMINIOS \033[0;33m( #ToolMaster )"
echo -e "\033[0;35m [\033[0;36m12\033[0;35m]\033[0;31m ➮${cor[3]} REINICIAR VPS (REBOOT)"
msg -bar 
echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ Regresar ]\e[0m")"
msg -bar
}

#FUNCION DE SELECCION
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m ESCOJE : " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}


block_torrent () {
msg -bar 
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/blockT.sh)
msg -bar 
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
read -p " Presiona Enter para Continuar"
exit
}

fix_vultr () {
msg -bar #
echo -e 'Aplicando FIX para Vultr VPS Passwd'
echo -e "Añadiendo Registro a PAM.D"
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password
msg -bar #
echo -e "Registro agregado"
msg -bar #
sleep 2s
cgh
}

badUDP () {
msg -bar 
echo -e "${cor[4]}  BADVPN se instalará
 que no es más que un programa
 que libera puertos UDP en el servidor
 y así permitir el servicio de VideoLlamadas!"
echo -e "${cor[5]} INICIANDO . . ."
msg -bar 
source <(curl -sSL https://www.dropbox.com/s/0stqb3dzm47kky6/budp.sh)
}

tcp_BBR () {
msg -bar 
echo -e "${cor[4]} Este Script fue proyectado"
echo -e "${cor[4]} Para Mejorar La Latencia"
echo -e "${cor[4]} y velocidad del servidor!"
msg -bar 
echo -e "${cor[5]} analizar"
sleep 1s
if [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]]; then
#INSTALA
echo -e "${cor[5]} Este es un script experimental"
echo -e "${cor[5]} ¡Utilice por su propia cuenta y riesgo!"
echo -e "${cor[5]} Este script cambiará algunas"
echo -e "${cor[5]} configuraciones de red (BBR)"
echo -e "${cor[5]} del sistema para reducir"
echo -e "${cor[5]} la latencia y mejorar la velocidad"
msg -bar 
read -p " Continuar con la instalación? [s/n]: " -e -i s resp_osta
echo -e "\033[1;37m"
if [[ "$resp_osta" = 's' ]]; then
unset resp_osta
echo "#ADM" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} se han agregado con éxito"
msg -bar 
return
 else
msg -bar 
return
fi
 else
#REMOVE
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} ya se han agregado en el sistema!"
msg -bar
read -p " Desea quitar la configuración TCP? [s/n]: " -e -i n res_posta
if [[ "$res_posta" = 's' ]]; then
unset res_posta
grep -v "^#ADM
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} se han eliminado con éxito"
msg -bar
return
 else
msg -bar 
return
 fi
fi
}

fail_ban () {
source fai2ban
fail2ban-testcases -x start 2>/dev/null
fail2ban-client -x start 2>/dev/null
}

online_url () {
msg -bar 
echo -e "${cor[5]} OPCION PARA COLOCAR"
echo -e "${cor[5]} CUALQUIER ARCHIVO ONLINE"
echo -e "${cor[5]} QUE ESTE ARCHIVO"
echo -e "${cor[5]} EN EL DIRECTORIO \033[1;31m$HOME"
msg -bar 
meu_ip
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m➮\033[0;33m COLOCAR ARCHIVO ONLINE  \033[0;32m(#)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m➮\033[0;33m REMOVER ARCHIVO ONLINE  \033[0;32m(#)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m➮\033[0;31m VER MIS ARCHIVOS ONLINE \033[0;33m(#)"
msg -bar 
echo -e " \033[0;35m [\033[0;36mENTER\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ Regresar ]\e[0m")"
read -p " 『 1-3 』: " arquivo_online_adm
number_var $arquivo_online_adm
if [ "$var_number" = "" ]; then
return
 else
online_adm="$var_number"
fi
if [ "$online_adm" -gt 3 ]; then
echo -e "${cor[5]} VER MIS ARCHIVOS ONLINE"
msg -bar 
return
fi
if [ "$online_adm" = 3 ]; then
msg -bar 
for my_arqs in `ls /var/www/html`; do
if [ "$my_arqs" != "index.html" ]; then
 if [ ! -d "$my_arqs" ]; then
echo -e " \033[1;36mhttp://$IP:81/$my_arqs\033[0m"
 fi
fi
done
msg -bar
return
fi
if [ "$online_adm" = 2 ]; then
msg -bar
unset _cont
_cont="1"
for my_arqs in `ls /var/www/html`; do
if [ "$my_arqs" != "index.html" ]; then
 if [ ! -d "$my_arqs" ]; then
select_arc[$_cont]="$my_arqs"
echo -e "${cor[2]}『$_cont』-${cor[3]}【 $my_arqs 】➮ \033[1;36mhttp://$IP:81/$my_arqs\033[0m"
_cont=$(($_cont + 1))
 fi
fi
done
_cont=$(($_cont - 1))
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
echo -e "${cor[5]} Seleccione un archivo:"
read -p " 『1-$_cont』: " slct
number_var $slct
if [ "$var_number" = "" ]; then
return
 else
slct="$var_number"
fi
unset _cont
arquivo_move="${select_arc[$slct]}"
 if [ "$arquivo_move" = "" ]; then
echo -e "${cor[5]} Ningún archivo ha sido seleccionado"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
return
 fi
rm -rf /var/www/html/$arquivo_move > /dev/null 2>&1
rm -rf /var/www/$arquivo_move > /dev/null 2>&1
echo -e "${cor[5]} Procedimiento Hecho Con Éxito"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
return
fi
unset _cont
_cont="1"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
echo -e "${cor[5]} Sus archivos en la carpeta"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
for my_arqs in `ls $HOME`; do
if [ ! -d "$my_arqs" ]; then
select_arc[$_cont]="$my_arqs"
echo -e "${cor[2]}【$_cont】➮${cor[3]}$my_arqs"
_cont=$(($_cont + 1))
fi
done
_cont=$(($_cont - 1))
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
echo -e "${cor[5]} Selecciona un archivo :"
read -p " 『1-$_cont』:  " slct
number_var $slct
if [ "$var_number" = "" ]; then
return
 else
slct="$var_number"
fi
unset _cont
arquivo_move="${select_arc[$slct]}"
if [ "$arquivo_move" = "" ]; then
echo -e "${cor[5]} No se selecciono"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
return
fi
if [ ! -d /var ]; then
mkdir /var
fi
if [ ! -d /var/www ]; then
mkdir /var/www
fi
if [ ! -d /var/www/html ]; then
mkdir /var/www/html
fi
if [ ! -e /var/www/html/index.html ]; then
touch /var/www/html/index.html
fi
if [ ! -e /var/www/index.html ]; then
touch /var/www/index.html
fi
chmod -R 755 /var/www
cp $HOME/$arquivo_move /var/www/$arquivo_move
cp $HOME/$arquivo_move /var/www/html/$arquivo_move
msg -bar 
echo -e "${cor[5]} ACCESO AL ARCHIVO ATRAVES DEL ENLACE"
echo -e "\033[1;36m http://$IP:81/$arquivo_move\033[0m"
echo -e "${cor[5]} FICHERO CARGADO CON EXITO !!"
msg -bar 
}

testing_test () {
clear&&clear
msg -bar
echo -e " INICIANDO PRUEBAS DE VELOCIDAD !"  | pv -qL 25
llenadatos_() {
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "speedtest"|head -1) ]] || apt-get install speedtest -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "speedtest-cli"|head -1) ]] || apt-get install speedtest-cli -y &>/dev/null
}
function aguarde() {
	sleep 1
	helice() {
		llenadatos_ >/dev/null 2>&1 &
		TMPDIR="$(mktemp -d)"
		speedtest --share > $TMPDIR/result.txt &> /dev/null
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m REALIZANDO PRUEBAS DE\033[1;32m DESCARGA \033[1;37m& \033[1;32mSUBIDA\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}

msg -bar 
aguarde
msg -bar
echo " --------------------- "
echo " RUTA : $TMPDIR "
echo " ----------------------"
cat $TMPDIR/result.txt
echo "######################################"
echo "................................."
TMPDIR="$(mktemp -d)"
speedtest --share > $TMPDIR/result.txt &> /dev/null
echo ""
echo " --------------------- "
echo " NEW RUTA : $TMPDIR "
echo " ----------------------"
cat $TMPDIR/result.txt
echo "######################################"
pingGG=$(ping -c1 google.com |awk '{print $8 $9}' |grep -v loss |cut -d = -f2 |sed ':a;N;s/\n//g;ta')
power_by=$(less $TMPDIR/result.txt | grep "Testing from" | awk '{print $3,$4}')
down_load=$(less $TMPDIR/result.txt | grep "Download" | awk '{print $2,$3}')
up_load=$(less $TMPDIR/result.txt  | grep "Upload" | awk '{print $2,$3}')
resultURL=$(less $TMPDIR/result.txt  | grep "Share results" | awk '{print $2,$3}')
echo -e "${cor[5]} HOSTING BASE   : $power_by "
echo -e "${cor[5]} LATENCIA PING  : $pingGG "
echo -e "${cor[5]} V DE SUBIDA    : $up_load"
echo -e "${cor[5]} V DE DESCARGA  : $down_load"
echo -e "${cor[5]} URL DE TEST    : $resultURL"
msg -bar 
return
}

function_10 () {
null="\033[1;31m"
msg -bar  
if [ ! /proc/cpuinfo ]; then
echo -e "${cor[4]} Error al procesar información"
msg -bar  
return
fi
if [ ! /etc/issue.net ]; then
echo -e "${cor[4]} Error al procesar información"
msg -bar  
return
fi
if [ ! /proc/meminfo ]; then
echo -e "${cor[4]} Error al procesar información"
msg -bar  
return
fi
totalram=$(free | grep Mem | awk '{print $2}')
usedram=$(free | grep Mem | awk '{print $3}')
freeram=$(free | grep Mem | awk '{print $4}')
swapram=$(cat /proc/meminfo | grep SwapTotal | awk '{print $2}')
system=$(cat /etc/issue.net)
clock=$(lscpu | grep "CPU MHz" | awk '{print $3}')
based=$(cat /etc/*release | grep ID_LIKE | awk -F "=" '{print $2}')
processor=$(cat /proc/cpuinfo | grep "model name" | uniq | awk -F ":" '{print $2}')
cpus=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ "$system" ]; then
echo -e "${cor[5]} Su Sistema          : ${null}$system"
else
echo -e "${cor[5]} Su Sistema          : ${null}???"
fi
if [ "$based" ]; then
echo -e "${cor[5]} BASADO              : ${null}$based"
else
echo -e "${cor[5]} BASADO              : ${null}???"
fi
if [ "$processor" ]; then
echo -e "${cor[5]} PROCESADOR FISICO   : ${null}$processor x$cpus"
else
echo -e "${cor[5]} PROCESADOR FISICO   : ${null}???"
fi
if [ "$clock" ]; then
echo -e "${cor[5]} FRECUENCIA MAXIMA   : ${null}$clock MHz"
else
echo -e "${cor[5]} FRECUENCIA MAXIMA   : ${null}???"
fi
echo -e "${cor[5]} USO DEL CPU         : ${null}$(ps aux  | awk 'BEGIN { sum = 0 }  { sum += sprintf("%f",$3) }; END { printf " " "%.2f" "%%", sum}')"
echo -e "${cor[5]} Arquitectura CPU ID : ${null}$(lscpu | grep "Vendor ID" | awk '{print $3}')"
echo -e "${cor[5]} MEMORIA RAM Total   : ${null}$(($totalram / 1024))"
echo -e "${cor[5]} MEMORIA RAM USADA   : ${null}$(($usedram / 1024))"
echo -e "${cor[5]} MEMORIA RAM LIBRE   : ${null}$(($freeram / 1024))"
echo -e "${cor[5]} MEMORIA SWAP        : ${null}$(($swapram / 1024))MB"
echo -e "${cor[5]} TIEMPO ONLINE      : ${null}$(uptime)"
echo -e "${cor[5]} NOMBRE DEL VPS      : ${null}$(hostname)"
echo -e "${cor[5]} DIRECCION  VPS : ${null}$(ip addr | grep inet | grep -v inet6 | grep -v "host lo" | awk '{print $2}' | awk -F "/" '{print $1}' | head -1)"
echo -e "${cor[5]} DIRECCION DE LA VPS : ${null}$(wget -qO- ifconfig.me)"
echo -e "${cor[5]} VERSION DEL KERNEL : ${null}$(uname -r)"
echo -e "${cor[5]} ARQUITECTURA DEL VPS: ${null}$(uname -m)"
msg -bar  
return
}

criar_pay () {
msg -bar  
echo -e "${cor[5]} DIJITE SU HOST PARA EMPEZAR"
echo -e "${cor[5]} ¡PAYLOADS GENERICAS!"
echo -e "${cor[5]} INGRESA TU HOST"
msg -bar  
read -p " => " valor1
if [ "$valor1" = "" ]; then
echo -e "${cor[5]} NO SE INGRESO HOST!!!"
return
fi
meu_ip
valor2="$IP"
if [ "$valor2" = "" ]; then
valor2="127.0.0.1"
fi
msg -bar  
echo -e "${cor[5]} ELEJIR METODO DE RESPUESTA ${cor[3]}"
echo -e " 1-GET"
echo -e " 2-CONNECT"
echo -e " 3-PUT"
echo -e " 4-OPTIONS"
echo -e " 5-DELETE"
echo -e " 6-HEAD"
echo -e " 7-TRACE"
echo -e " 8-PROPATCH"
echo -e " 9-PATCH"
msg -bar  
read -p " => " valor3
case $valor3 in
1)req="GET";;
2)req="CONNECT";;
3)req="PUT";;
4)req="OPTIONS";;
5)req="DELETE";;
6)req="HEAD";;
7)req="TRACE";;
8)req="PROPATCH";;
9)req="PATCH";;
*)req="GET";;
esac
msg -bar  
echo -e "${cor[5]} POR ULTIMO"
echo -e "${cor[5]} METODO DE INJECCCION ${cor[3]}"
echo -e " 1-realData"
echo -e " 2-netData"
echo -e " 3-raw"
msg -bar  
read -p " => " valor4
case $valor4 in
1)in="realData";;
2)in="netData";;
3)in="raw";;
*)in="netData";;
esac
msg -bar  
name=$(echo $valor1 | awk -F "/" '{print $2'})
if [ "$name" = "" ]; then
name=$(echo $valor1 | awk -F "/" '{print $1'})
fi
esquelet="/etc/adm-lite/payloads"
sed -s "s;realData;abc;g" $esquelet > $HOME/$name.txt
sed -i "s;netData;abc;g" $HOME/$name.txt
sed -i "s;raw;abc;g" $HOME/$name.txt
sed -i "s;abc;$in;g" $HOME/$name.txt
sed -i "s;get;$req;g" $HOME/$name.txt
sed -i "s;mhost;$valor1;g" $HOME/$name.txt
sed -i "s;mip;$valor2;g" $HOME/$name.txt
if [ "$(cat $HOME/$name.txt | egrep -o "$valor1")" = "" ]; then
echo -e ""
echo -e "${cor[3]} ALGO ESTA \033[1;36mMAL !!"
rm $HOME/$name.txt
return
fi
echo -e "${cor[3]} GENERACION DE PAYLOAD EXITOSA !!"
echo -e "${cor[3]} DIRECTORIO \033[1;31m$HOME/$name.txt"
return
}

fun_bar () {
comando="$1"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
$comando -y > /dev/null 2>&1
touch $HOME/fim
 ) & > /dev/null
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<=10; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.3s
   done
   [[ -e $HOME/fim ]] && {
   rm $HOME/fim
   break
   }
   echo
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

t_master () {
clear
toolmaster
}

paybrute () {
chmod +x ./paysnd.sh
./paysnd.sh
}

function_17 () {
echo -e "${cor[3]} "${txt[333]}""
read -p " [S/N]: " -e -i n sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
msg -bar  
echo -e "\033[1;36m ${txt[334]}"
sleep 3s
msg -bar  
echo -e "\033[1;36m OK"
sleep 1s
sudo reboot
} 
}

############################
while :
do
start_menu
selection=$(selection_fun 19)
case ${selection} in
0)
break
;;
1)
block_torrent
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
2)
fix_vultr
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
3)
badUDP
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
4)
tcp_BBR
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
5)
fail_ban
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
6)
function_10
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
7)
testing_test
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
8)
online_url
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
9)
criar_pay
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
10)
msg -bar
echo -ne "\033[1;33m HOST: \033[1;37m"; read hostcaptura
echo -ne "\033[1;33m LIMITE DE CAPTURA: \033[1;37m"; read limitecaptura
chmod 777 ./ultrahost
./ultrahost "${hostcaptura}" "${limitecaptura}"
read -p " ¡Enter, para volver!"
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
11)
t_master
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
12)
function_17
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
;;
esac
done
