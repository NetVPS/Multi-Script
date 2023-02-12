#!/bin/bash
ll="/usr/local/include/snaps" && [[ ! -d ${ll} ]] && exit
l="/usr/local/lib/sped" && [[ ! -d ${l} ]] && exit
clear
clear
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPdir="/etc/VPS-MX"
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${SCPdir}/protocolos"&& [[ ! -d ${SCPinst} ]] && exit

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

installarm(){
clear
if [[ ! -e /bin/badvpn-udpgw ]]; then
msg -ama "	INICIANDO DESCARGA BADVPN ARM TEST"
[[ -e /bin/badvpn-udpgw ]] && rm -f /bin/badvpn-udpgw 
[[ -e /bin/badvpn ]] && rm -f /bin/badvpn
[[ -e /usr/local/bin/badvpn-udpgw ]] && rm -f /usr/local/bin/badvpn-udpgw
rm -rf $HOME/badvpn*
apt-get install -y gcc &>/dev/null # 2>/dev/null
apt-get install -y make &>/dev/null #2>/dev/null
apt-get install -y g++ &>/dev/null #2>/dev/null
apt-get install -y openssl &>/dev/null #2>/dev/null
apt-get install -y build-essential &>/dev/null #2>/dev/null
if apt-get install -y cmake &>/dev/null; then
 msg -verd "	CMAKE INSTALADO"
 else
 msg -verm2 "	FALLÓ"
 return
 fi
cd $HOME
if wget https://github.com/lacasitamx/SCRIPTMOD-LACASITA/raw/master/test/badvpn-master.zip &>/dev/null; then
msg -ama "	DESCARGA CORRECTA"
else
msg -verm2 "	DESCARGA FALLIDA"
return
fi

if unzip badvpn-master.zip &>/dev/null; then
msg -verd "	Descomprimiendo archivo"
else
msg -verm2 "	La descomprecion ha fallado"
return
fi

cd badvpn-master
mkdir build
cd build
if cmake .. -DCMAKE_INSTALL_PREFIX="/" -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 &>/dev/null && make install &>/dev/null; then
msg -verd "	Cmake con exito"
else
msg -verm2 "	Cmake Fallido"
return
fi
cd $HOME
rm -rf badvpn-master.zip
#arm
sleep 1s
clear
msg -ama " ACTIVANDO BADVPN 7300"
echo -e "[Unit]
Description=BadVPN UDPGW Service
After=network.target\n
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$(which badvpn-udpgw)  --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
Restart=always
RestartSec=3s\n
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/badvpn.service

    systemctl enable badvpn &>/dev/null
    systemctl start badvpn &>/dev/null
    systemctl daemon-reload &>/dev/null
   # $(which badvpn) "start"
 #   badvpn start
    activado
else
msg -verm2 "	DETENIENDO BADVPN"
    msg -bar
    systemctl stop badvpn &>/dev/null
    systemctl disable badvpn &>/dev/null
    rm /etc/systemd/system/badvpn.service
  #  rm /usr/bin/badvpn-udpgw &>/dev/null
    [[ -e /bin/badvpn-udpgw ]] && rm -f /bin/badvpn-udpgw 
	[[ -e /bin/badvpn ]] && rm -f /bin/badvpn
	[[ -e /usr/local/bin/badvpn-udpgw ]] && rm -f /usr/local/bin/badvpn-udpgw
	rm -rf $HOME/badvpn*
	systemctl daemon-reload &>/dev/null
    msg -verm " BADVPN DESACTIVADO"
    fi
}
unistall(){
msg -bar 
	msg -tit
    msg -ama "          DESACTIVADOR DE BADVPN (UDP)"
    msg -bar
    
    systemctl stop badvpn &>/dev/null
    systemctl disable badvpn &>/dev/null
    rm -rf /etc/systemd/system/badvpn.service 
    screen -r -S "badvpn" -X quit
        screen -wipe 1>/dev/null 2>/dev/null
        [[ $(grep -wc "badvpn" /etc/autostart) != '0' ]] && {
		    sed -i '/badvpn/d' /etc/autostart
		}
    rm -rf $HOME/badvpn*
    kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
    killall badvpn-udpgw > /dev/null 2>&1
    rm -rf /bin/badvpn-udpgw
    [[ ! "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -ne "                DESACTIVADO CON EXITO \n"
    unset pid_badvpn
	msg -bar
	}
	
activado (){
msg -bar
    #puerto local  
    [[ "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -verd "                  ACTIVADO CON EXITO" || msg -ama "                 Falló"
	msg -bar
	}
	
BadVPN () {
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')

clear
msg -tit
    msg -ama "  \e[1;43m\e[91mACTIVADOR DE BADVPN (7100-7200-7300-Multi Port)\e[0m"
    msg -bar
echo -e "$(msg -verd "[1]")$(msg -verm2 "➛ ")$(msg -azu "ACTIVAR BADVPN 7300") \e[92m(System)"
echo -e "$(msg -verd "[2]")$(msg -verm2 "➛ ")$(msg -azu "ACTIVAR BADVPN 7300") \e[92m(Screen Directo)"
echo -e "$(msg -verd "[3]")$(msg -verm2 "➛ ")$(msg -azu "AGREGAR +PORT BADVPN ")"
echo -e "$(msg -verd "[4]")$(msg -verm2 "➛ ")$(msg -azu "APLICAR FIX CMAKE")"
echo -e "$(msg -verd "[5]")$(msg -verm2 "➛ ")$(msg -azu "DETENER SERVICIO BADVPN")"
echo -e "$(msg -verd "[0]")$(msg -verm2 "➛ ")$(msg -azu "VOLVER")"
msg -bar
read -p "Digite una opción (default 2): " -e -i 2 portasx
#tput cuu1 && tput dl1
if [[ ${portasx} = 1 ]]; then
if [[ -z $pid_badvpn ]]; then
msg -ama "	DESCARGANDO PAQUETES....."
apt install wget -y &>/dev/null
apt-get install -y gcc &>/dev/null # 2>/dev/null
apt-get install -y make &>/dev/null #2>/dev/null
apt-get install -y g++ &>/dev/null #2>/dev/null
apt-get install -y openssl &>/dev/null #2>/dev/null
apt-get install -y build-essential &>/dev/null #2>/dev/null
if apt-get install cmake -y &>/dev/null; then
msg -verd "	CMAKE INSTALADO"
 else
 msg -verm2 "	FALLÓ"
 return
 fi

cd $HOME
if wget https://github.com/lacasitamx/SCRIPTMOD-LACASITA/raw/master/test/badvpn-master.zip &>/dev/null; then
msg -verd "	DESCARGA CORRECTA"
else
msg -verm2 "	DESCARGA FALLIDA"
return
fi

if unzip badvpn-master.zip &>/dev/null; then
msg -verd "	Descomprimiendo archivo"
else
msg -verm2 "	La descomprecion ha fallado"
return
fi

cd badvpn-master
mkdir build
cd build
if cmake .. -DCMAKE_INSTALL_PREFIX="/" -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 &>/dev/null && make install &>/dev/null; then
msg -verd "	Cmake con exito"
else
msg -verm2 "	Cmake Fallido"
return
fi
cd $HOME
rm -rf badvpn-master.zip
#rm -rf badvpn*
#arm
sleep 1s
clear
echo -e "[Unit]
Description=BadVPN UDPGW Service
After=network.target\n
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$(which badvpn-udpgw)  --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
Restart=always
RestartSec=3s\n
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/badvpn.service

    systemctl enable badvpn &>/dev/null
    systemctl start badvpn &>/dev/null
    systemctl daemon-reload &>/dev/null
activado
else
systemctl stop badvpn &>/dev/null
    systemctl disable badvpn &>/dev/null
    rm -rf /etc/systemd/system/badvpn.service 
    msg -ne "                7300 DESACTIVADO CON EXITO \n"
fi
elif [[ ${portasx} = 2 ]]; then
if [[ -z $pid_badvpn ]]; then
if [[ ! -e /bin/badvpn-udpgw ]]; then
    wget -O /bin/badvpn-udpgw https://raw.githubusercontent.com/lacasitamx/VPSMX/master/ArchivosUtilitarios/badvpn-udpgw &>/dev/null
    chmod 777 /bin/badvpn-udpgw
   fi
screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 10000 --max-connections-for-client 10
        [[ $(grep -wc "badvpn" /etc/autostart) = '0' ]] && {
		    echo -e "ps x | grep 'badvpn' | grep -v 'grep' || screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 10000 --max-connections-for-client 10 --client-socket-sndbuf 10000" >> /etc/autostart
		} || {
		    sed -i '/udpvpn/d' /etc/autostart
		    echo -e "ps x | grep 'badvpn' | grep -v 'grep' || screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 10000 --max-connections-for-client 10 --client-socket-sndbuf 10000" >> /etc/autostart
		}
		activado
		else
		unistall
		fi
   elif [[ ${portasx} = 3 ]]; then
if [[ ! -e /bin/badvpn-udpgw ]]; then
    wget -O /bin/badvpn-udpgw https://raw.githubusercontent.com/lacasitamx/VPSMX/master/ArchivosUtilitarios/badvpn-udpgw &>/dev/null
    chmod 777 /bin/badvpn-udpgw
   fi
   read -p " Digite El Puerto Para Badvpn: " ud
screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:$ud --max-clients 10000 --max-connections-for-client 10
echo -e "ps x | grep 'badvpn' | grep -v 'grep' || screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:$ud --max-clients 10000 --max-connections-for-client 10 --client-socket-sndbuf 10000" >> /etc/autostart
activado

	elif [[ ${portasx} = 4 ]]; then
	wget https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz
	tar xf cmake-3.8.2.tar.gz &>/dev/null
	cd cmake-3.8.2
	./configure &>/dev/null
	sudo make install &>/dev/null
	cd $HOME
if wget https://github.com/lacasitamx/SCRIPTMOD-LACASITA/raw/master/test/badvpn-master.zip &>/dev/null; then
msg -verd "	DESCARGA CORRECTA"
else
msg -verm2 "	DESCARGA FALLIDA"
return
fi

if unzip badvpn-master.zip &>/dev/null; then
msg -verd "	Descomprimiendo archivo"
else
msg -verm2 "	La descomprecion ha fallado"
return
fi

cd badvpn-master
mkdir build
cd build
if cmake .. -DCMAKE_INSTALL_PREFIX="/" -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 &>/dev/null && make install &>/dev/null; then
msg -verd "	Cmake con exito"
else
msg -verm2 "	Cmake Fallido"
return
fi
cd $HOME
rm -rf badvpn-master.zip
#rm -rf badvpn*
#arm
sleep 1s
clear
echo -e "[Unit]
Description=BadVPN UDPGW Service
After=network.target\n
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$(which badvpn-udpgw)  --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
Restart=always
RestartSec=3s\n
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/badvpn.service

    systemctl enable badvpn &>/dev/null
    systemctl start badvpn &>/dev/null
    systemctl daemon-reload &>/dev/null
activado
unset pid_badvpn
elif [[ ${portasx} = 5 ]]; then
	unistall
   elif [[ ${portasx} = 0 ]]; then
   msg -verm "	SALIENDO"
   exit
   fi
  


}
BadVPN