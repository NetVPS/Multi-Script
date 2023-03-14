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
    echo -ne "$(msg -verd " [0]") $(msg -verm2 ">") " && msg -bra "\033[1;41mRETURN"
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
echo -ne "\033[1;37m$(fun_trans " ► Select an Option"): " >&2
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
		msg -azu "DISABLE CHEKUSER"
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		msg -verd 'chekuser, deactivated successfully!'
		enter
		return
	fi

	  while true; do
	echo -ne "\033[1;37m"
    read -p " ENTER A PORT: " chekuser
	echo ""
    [[ $(mportas|grep -w "$chekuser") ]] || break
    echo -e "\033[1;33m This port is in use"
    unset chekuser
    done
    echo " $(msg -ama "Puerto") $(msg -verd "$chekuser")"
    msg -bar

    print_center 'SELECT A DATE FORMAT'
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
    echo " $(msg -ama "Format") $(msg -verd "$fecha")"
  #  enter
    del 2

    print_center -ama 'Instalandon python3-pip'
    if apt install -y python3-pip &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon python3-pip ok'
    else
    	del 1
    	print_center -verm2 'fails to install python3-pip\ntry to install manually\n\nmanual command >> apt install -y python3-pip\n\nresolve this failure and then try'
   # 	enter
    	return
    fi

    print_center -ama 'Instalandon flask'
    if pip3 install flask &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon flask ok'
    else
    	del 1
    	print_center -verm2 '\nfail to install flask\ntry to install manually\n\nmanual command >> pip3 install flask\n\nresolve this failure and then try'
   # 	enter
    	return
    fi

    print_center -ama 'starting service'

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
		title -verd 'Installation complete'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'fail to start chekuser service'
	fi
	#enter
}

mod_port(){
	while true; do
	echo -ne "\033[1;37m"
    read -p " ENTER A PORT: " chekuser
	echo ""
    [[ $(mportas|grep -w "$chekuser") ]] || break
    echo -e "\033[1;33m This port is in use"
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
		title -verd 'modified port'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'algo salio mal\nfail to start chekuser service'
	fi
	#enter
}

mod_fdate(){
	title 'SELECT A DATE FORMAT'
	menu_func 'YYYY/MM/DD' 'DD/MM/YYYY'
    msg -bar
    date=$(selection_fun 2)
    case $date in
    	1)fecha="YYYY/MM/DD";;
    	2)fecha="DD/MM/YYYY";;
    esac
    [[ $date = 0 ]] && return
    del 3
    echo " $(msg -ama "Format") $(msg -verd "$fecha")"
    enter
    formato=$(ps x|grep -v grep|grep chekuser.py|awk '{print $8}')
    systemctl stop chekuser &>/dev/null
    systemctl disable chekuser &>/dev/null
    sed -i "s/$formato/$date/g" /etc/systemd/system/chekuser.service
    systemctl enable chekuser &>/dev/null
    systemctl start chekuser &>/dev/null

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'modified date format'
		print_center -ama "FORMAT: $fecha"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'something went wrong\nfailed to start chekuser service'
	fi
	#enter

}

menu_chekuser(){
	title 'ONLINE USER VERIFICATION'
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
	
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verm2 'DEACTIVATE') $(msg -azu 'CHEKUSER')"
		echo " $(msg -verd '[2]') $(msg -verm2 '>') $(msg -azu 'MODIFY PORT') $(msg -verd "$port_chek")"
		echo " $(msg -verd '[3]') $(msg -verm2 '>') $(msg -azu 'MODIFY FORMAT') $(msg -verd "$fecha_data")"
		msg -bar
		num=3
	else
	msg -tit
        print_center -verm2 'WARNING!!!\nThis can generate ram/cpu consumption\nin unstable connection methods\nit is recommended not to use chekuser in such cases'
        msg -bar
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verd 'ACTIVATE') $(msg -azu 'CHEKUSER')"
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

