#!/bin/bash
l="/usr/local/lib/sped" && [[ ! -d ${l} ]] && exit
clear
clear
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPdir="/etc/VPS-MX"
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${SCPdir}/protocolos"&& [[ ! -d ${SCPinst} ]] && exit

chk_ip=$(wget -qO- ifconfig.me)

mportas(){
	unset portas
	portas_var=$(lsof -V -i -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND")
	while read port; do
		var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
		[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
	done <<< "$portas_var"
	i=1
	echo -e "$portas"
}

title(){
    clear
    msg -bar
    if [[ -z $2 ]]; then
      print_center -azu "$1"
    else
      print_center "$1" "$2"
    fi
    msg -bar
 }
 
back(){
    msg -bar
    echo -ne "$(msg -verd " [0]") $(msg -verm2 ">") " && msg -bra "\033[1;41mVOLVER"
    msg -bar
 }
export numero='^[0-9]+$'
del(){
  for (( i = 0; i < $1; i++ )); do
    tput cuu1 && tput dl1
  done
}
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m$(fun_trans " ► Selecione una Opcion"): " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}
in_opcion(){
  unset opcion
  if [[ -z $2 ]]; then
      msg -azu " $1: " >&2
  else
      msg $1 " $2: " >&2
  fi
  read opcion
  #echo "$opcion"
}
print_center(){
  if [[ -z $2 ]]; then
    text="$1"
  else
    col="$1"
    text="$2"
  fi

  while read line; do
    unset space
    x=$(( ( 54 - ${#line}) / 2))
    for (( i = 0; i < $x; i++ )); do
      space+=' '
    done
    space+="$line"
    if [[ -z $2 ]]; then
      msg -azu "$space"
    else
      msg "$col" "$space"
    fi
  done <<< $(echo -e "$text")
}

menu_func(){
  local options=${#@}
  local array
  for((num=1; num<=$options; num++)); do
    echo -ne "$(msg -verd " [$num]") $(msg -verm2 ">") "
    array=(${!num})
    case ${array[0]} in
      "-vd")echo -e "\033[1;33m[!]\033[1;32m ${array[@]:1}";;
      "-vm")echo -e "\033[1;33m[!]\033[1;31m ${array[@]:1}";;
      "-fi")echo -e "${array[@]:2} ${array[1]}";;
  #    -bar|-bar2|-bar3|-bar4)echo -e "\033[1;37m${array[@]:1}\n$(msg ${array[0]})";;
      *)echo -e "\033[1;37m${array[@]}";;
    esac
  done
 }

start(){
	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		msg -azu "DESABILITANDO CHEKUSER"
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		msg -verd 'chekuser, se desactivo con exito!'
		enter
		return
	fi

	  while true; do
	echo -ne "\033[1;37m"
    read -p " INGRESE UN PUERTO: " chekuser
	echo ""
    [[ $(mportas|grep -w "$chekuser") ]] || break
    echo -e "\033[1;33m Este puerto está en uso"
    unset chekuser
    done
    echo " $(msg -ama "Puerto") $(msg -verd "$chekuser")"
    msg -bar

    print_center 'SELECCIONA UN FORMATO DE FECHA'
    msg -bar
    menu_func 'YYYY/MM/DD' 'DD/MM/YYYY'
    msg -bar
    date=$(selection_fun 2)
    case $date in
    	1)fecha="YYYY/MM/DD";;
    	2)fecha="DD/MM/YYYY";;
    esac
    [[ $date = 0 ]] && return
    del 5
    echo " $(msg -ama "Formato") $(msg -verd "$fecha")"
  #  enter
    del 2

    print_center -ama 'Instalandon python3-pip'
    if apt install -y python3-pip &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon python3-pip ok'
    else
    	del 1
    	print_center -verm2 'falla al instalar python3-pip\nintente instalar manualmente\n\ncomando manual >> apt install -y python3-pip\n\nresuelva esta falla para luego intentar'
   # 	enter
    	return
    fi

    print_center -ama 'Instalandon flask'
    if pip3 install flask &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon flask ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar flask\nintente instalar manualmente\n\ncomando manual >> pip3 install flask\n\nresuelva esta falla para luego intentar'
   # 	enter
    	return
    fi

    print_center -ama 'Iniciando servicio'

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
    	systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    fi

    rm -rf /etc/systemd/system/chekuser.service

    echo -e "[Unit]
Description=chekuser Service by @Rufu99
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/python3 /etc/VPS-MX/protocolos/chekuser.py $chekuser $date
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/chekuser.service

# ExecStart=/usr/bin/python3 ${ADM_inst}/chekuser.py $chekuser $date
# ps x|grep -v grep|grep chekuser.py|awk '{print $7}'

	systemctl enable chekuser &>/dev/null
	systemctl start chekuser &>/dev/null

	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'Instalacion completa'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'falla al iniciar servicio chekuser'
	fi
	#enter
}

mod_port(){
	while true; do
	echo -ne "\033[1;37m"
    read -p " INGRESE UN PUERTO: " chekuser
	echo ""
    [[ $(mportas|grep -w "$chekuser") ]] || break
    echo -e "\033[1;33m Este puerto está en uso"
    unset chekuser
    done
    echo " $(msg -ama "Puerto") $(msg -verd "$chekuser")"
    enter
    port_chek=$(ps x|grep -v grep|grep chekuser.py|awk '{print $7}')
    systemctl stop chekuser &>/dev/null
    systemctl disable chekuser &>/dev/null
    sed -i "s/$port_chek/$chekuser/g" /etc/systemd/system/chekuser.service
    systemctl enable chekuser &>/dev/null
    systemctl start chekuser &>/dev/null

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'puerto modificado'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'algo salio mal\nfalla al iniciar servicio chekuser'
	fi
	#enter
}

mod_fdate(){
	title 'SELECCIONA UN FORMATO DE FECHA'
	menu_func 'YYYY/MM/DD' 'DD/MM/YYYY'
    msg -bar
    date=$(selection_fun 2)
    case $date in
    	1)fecha="YYYY/MM/DD";;
    	2)fecha="DD/MM/YYYY";;
    esac
    [[ $date = 0 ]] && return
    del 3
    echo " $(msg -ama "Formato") $(msg -verd "$fecha")"
    enter
    formato=$(ps x|grep -v grep|grep chekuser.py|awk '{print $8}')
    systemctl stop chekuser &>/dev/null
    systemctl disable chekuser &>/dev/null
    sed -i "s/$formato/$date/g" /etc/systemd/system/chekuser.service
    systemctl enable chekuser &>/dev/null
    systemctl start chekuser &>/dev/null

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'formato de fecha modificado'
		print_center -ama "FORMATO: $fecha"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'algo salio mal\nfalla al iniciar servicio chekuser'
	fi
	#enter

}

menu_chekuser(){
	title 'VERIFICACION DE USUARIOS ONLINE'
	num=1
	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		formato=$(ps x|grep -v grep|grep chekuser.py|awk '{print $8}')
		case $formato in
    		1)fecha_data="YYYY/MM/DD";;
    		2)fecha_data="DD/MM/YYYY";;
    	esac
    msg -tit
    	fecha_data=$(printf '%15s' "$fecha_data")
		port_chek=$(ps x|grep -v grep|grep chekuser.py|awk '{print $7}')
		msg -ama "\e[93mURL: http://$chk_ip:$port_chek/checkUser"
		port_chek=$(printf '%8s' "$port_chek")
	
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verm2 'DESACTIVAR') $(msg -azu 'CHEKUSER')"
		echo " $(msg -verd '[2]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR PUERTO') $(msg -verd "$port_chek")"
		echo " $(msg -verd '[3]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR FORMATO') $(msg -verd "$fecha_data")"
		msg -bar
		num=3
	else
	msg -tit
        print_center -verm2 'ADVERTENCIA!!!\nesto puede generar consumo de ram/cpu\nen metodos de coneccion inestables\nse recomienda no usar chekuser en esos casos'
        msg -bar
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verd 'ACTIVAR') $(msg -azu 'CHEKUSER')"
		msg -bar
	fi
	back
	opcion=$(selection_fun $num)
	case $opcion in
		1)start;;
		2)mod_port;;
		3)mod_fdate;;
		0)return 1;;
	esac
}

while [[  $? -eq 0 ]]; do
  menu_chekuser
done

