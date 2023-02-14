#!/bin/bash
blanco='\033[38;5;231m'
amarillo='\033[38;5;228m'
azul='\033[38;5;14m'
morado='\033[38;5;147m'
rojo='\033[0;31m'
verde='\033[38;5;148m'
yellow='\033[0;33m'
rosa='\033[38;5;213m'
melon='\033[38;5;208m'
guinda='\033[38;5;161m'
cierre='\033[0m'
bar1="\e[1;30m◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚\e[0m"
bar2="\033[38;5;183m--------------------------------------------------------------------\033[0m"
#DIRECTORIOS
dir_bases="/etc/default"
dir_puertos="/etc/default/ports-sslh"
dir_conf="/etc/default/sslh"
dir_ports="/etc/default/sslh-ports"
dir_service="/etc/init.d/sslh"
dir_info="/etc/default/sslh-info"
#VARIABLES
arch_serv="/root/servicios.txts"
plantilla_service="--anyprot 127.0.0.1:000"
#DIRECTORIOS mkdir-touch
dir_base(){
if [ -f $dir_ports ]; then
	    echo
	    else
	     touch $dir_ports
		 chmod 777 $dir_ports
fi
if [ -d $dir_bases/ports-sslh ]; then
	    echo
	    else
	    mkdir $dir_bases/ports-sslh
fi
if [ -f $dir_info ]; then
	    echo
	    else
	     touch $dir_info
		 chmod 777 $dir_info
fi
}
back_menu(){
     echo -e "$bar1"
     read -p "$(echo -e "${morado}Enter Para Continuar${cierre}")" enter
     source <(curl -sSL https://www.dropbox.com/s/m3qm4ekjbf2fg5m/sslh-back3.sh)
}
t_port () {
t_node=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port_t; do
test1=$(echo $port_t | awk '{print $1}') && test2=$(echo $port_t | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $nodet|grep "$test1 $test2")" ]] || nodet+="$test1 $test2\n"
done <<< "$t_node"
i=1
echo -e "$nodet"
}
#REGLAS SSLH
reglas_sslh () {
[[ -e "/etc/stunnel/stunnel.conf" ]] && ptssl="$(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)" || ptssl='444'
[[ -e "/etc/openvpn/server.conf" ]] && ptvpn="$(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)" || ptvpn='460'
[[ -e "/etc/default/dropbear" ]] && ptfrop="$(netstat -nplt | grep 'dropbear' | awk {'print $4'} | cut -d: -f2 | xargs)" || ptfrop='143'
DEBIAN_FRONTEND=noninteractive apt-get -y install sslh 1> /dev/null 2> /dev/null
echo -e " Ingresa Un puerto Libre, Para activar SSLH\n"
read -p " Ingresa Puerto SSLH : " psshl
echo -e "#Modo autónomo\n\nRUN=yes\n\nDAEMON=/usr/sbin/sslh\n\nDAEMON_OPTS='--user sslh --listen 0.0.0.0:$psshl --ssh 127.0.0.1:22 --ssl 127.0.0.1:$ptssl --http 127.0.0.1:$ptfrop --openvpn 127.0.0.1:$ptvpn --pidfile /var/run/sslh/sslh.pid'" > /etc/default/sslh
## echo -e "#Modo autónomo\n\nRUN=yes\n\nDAEMON=/usr/sbin/sslh\n\nDAEMON_OPTS='--user sslh --listen 0.0.0.0:3128 --ssh  0.0.0.0:22 --ssl  0.0.0.0:$ptssl --http  0.0.0.0:80 --openvpn 127.0.0.1:$ptvpn --pidfile /var/run/sslh/sslh.pid'" >/etc/default/sslh 
/etc/init.d/sslh start && service sslh start
}
msg(){
    echo -e "$bar1"
    echo -e "${blanco}#######################################################${cierre}"
    echo -e "${blanco}# ❗️ Protocolos reconocidos ${azul}ssl, https, openvpn,      ${blanco}# ${cierre}"
    echo -e "${blanco}# ❗️ ${azul}Openconnect, http, sslh; ssh,${cierre} ${blanco}si su servicio es  ${blanco}# ${cierre}"
    echo -e "${blanco}# ❗️ Diferente porfavor en nombre establezca ${guinda}anyprot  ${blanco}# ${cierre}"
    echo -e "${blanco}#   -----------------------------------------------   #${cierre}"
    echo -e "${blanco}#     ${amarillo} SCRIPT Modo Beta, Creditos a @ChumoGH      ${blanco}#${cierre}"
    echo -e "${blanco}#   ${melon}-----------------------------------------------   ${blanco}#${cierre}"
    echo -e "${blanco}#     dev: ${verde}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       ${blanco}#${cierre}"
    echo -e "${blanco}#######################################################${cierre}"
    echo -e "$bar1"
    echo ""
}
capturar_servicio(){
    echo -e "${azul}Escriba el nombre de servicio que de desea agregar${cierre}"
    echo -e "$bar2"
    read -p "$(echo -e "${amarillo}ingrese: ${cierre}")" -e -i anyprot service
}
capturar_puerto(){
    echo -e "$bar2"
    echo -e "${blanco}Escriba el numero de PUERTO${cierre}"
    echo -e "$bar1"
    read -p "$(echo -e "${amarillo}ingrese: ${cierre}")" puerto_i
    if [[ $(t_port| grep "$puerto_i") ]]; then
    echo
    else
    echo -e "$bar1"
    echo -e "${guinda}⚠️ EL Puerto ${blanco} ${puerto_i} ${guinda}No existe ${cierre}"
    echo -e "${guinda}⚠️ Utilice puertos existentes ${cierre}"
    echo -e "$bar1"
    capturar_puerto
    fi
    if [ -f $dir_puertos/$puerto_i ]; then 
        echo -e "$bar2"
                echo -e "${guinda}⚠️ EL Puerto ${blanco} ${puerto_i} ${guinda}Ya se encuentra en USO ${cierre}"
                echo -e "${guinda}⚠️ Intente con otro puerto ${cierre}"
        capturar_puerto
    else
        echo -e "$bar2"
        echo -e "${blanco}REGISTRO EXITOSO !! ${cierre}"
        echo -e "$bar2"
    fi
    touch $dir_puertos/$puerto_i
}
instalar_sslh(){
    dir_base
    reglas_sslh
    if [ $? -eq 0 ]; then
    echo -e "$bar2"
    echo -e "${blanco}INICIO EXITOSO!! , ACTUALMETE ESTA HABILITADO EL SERVICIO OPENSSH ${cierre}"
    echo -e "${blanco}AGREGUE MAS SERVICIO EN EL MENU ${melon}SSLH - MULTIPLEXOR ${cierre}"
    service sslh start
    echo -e "$bar2"
    else
    echo -e "$bar2"
    echo -e "${rojo}⚠️ ERROR INESPERADO, POR FAVOR REVISE SUS SERVICIOS${cierre}"
    echo -e "${rojo}⚠️ Y VUELVA A INTERNTARLO ${cierre}"
    echo -e "$bar2"
    service sslh start
    fi
    back_menu
}
agregar_servicos(){
    echo -e "$bar1"
    capturar_servicio
    capturar_puerto
    sed -i "s;anyprot;${service};g" $dir_conf
    sed -i "s;000;$puerto_i $plantilla_service;g" $dir_conf
    if [ $? -eq 0 ]; then
    echo -e "${blanco}SERVICIO  ${verde}${service_f}${cierre} ${blanco}AGREGADO CON EXITO ${cierre}"
    echo -e "${blanco}AGREGUE MAS SERVICIO EN EL MENU ${melon}SSLH - MULTIPLEXOR ${cierre}"
    service sslh start
    else
    echo -e "${rojo}⚠️ ERROR INESPERADO, POR FAVOR REVISE SUS SERVICIOS${cierre}"
    echo -e "${rojo}⚠️ Y VUELVA A INTERNTARLO ${cierre}"
    fi
    echo -e "${blanco}${service}          ${guinda}${puerto_i}${cierre}" >> $dir_info
    echo -e "${puerto_i}" >> $dir_ports
    service sslh restart
    back_menu
    } 
eliminar_servicio(){
    unset service
    unset puerto_i
    echo -e "$bar1"
    cat $dir_info | awk -v OFS='\t\t' '{print $1,$2}'
    echo -e "$bar1"
    echo -e "${azul}Escriba el nombre de servicio que de desea Eliminar${cierre}"
    echo -e "$bar2"
    read -p "$(echo -e "${amarillo}ingrese: ${cierre}")" -e -i anyprot service
    echo -e "${azul}Escriba el numero de puerto que de desea Eliminar${cierre}"
    echo -e "$bar2"
    read -p "$(echo -e "${amarillo}ingrese: ${cierre}")" puerto_i
    rm_service="--$service 127.0.0.1:$puerto_i"
    sed -i "s;$rm_service;proto;g" $dir_conf
    sed -i 's/proto//g' $dir_conf
    grep -Ev "$puerto_i" $dir_info > temp
    mv -f temp $dir_info
    service sslh restart
    rm -rf temp
    rm -rf $dir_puertos/$puerto_i
    back_menu
}
informacion_puertos(){
    echo -e "${verde}SERVICIO   ${blanco}/    ${verde}PUERTO${cierre}"
    echo -e "$bar1"
    cat $dir_info | awk -v OFS='\t\t' '{print $1,$2}'
    echo -e "$bar1"
    back_menu
}
desinstalar(){
    service sslh stop
    rm -rf $dir_info
    rm -rf $dir_ports
    rm -rf $dir_conf
    rm -rf $dir_base
    rm -rf $dir_service
    rm -rf $arch_serv
    rm -rf $dir_puertos
    apt purge sslh -y 
}
sslh_onoff=`if netstat -tunlp |grep sslh 1> /dev/null 2> /dev/null; then
echo -e "\033[1;32m🟢"
else
echo -e "\033[1;31m🔴"
fi`
total_p=$(cat $dir_info)
menu_sslh(){
    clear
    msg
echo -e "${melon}                  SSLH - MULTIPLEXOR
${bar1}
${morado}ESTADO DE SERVICIO: ${blanco}>${cierre} ${guinda}SSLH: $sslh_onoff  ${cierre}
${bar2}
${azul}[1]${cierre} ${rojo}>${cierre} ${amarillo}INSTALAR ${verde}SSLH${cierre}
${azul}[2]${cierre} ${rojo}>${cierre} ${amarillo}AGREGAR SERVICIOS${cierre}
${azul}[3]${cierre} ${rojo}>${cierre} ${amarillo}ELIMINAR ${guinda}SERVICIOS${cierre}
${azul}[4]${cierre} ${rojo}>${cierre} ${amarillo}INFORMACION DE PUERTOS${cierre}
${azul}[5]${cierre} ${rojo}>${cierre} ${guinda}DESINSTALAR SSLH${cierre}
${azul}[0]${cierre} ${rojo}>${cierre} ${blanco}SALIR${cierre}
${bar2}"
read -p "$(echo -e "${blanco}seleccione [0-5]:${cierre}")" selection
case "$selection" in
	1)instalar_sslh ;;
	2)agregar_servicos ;;
    3)eliminar_servicio ;;
    4)informacion_puertos ;;
    5)desinstalar ;;
	0)cd $HOME && menu;;
	*)
	echo -e "${rojo} Porfavor seleccione del [0-5]${cierre}"
	;;
esac
}
menu_sslh