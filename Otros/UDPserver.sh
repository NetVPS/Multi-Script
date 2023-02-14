#!/bin/bash  
clear  
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg) > /dev/null

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m ► Selecione una Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

download_udpServer(){
	msg -nama '        Descargando binario UDPserver ----'
	if wget -O /usr/bin/udpServer 'https://bitbucket.org/iopmx/udprequestserver/downloads/udpServer' &>/dev/null ; then
		chmod +x /usr/bin/udpServer
		msg -verd 'OK'
	else
		msg -verm2 'fail'
		rm -rf /usr/bin/udpServer*
	fi
make_service
}

make_service(){
	ip_nat=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n 1p)
	interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	ip_publica=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")

	#ip_nat=$(fun_ip nat)
	#interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	#ip_publica=$(fun_ip)
	msg -nama '        Ejecutando servicio UDPserver .....'
	if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system &>/dev/null ; then
		msg -verd 'OK'
	else
		msg -verm2 'fail'
	fi
}

 
  reset_slow(){
  clear
  msg -bar
  msg -ama "        Reiniciando UDPserver...."
  screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill
  if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system ;then
  msg -verd "        Con exito!!!"    
  msg -bar
  else    
  msg -verm "        Con fallo!!!"    
  msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }  
  
  stop_slow(){
  clear
  msg -bar
  msg -ama "        Deteniendo UDPserver...."
  if screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill ; then
  msg -verd "         Con exito!!!"   msg -bar
  else
  msg -verm "        Con fallo!!!"    msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }    
  
  remove() {
  stop_slow
  rm -f /usr/bin/udpServer*
  }
  
while : 
do
  [[ $(ps x | grep udpServer| grep -v grep) ]] && _pid="\033[1;32mON" || _pid="\033[1;37mOFF"
  tittle
  msg -ama "         BINARIO OFICIAL DE NewToolWorks"
  msg -bar
  msg -ama "         INSTALADOR UDPserver | @ChumoGH•Plus"
  msg -bar
  menu_func "Instalar UDPserver $_pid" "$(msg -ama "Reiniciar SlowDns")" "$(msg -verm2 "Detener UDPserver")" "$(msg -verm2 "Remover UDPserver")"
  msg -bar
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar
  opcion=$(selection_fun 5)  
  case $opcion in
  1)download_udpServer;;
  2)reset_slow;;
  3)stop_slow;;
  4)remove;;
  0)exit;;
  esac  
done
