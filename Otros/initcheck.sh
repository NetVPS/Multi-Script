#!/bin/bash
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
source /etc/adm-lite/cabecalho 
#FUNCION DE SELECCION
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}
chk_ip=${IP}

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

start(){
[[ -e /bin/ejecutar/checkuser.py ]] || wget -q -O /bin/ejecutar/checkuser.py https://www.dropbox.com/s/636hdjb1tw43uws/chekuser.py && chmod +x /bin/ejecutar/checkuser.py
	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title 'DESABILITANDO CHEKUSER'
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verd 'chekuser, se desactivo con exito!'
		enter
		return
	fi

	title 'SELECCIONA UN PERTO'
    while [[ -z "${chekuser}" ]]; do
    	dport=$(shuf -i 82-150 -n 1)
    	chekuser=$(in_opcion -nama "Ingresa un puerto [def = ${dport}]")
    	[ -z "${chekuser}" ] && chekuser=${dport}
    	del 1
		[[ $chekuser = 0 ]] && return
    	if [[ ! $chekuser =~ $numero ]]; then
    		print_center -verm2 'ingresa solo numeros!'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -lt 10 ]]; then
    		print_center -verm2 'ingresa un numero mayor a 10'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -gt 65535 ]]; then
    		print_center -verm2 'ingresa un numero menor a 65535'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $(mportas|grep -w "$chekuser") ]]; then
			print_center -verm2 "Puerto en uso!"
			sleep 2
			del 1
    		unset chekuser
    	fi
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
    enter
    del 2

    print_center -ama 'Instalandon python3-pip'
    if apt install -y python3-pip &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon python3-pip ok'
    else
    	del 1
    	print_center -verm2 'falla al instalar python3-pip\nintente instalar manualmente\n\ncomando manual >> apt install -y python3-pip\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Instalandon flask'
    if pip3 install flask &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon flask ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar flask\nintente instalar manualmente\n\ncomando manual >> pip3 install flask\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Instalandon check'
    if wget -O /usr/bin/check https://www.dropbox.com/s/r2madnleejjqhw1/check.sh &>/dev/null; then
    	chmod +x /usr/bin/check
    	mkdir /etc/rec
    	del 1
    	print_center -verd 'Instalandon check ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar check\nintente instalar manualmente\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Iniciando servicio'

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
    	systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    fi

    rm -rf /etc/systemd/system/chekuser.service

    echo -e "[Unit]
Description=chekuser Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/python3 /bin/ejecutar/checkuser.py $chekuser $date
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
	enter
}

_onli() {


   print_center -ama 'Instalandon check'
    if wget -O /usr/bin/onlineapp https://www.dropbox.com/s/x8wcrnj5gho4d39/onlineapp.sh &>/dev/null; then
    	chmod +x /usr/bin/onlineapp
    	mkdir /etc/rec
    	del 1
    	print_center -verd 'Instalando onlineapp ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar onlineapp\nintente instalar manualmente\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Iniciando servicio'

    if [[ $(systemctl is-active onliuser) = "active" ]]; then
    	systemctl stop onliuser &>/dev/null
    	systemctl disable onliuser &>/dev/null
    fi

    rm -rf /etc/systemd/system/onliuser.service

    echo -e "[Unit]
Description=onliuser Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/onlineapp
Restart=always
RestartSec=15s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/onliuser.service

	systemctl enable onliuser &>/dev/null
	systemctl start onliuser &>/dev/null

	if [[ $(systemctl is-active onliuser) = "active" ]]; then
		title -verd 'Instalacion completa'
		print_center -ama "URL: http://$chk_ip:81/server/online"
	else
		systemctl stop onliuser &>/dev/null
    	systemctl disable onliuser &>/dev/null
    	rm -rf /etc/systemd/system/onliuser.service
		print_center -verm2 'falla al iniciar servicio User Activos'
	fi
	enter
}

mod_port(){
	title 'SELECCIONA UN PERTO'
    while [[ -z "${chekuser}" ]]; do
    	dport=$(shuf -i 82-90 -n 1)
    	chekuser=$(in_opcion -nama "Ingresa un puerto [def = ${dport}]")
    	[ -z "${chekuser}" ] && chekuser=${dport}
    	del 1
    	if [[ ! $chekuser =~ $numero ]]; then
    		print_center -verm2 'ingresa solo numeros!'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -lt 10 ]]; then
    		print_center -verm2 'ingresa un numero mayor a 10'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -gt 65535 ]]; then
    		print_center -verm2 'ingresa un numero menor a 65535'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ ! $(mportas|grep -w "$PORT") ]]; then
			print_center -verm2 "Puerto en uso!"
			sleep 2
			del 1
    		unset chekuser
    	fi
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
	enter
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
	enter

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
    	fecha_data=$(printf '%15s' "$fecha_data")
		port_chek=$(ps x|grep -v grep|grep checkuser.py|awk '{print $7}')
		print_center -ama "URL: http://$chk_ip:$port_chek/checkUser"
		port_chek=$(printf '%8s' "$port_chek")
		msg -bar
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verm2 'DESACTIVAR') $(msg -azu 'CHEKUSER')"
		echo " $(msg -verd '[2]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR PUERTO') $(msg -verd "$port_chek")"
		echo " $(msg -verd '[3]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR FORMATO') $(msg -verd "$fecha_data")"
[[ $(systemctl is-active onliuser) = "active" ]] && echo " $(msg -verd '[4]') $(msg -verm2 '>') $(msg -azu 'DESACTIVAR USER ACTIVOS') $(msg -verd "ON")" ||echo " $(msg -verd '[4]') $(msg -verm2 '>') $(msg -azu 'ACTIVAR ONLINE Usr en APP') $(msg -verd "OFF")"
		num=4
	else
        print_center -verm2 'ADVERTENCIA!!!\nCheckUser PODRIA CONSUMIR RECURSOS \n EN CONEXIONES O METODOS INESTABLES\n RECOMENDABLE ANALIZAR TU METODO PRIMERO'
        msg -bar
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verd 'ACTIVAR') $(msg -azu 'CHEKUSER')"
	fi
	back
	opcion=$(selection_fun $num)
	case $opcion in
		1)start;;
		2)mod_port;;
		3)mod_fdate;;
		4)_onli;;
		0)return 1;;
	esac
}

while [[  $? -eq 0 ]]; do
  menu_chekuser
done

