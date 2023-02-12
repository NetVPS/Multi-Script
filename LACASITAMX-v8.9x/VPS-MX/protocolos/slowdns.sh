#!/bin/bash
ll="/usr/local/include/snaps" && [[ ! -d ${ll} ]] && exit
l="/usr/local/lib/sped" && [[ ! -d ${l} ]] && exit
#by @rufu99
[[ ! -d /etc/VPS-MX ]] && exit
[[ ! -d /etc/VPS-MX/protocolos ]] && exit
ADM_inst="/etc/VPS-MX/Slow/install" && [[ ! -d ${ADM_inst} ]] && exit
ADM_slow="/etc/VPS-MX/Slow/Key" && [[ ! -d ${ADM_slow} ]] && exit
info(){
	clear
	nodata(){
		msg -bar
		msg -ama "!SIN INFORMACION SLOWDNS!"
		exit 0
	}

	if [[ -e  ${ADM_slow}/domain_ns ]]; then
		ns=$(cat ${ADM_slow}/domain_ns)
		if [[ -z "$ns" ]]; then
			nodata
			exit 0
		fi
	else
		nodata
		exit 0
	fi

	if [[ -e ${ADM_slow}/server.pub ]]; then
		key=$(cat ${ADM_slow}/server.pub)
		if [[ -z "$key" ]]; then
			nodata
			exit 0
		fi
	else
		nodata
		exit 0
	fi

	msg -bar
	msg -ama "DATOS DE SU CONEXION SLOWDNS"
	msg -bar
	msg -ama "Su NS (Nameserver): $(cat ${ADM_slow}/domain_ns)"
	msg -bar
	msg -ama "Su Llave: $(cat ${ADM_slow}/server.pub)"
	
	exit 0
}

drop_port(){
    local portasVAR=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
    local NOREPEAT
    local reQ
    local Port
    unset DPB
    while read port; do
        reQ=$(echo ${port}|awk '{print $1}')
        Port=$(echo {$port} | awk '{print $9}' | awk -F ":" '{print $2}')
        [[ $(echo -e $NOREPEAT|grep -w "$Port") ]] && continue
        NOREPEAT+="$Port\n"

        case ${reQ} in
        	sshd|dropbear|trojan|stunnel4|stunnel|python|python3|v2ray|xray)DPB+=" $reQ:$Port";;
            *)continue;;
        esac
    done <<< "${portasVAR}"
 }

ini_slow(){
clear
msg -bar
	msg -ama "	INSTALADOR SLOWDNS"
	msg -bar
	echo ""
	drop_port
	n=1
    for i in $DPB; do
        proto=$(echo $i|awk -F ":" '{print $1}')
        proto2=$(printf '%-12s' "$proto")
        port=$(echo $i|awk -F ":" '{print $2}')
        echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -ama "$proto2")$(msg -azu "$port")"
        drop[$n]=$port
        dPROT[$n]=$proto2
        num_opc="$n"
        let n++ 
    done
    msg -bar
    opc=$(selection_fun $num_opc)
    echo "${drop[$opc]}" > ${ADM_slow}/puerto
    echo "${dPROT[$opc]}" >${ADM_slow}/puertoloc
    PORT=$(cat ${ADM_slow}/puerto)
    clear
    msg -bar
    msg -ama "	INSTALADOR SLOWDNS"
    msg -bar
    echo ""
    echo -e " $(msg -ama "Puerto de conexion atraves de SlowDNS:") $(msg -verd "$PORT")"
    msg -bar

    unset NS
    while [[ -z $NS ]]; do
    	msg -ama " Tu dominio NS: "
    	read NS
    	tput cuu1 && tput dl1
    done
    echo "$NS" > ${ADM_slow}/domain_ns
    echo -e " $(msg -ama "Tu dominio NS:") $(msg -verd "$NS")"
    msg -bar

    if [[ ! -e ${ADM_inst}/dns-server ]]; then
    	msg -ama " Descargando binario...."
    	if wget -O ${ADM_inst}/dns-server raw.github.com/lacasitamx/SCRIPTMOD-LACASITA/master/SLOWDNS/dns-server &>/dev/null ; then
    		chmod +x ${ADM_inst}/dns-server
    		msg -verd " DESCARGA CON EXITO"
    	else
    		msg -verm " DESCARGA FALLIDA"
    		msg -bar
    		msg -ama "No se pudo descargar el binario"
    		msg -verm "Instalacion cancelada"
    		
    		exit 0
    	fi
    	msg -bar
    fi

    [[ -e "${ADM_slow}/server.pub" ]] && pub=$(cat ${ADM_slow}/server.pub)

    if [[ ! -z "$pub" ]]; then
    	msg -ama " Usar La clave existente [S/N] ?: "
    	read ex_key

    	case $ex_key in
    		s|S|y|Y) tput cuu1 && tput dl1
    			 echo -e " $(msg -ama "Tu clave:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")";;
    		n|N) tput cuu1 && tput dl1
    			 rm -rf ${ADM_slow}/server.key
    			 rm -rf ${ADM_slow}/server.pub
    			 ${ADM_inst}/dns-server -gen-key -privkey-file ${ADM_slow}/server.key -pubkey-file ${ADM_slow}/server.pub &>/dev/null
    			 echo -e " $(msg -ama "Tu clave:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")";;
    		*);;
    	esac
    else
    	rm -rf ${ADM_slow}/server.key
    	rm -rf ${ADM_slow}/server.pub
    	${ADM_inst}/dns-server -gen-key -privkey-file ${ADM_slow}/server.key -pubkey-file ${ADM_slow}/server.pub &>/dev/null
    	echo -e " $(msg -ama "Tu clave:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")"
    fi
    msg -bar
    msg -ama "    INSTALANDO SERVICIO 𝙎𝙇𝙊𝙒𝘿𝙉𝙎   ..." |pv -q 30
    apt install ncurses-utils -y &>/dev/null
    
	apt install iptables -y &>/dev/null
	#iptables -F >/dev/null 2>&1
   iptables -I INPUT -p udp --dport 5300 -j ACCEPT
    iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
    echo "nameserver 1.1.1.1 " >/etc/resolv.conf
    echo "nameserver 1.0.0.1 " >>/etc/resolv.conf
    
    screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT
    [[ $(grep -wc "slowdns" /etc/autostart) = '0' ]] && {
						echo -e "netstat -au | grep -w 7300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/etc/autostart
					} || {
						sed -i '/slowdns/d' /etc/autostart
						echo -e "netstat -au | grep -w 7300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/etc/autostart
					}
    	msg -verd " INSTALACION CON EXITO"
    
    exit 0
}

reset_slow(){
	clear
	msg -bar
	msg -verd "    Reiniciando 𝙎𝙇𝙊𝙒𝘿𝙉𝙎...."
	screen -ls | grep slowdns | cut -d. -f1 | awk '{print $1}' | xargs kill
	NS=$(cat ${ADM_slow}/domain_ns)
	PORT=$(cat ${ADM_slow}/puerto)
	screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file /root/server.key $NS 127.0.0.1:$PORT
	[[ $(grep -wc "slowdns" /etc/autostart) = '0' ]] && {
						echo -e "netstat -au | grep -w 7300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/etc/autostart
					} || {
						sed -i '/slowdns/d' /etc/autostart
						echo -e "netstat -au | grep -w 7300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/etc/autostart
					}
		msg -verd " SERVICIO SLOW REINICIADO"
	
	exit 0
}
stop_slow(){
	clear
	msg -bar
	msg -ama "    Deteniendo SlowDNS...."
	if screen -ls | grep slowdns | cut -d. -f1 | awk '{print $1}' | xargs kill ; then
	for pidslow in $(screen -ls | grep ".slowdns" | awk {'print $1'}); do
						screen -r -S "$pidslow" -X quit
			done
			[[ $(grep -wc "dns-server" /etc/autostart) != '0' ]] && {
						sed -i '/dns-server/d' /etc/autostart
			}
  screen -wipe >/dev/null
		msg -verd " SERVICIO SLOW DETENIDO!!"
		rm ${ADM_inst}/dns-server &>/dev/null
		rm -rf ${ADM_slow}/* &>/dev/null
	else
		msg -verm " SERVICIO SLOW NO DETENIDO!"
	fi
	exit 0
}
portdns(){
  proto="dns-serve"
  portas=$(lsof -V -i -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND")
  for list in $proto; do
    case $list in
      dns-serve)
      portas2=$(echo $portas|grep -w "$list")
      [[ $(echo "${portas2}"|grep "$list") ]] && inst[$list]="\033[1;33m[\e[1;92mActivo\e[33m] " || inst[$list]="\033[1;33m[\e[1;91mDesactivado\e[1;33m]";;
    esac
  done
  }
while :
do
	clear
	portdns
	if [[ -e ${ADM_slow}/puertoloc ]]; then LOC=$((cat ${ADM_slow}/puertoloc)|cut -d' ' -f1); else LOC="XX"; fi
	if [[ -e ${ADM_slow}/puerto ]]; then PT=$((cat ${ADM_slow}/puerto)|cut -d' ' -f1); else PT="XX"; fi
	msg -bar
	msg -ama "	\e[91m\e[43mMENÚ DE INSTALACION 𝙎𝙇𝙊𝙒𝘿𝙉𝙎   \e[0m"
	echo ""
	#if [[ -e ${ADM_inst}/dns-server ]]; then
	echo -e "     \e[91mSlowDNS\e[93m + \e[92m${LOC} \e[97m»» \e[91m${PT} \e[1;97mSERVICIO: ${inst[dns-serv]}\e[0m"
	#else
	#echo -e "	\e[1;97mSERVICIO: ${inst[dns-serv]}"
	#fi
	
	msg -bar
	
	echo -e "  $(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "INSTALAR 𝙎𝙇𝙊𝙒𝘿𝙉𝙎  ")"
	echo -e "  $(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "REINICIAR 𝙎𝙇𝙊𝙒𝘿𝙉𝙎  ")"
	echo -e "  $(msg -verd "[3]")$(msg -verm2 "➛ ")$(msg -azu "DETENER 𝙎𝙇𝙊𝙒𝘿𝙉𝙎  ")"
	echo -e "  $(msg -verd "[4]")$(msg -verm2 "➛ ")$(msg -azu "DATOS DE LA CUENTA")"
	echo -e "  $(msg -verd "[0]")$(msg -verm2 "➛ ")$(msg -azu "VOLVER")"
	msg -bar
	echo -ne "  \033[1;37mSelecione Una Opcion : "
read opc
case $opc in
		1)ini_slow;;
		2)reset_slow;;
		3)stop_slow;;
		4)info;;
		0)exit;;
	esac
done
