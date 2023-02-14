#!/bin/bash
#
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)

	verif_ptrs() {
		porta=$1
		PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
		for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
			svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
			[[ "$porta" = "$pton" ]] && {
				echo -e "\n\033[1;31mPUERTO \033[1;33m$porta \033[1;31mOCUPADO POR \033[1;37m$svcs\033[0m"
				sleep 0.5
				return 0
			}
		done
	}

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;31m OPCION : " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

fun_openssh() {
		clear
		echo -e "\E[44;1;37m            OPENSSH             \E[0m\n"
		echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mADICIONAR PORTA\033[1;31m
[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mREMOVER PORTA\033[1;31m
[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
		read resp
		if [[ "$resp" = '1' ]]; then
			clear
			echo -e "\E[44;1;37m         ADICIONAR PORTA AO SSH         \E[0m\n"
			echo -ne "\033[1;32mQUAL PORTA DESEJA ADICIONAR \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 3
				return 0
			}
			verif_ptrs $pt
			echo -e "\n\033[1;32mADICIONANDO PORTA AO SSH\033[0m"
			echo ""
			fun_addpssh() {
				echo "Port $pt" >>/etc/ssh/sshd_config
				service ssh restart
			}
			fun_bar 'fun_addpssh'
			echo -e "\n\033[1;32mPORTA ADICIONADA COM SUCESSO\033[0m"
			sleep 3
			return 0
		elif [[ "$resp" = '2' ]]; then
			clear
			echo -e "\E[41;1;37m         REMOVER PORTA DO SSH         \E[0m"
			echo -e "\n\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mPORTA PADRAO \033[1;37m22 \033[1;33mCUIDADO !\033[0m"
			echo -e "\n\033[1;33mPUERTAS SSH EN USO: \033[1;37m$(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)\n"
			echo -ne "\033[1;32mQUE PUERTO DESEAS REMOVER \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPUERTO INVALIDO!"
				sleep 2
				return 0
			}
			[[ $(grep -wc "$pt" '/etc/ssh/sshd_config') != '0' ]] && {
				echo -e "\n\033[1;32mREMOVENDO PUERTO DE SSH\033[0m"
				echo ""
				fun_delpssh() {
					sed -i "/Port $pt/d" /etc/ssh/sshd_config
					service ssh restart
				}
				fun_bar 'fun_delpssh'
				echo -e "\n\033[1;32mPORTA REMOVIDA COM SUCESSO\033[0m"
				sleep 2
				return 0
			} || {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 2
				return 0
			}
		elif [[ "$resp" = '3' ]]; then
			echo -e "\n\033[1;31mRetornando.."
			sleep 2
			return 0
		else
			echo -e "\n\033[1;31mOpcao invalida!"
			sleep 2
			return 0
		fi
	}


menu_udp () {
_udp=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep "badvpn-ud"|awk '{print $1}')
[[ -z $_udp ]] && v_udp="\e[31m[ OFF ]" || v_udp="\e[32m[ ON ] " 
msg -bar 
echo -e " \033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ➮ ${cor[3]} PARAR TODOS LOS BADVPN $v_udp"
echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮ ${cor[3]} ADD + BADVPN ( CUSTOM PORT )"
#echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮ ${cor[3]} AGREGAR / REMOVER HOST-SQUID"
#echo -e " \033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m ➮ ${cor[3]} DESINSTALAR SQUID"
msg -bar
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar
selection=$(selection_fun 2)
case ${selection} in
0)
return 0
;;
1)
for pid in $(pgrep badvpn-udpgw);do 
kill $pid 
done
return 0
;;
2)
badcustom
return 0
;;
esac
}

badcustom () {
msg -bar
echo -e "BIENVENIDO AL MENU DE CUSTOM PORT "
msg -bar 
read -p " DIJITA TU PUERTO CUSTOM PARA BADVPN :" -e -i "7100" port
echo -e " VERIFICANDO BADVPN "
msg -bar 
screen -dmS badvpn$port /bin/badvpn-udpgw --listen-addr 127.0.0.1:${port} --max-clients 1000 --max-connections-for-client 100 && msg -ama "               BadVPN ACTIVADA CON EXITO"  || msg -ama "                Error al Activar BadVPN" 
msg -bar
#echo -e ""

}

_badfix () {
https://github.com/rudi9999/ADMRufu/raw/main/Utils/badvpn/badvpn-master.zip

}

packobs () {
msg -ama "Buscando Paquetes Obsoletos"
dpkg -l | grep -i ^rc
msg -ama "Limpiando Paquetes Obsoloteos"
dpkg -l |grep -i ^rc | cut -d " " -f 3 | xargs dpkg --purge
sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
msg -ama "Limpieza Completa"
}

############

SCPdir="/etc/adm-lite" 
#SCPfrm="${SCPdir}" && [[ ! -d ${SCPfrm} ]] && exit 
#SCPinst="${SCPdir}"&& [[ ! -d ${SCPinst} ]] && exit 
#declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" [5]="\e[1;36m" )

#LISTA PORTAS
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1:$var2")" ]] || portas+="$var1:$var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
} 

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

fun_apache () {
echo -e "FUNCION DE MENU APACHE MODO BETA"
msg -bar
read -p " INGRESA PUERTO APACHE NUEVO :" nwPP
[[ -z $nwPP ]] && nwPP="81"
msg -bar
echo "ESPERE MIENTRAS COMPLETAMOS EL PROCESO"
fun_bar "apt purge apache2 -y " 
echo "REINSTALANDO Y RECONFIGURANDO"
fun_bar "apt install apache2 -y "
sed -i "s;Listen 80;Listen ${nwPP};g" /etc/apache2/ports.conf
echo "REINICIANDO Y APLICANDO CAMBIOS"
service apache2 restart &>/dev/null 
}

filemanager () {
[[ $(ps x | grep filebrowser | grep -v grep) ]] && {
killall filebrowser &> /dev/null
} || {
[[ -z $(which filebrowser) ]] && curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash &> /dev/null
read -p " INGRESA PUERTO : " webrowser
nohup filebrowser -a $(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1) -b / -p ${webrowser} -r /root/& > /dev/null
msg -bar2 
echo ""
echo -e " SERVICIO ACTIVO EN URL : http://$(wget -qO- ifconfig.me):${webrowser}/"
echo ""
echo -e " ACCEDE CON LAS CREDENCIALES : admin "
echo ""
msg -bar2
}
read -p " PRESIONA ENTER PARA CONTINUAR"
}


if netstat -tnlp |grep 'apache2' &>/dev/null; then 
_apa="\e[32m[ ON ] " 
else 
_apa="\e[31m[ OFF ]" 
fi 
clear&&clear
[[ -e /etc/wireguard/params ]] && _wir="\e[32m[ ON ] " || _wir="\e[31m[ OFF ]" 
[[ $(ps x | grep filebrowser | grep -v grep) ]] && file="\e[32m[ ON ] " || file="\e[31m[ OFF ]" 
msg -bar2
echo -e " \033[7;49;35m =>►► 🐲 FUNCIONES ALTERNS ChumoGH💥VPS 🐲 ◄◄<= \033[0m\033[1;31m"
msg -bar2
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m➮\033[0;33m PUERTO APACHE CUSTOM ${_apa}      "
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m➮\033[0;33m LIMPIAR RAM && PAQUETES ANTIGUOS  "
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m➮\033[0;31m ADD / REMOVE PORTS CUSTOM BADVPN  "
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m➮\033[0;31m ADD / REMOVE PORTS CUSTOM OPENSSH "
echo -e " \033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m➮\033[0;31m TROJAN GO - BETA                  "
echo -e " \033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m➮\033[0;31m CREAR CERTIFICADO CON DOMINIO     "
echo -e " \033[0;35m[\033[0;36m7\033[0;35m] \033[0;34m➮\033[0;31m Modulo WireGuard VPN Client ${_wir}    "
echo -e " \033[0;35m[\033[0;36m8\033[0;35m] \033[0;34m➮\033[0;31m FIILEMANAGER WEB ${file}    "
msg -bar2
echo -e " \033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m➮\033[0;33m $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")  "
msg -bar2
  selection=$(selection_fun 8)
case ${selection} in
0)
return 0
;;
1)
fun_apache
return 0
;;
2)
packobs
return 0
;;
3)
menu_udp
return 0
;;
4)
fun_openssh
return 0
;;
5)
source <(curl -sSL https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADMPLUS-MANAGER-PRO/main/Modulos/trojan-go)
;;
6)
clear&&clear
echo -e "================================================"
echo -e "A CONTINUACION CREAREMOS UN CETIFICADO SSL"
echo -e "   LA VERIFICACION ES MEDIANTE DOMINIO"
echo -e "  NECECITAS TENER EL PUERTO 80 Y 443 LIBRES"
echo -e "================================================"
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh?dl=0)
echo -e "================================================"
echo -e ""
echo -e "================================================"
echo -e " SI LA EMICION FUE CORRECTA, TU CERTIFICADO"
echo -e "        SE ENCUENTR ALOJADO EN /data "
echo -e "================================================"
echo -e "       /data/cert.crt && /data/cert.key "
echo -e "================================================"
echo -e ""
;;
7)
rm -f /tmp/wireguard-install.sh* && wget -q -O /tmp/wireguard-install.sh https://www.dropbox.com/s/zgo0dz65l6v3d7s/wireguard-install.sh && chmod +x /tmp/wireguard-install.sh && /tmp/wireguard-install.sh
;;
8)
filemanager
;;
esac

