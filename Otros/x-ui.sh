#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain}¡Debe utilizar el usuario root para ejecutar este script!\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red} No se detecta la versión del sistema, póngase en contacto con el autor del script.${plain}\n" && exit 1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}Por Favor Use - CentOS 7 o sistema superior!${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}¡Utilice Ubuntu 16 o una versión superior del sistema!${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}¡Utilice Debian 8 o un sistema de versión superior!${plain}\n" && exit 1
    fi
fi

confirm() {
    if [[ $# > 1 ]]; then
        echo && read -p "$1 [Defauld$2]: " temp
        if [[ "${temp}" == "" ]]; then
            temp=$2
        fi
    else
        read -p "$1 [y/n]: " temp
    fi
    if [[ "${temp}" == "y" || "${temp}" == "Y" ]]; then
        return 0
    else
        return 1
    fi
}

confirm_restart() {
    confirm "Ya sea para reiniciar el panel, reiniciar el panel también reiniciará xray" "y"
    if [[ $? == 0 ]]; then
        restart
    else
        show_menu
    fi
}

before_show_menu() {
    echo && echo -n -e "${yellow}Presione enter para regresar al menú principal: ${plain}" && read temp
    show_menu
}

install() {
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    if [[ $? == 0 ]]; then
        if [[ $# == 0 ]]; then
            start
        else
            start 0
        fi
    fi
}

update() {
   confirm "Esta función reinstalará a la fuerza la última versión actual y los datos no se perderán. ¿Desea continuar?" "n"
    if [[ $? != 0 ]]; then
        echo -e "${red}Cancelado${plain}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 0
    fi
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    if [[ $? == 0 ]]; then
        echo -e "${green}La actualización está completa y el panel se ha reiniciado automáticamente${plain}"
        exit 0
    fi
}

uninstall() {
    confirm "¿Está seguro de que desea desinstalar el panel, xray también lo desinstalará? " "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    systemctl stop x-ui
    systemctl disable x-ui
    rm /etc/systemd/system/x-ui.service -f
    systemctl daemon-reload
    systemctl reset-failed
    rm /etc/x-ui/ -rf
    rm /usr/local/x-ui/ -rf
	rm /usr/bin/x-ui -f
    echo ""
    echo -e "La desinstalación se realizó correctamente. Si desea eliminar esta secuencia de comandos, salga de la secuencia de comandos y ejecute ${green}rm /usr/bin/x-ui -f${plain}Borrar"
    echo ""

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

reset_user() {
    confirm "¿Está seguro de que desea restablecer el nombre de usuario y la contraseña a admin " "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -username admin -password admin
    echo -e "El nombre de usuario y la contraseña se han restablecido a ${green}admin${plain}, Reinicia el panel ahora"
    confirm_restart
}

reset_config() {
    confirm "¿Está seguro de que desea restablecer todas las configuraciones del panel? No se perderán los datos de la cuenta, ni se cambiará el nombre de usuario ni la contraseña" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -reset
    echo -e "Todos los paneles se han restablecido a los valores predeterminados, ahora reinicie los paneles y utilice los valores predeterminados. ${green}65432${plain}Panel de acceso al puerto"
    confirm_restart
}

set_port() {
    echo && echo -n -e "Ingrese el número de puerto [1-65535]: " && read port
    if [[ -z "${port}" ]]; then
        echo -e "${yellow}Cancelado${plain}"
        before_show_menu
    else
        /usr/local/x-ui/x-ui setting -port ${port}
        echo -e "Después de configurar el puerto, reinicie el panel y use el puerto recién configurado${green} ${port} ${plain}Panel de acceso"
        confirm_restart
    fi
}

start() {
    check_status
    if [[ $? == 0 ]]; then
        echo ""
        echo -e "${green}El panel ya se está ejecutando, no es necesario comenzar de nuevo, si necesita reiniciar, seleccione reiniciar${plain}"
    else
        systemctl start x-ui
        sleep 2
        check_status
        if [[ $? == 0 ]]; then
            echo -e "${green}x-ui Comenzó exitosamente${plain}"
        else
            echo -e "${red}El panel no pudo iniciarse. Puede deberse a que tardó más de dos segundos en iniciarse. Verifique la información de registro más tarde.${plain}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

stop() {
    check_status
    if [[ $? == 1 ]]; then
        echo ""
        echo -e "${green}面板已停止，无需再次停止${plain}"
    else
        systemctl stop x-ui
        sleep 2
        check_status
        if [[ $? == 1 ]]; then
            echo -e "${green}x-ui 与 xray 停止成功${plain}"
        else
            echo -e "${red}面板停止失败，可能是因为停止时间超过了两秒，请稍后查看日志信息${plain}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

restart() {
    systemctl restart x-ui
    sleep 2
    check_status
    if [[ $? == 0 ]]; then
        echo -e "${green}x-ui y xray REINCIADO EXITOSAMENTE${plain}"
    else
        echo -e "${red}El reinicio del panel falló, puede deberse a que el tiempo de inicio supera los dos segundos, verifique la información de registro más tarde${plain}"
    fi
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

status() {
    systemctl status x-ui -l
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

enable() {
    systemctl enable x-ui
    if [[ $? == 0 ]]; then
        echo -e "${green}x-ui Configure el inicio automático de encendido correctamente${plain}"
    else
        echo -e "${red}x-ui No se pudo configurar el inicio automático después del encendido${plain}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

disable() {
    systemctl disable x-ui
    if [[ $? == 0 ]]; then
        echo -e "${green}x-ui Cancelar el inicio automático de encendido con éxito${plain}"
    else
        echo -e "${red}x-ui Cancelar la falla de arranque${plain}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

show_log() {
    journalctl -u x-ui.service -e --no-pager -f
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

migrate_v2_ui() {
    /usr/local/x-ui/x-ui v2-ui

    before_show_menu
}

install_bbr() {
    # temporary workaround for installing bbr
    bash <(curl -L -s https://raw.githubusercontent.com/teddysun/across/master/bbr.sh)
    echo ""
    before_show_menu
}

update_shell() {
    wget -O /usr/bin/x-ui -N --no-check-certificate https://github.com/vaxilu/x-ui/raw/master/x-ui.sh
    if [[ $? != 0 ]]; then
        echo ""
        echo -e "${red}No se pudo descargar el script, verifique si la máquina se puede conectar a Github${plain}"
        before_show_menu
    else
        chmod +x /usr/bin/x-ui
        echo -e "${green}La secuencia de comandos de actualización se realizó correctamente. Vuelva a ejecutar la secuencia de comandos.${plain}" && exit 0
    fi
}

# 0: running, 1: not running, 2: not installed
check_status() {
    if [[ ! -f /etc/systemd/system/x-ui.service ]]; then
        return 2
    fi
    temp=$(systemctl status x-ui | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ x"${temp}" == x"running" ]]; then
        return 0
    else
        return 1
    fi
}

check_enabled() {
    temp=$(systemctl is-enabled x-ui)
    if [[ x"${temp}" == x"enabled" ]]; then
        return 0
    else
        return 1;
    fi
}

check_uninstall() {
    check_status
    if [[ $? != 2 ]]; then
        echo ""
        echo -e "${red}El panel se ha instalado, no repita la instalación${plain}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

check_install() {
    check_status
    if [[ $? == 2 ]]; then
        echo ""
        echo -e "${red}Primero instale el panel ${plain}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

show_status() {
    check_status
    case $? in
        0)
            echo -e "Estado del panel: ${green} EJECUTANDO ${plain}"
            show_enable_status
            ;;
        1)
            echo -e "Estado del panel: ${yellow}NO EJECUTADO ${plain}"
            show_enable_status
            ;;
        2)
            echo -e "Estado del panel: ${red}No Instalao${plain}"
    esac
    show_xray_status
}

show_enable_status() {
    check_enabled
    if [[ $? == 0 ]]; then
        echo -e "Ejecucion al Iniciar: ${green}SI${plain}"
    else
        echo -e "Ejecucion al Iniciar: ${red}NO${plain}"
    fi
}

check_xray_status() {
    count=$(ps -ef | grep "xray-linux" | grep -v "grep" | wc -l)
    if [[ count -ne 0 ]]; then
        return 0
    else
        return 1
    fi
}

show_xray_status() {
    check_xray_status
    if [[ $? == 0 ]]; then
        echo -e "xray ESTADO: ${green}EJECUTANDO{plain}"
    else
        echo -e "xray ESTADO: ${red}NO EJECUTADO${plain}"
    fi
}

show_usage() {
    echo "x-ui Cómo usar scripts de administración (Traduccion ChumoGHADM)"
    echo "------------------------------------------"
    echo "x-ui              - Menú de gestión de pantalla (más funciones)"
    echo "x-ui              - Menú de gestión de pantalla (más funciones)"
    echo "x-ui start        - Inicie el panel x-ui"
    echo "x-ui stop         - Detener el panel x-ui"
    echo "x-ui restart      - Reinicie el panel x-ui"
    echo "x-ui status       - Ver el estado de x-ui"
    echo "x-ui enable       - AutoEjecutar al Arranque"
    echo "x-ui disable      - Desactivar AutoEjecutar al Arranque "
    echo "x-ui log          - Ver registro x-ui"
    echo "x-ui update       - Actualizar el panel x-ui"
    echo "x-ui install      - Instalar el panel x-ui"
    echo "x-ui uninstall    - Desinstalar el panel x-ui"
    echo "------------------------------------------"
}

show_menu() {
    echo -e "
  ${green}x-ui Script de gestión del panel${plain}
   ${green}0.${plain} Salir 
————————————————
  ${green}1.${plain}Instalar x-ui
  ${green}2.${plain}Actualizar x-ui
  ${green}3.${plain}Desinstalar x-ui
————————————————
  ${green}4.${plain}Restablecer nombre de usuario y contraseña
  ${green}5.${plain}Restablecer la configuración del panel
  ${green}6.${plain}Establecer el puerto del panel
————————————————
  ${green}7.${plain}Iniciar x-ui
  ${green}8.${plain}Detener x-ui
  ${green}9.${plain}Reiniciar x-ui
 ${green}10.${plain}Ver el estado de x-ui
 ${green}11.${plain}Ver registro x-ui
————————————————
 ${green}12.${plain} Encender AutoEjecucion
 ${green}13.${plain} Cancelar AutoEjecucion
————————————————
 ${green}14.${plain} Instalación de bbr (el último kernel)
 "
    show_status
    echo && read -p "请输入选择 [0-14]: " num

    case "${num}" in
        0) exit 0
        ;;
        1) check_uninstall && install
        ;;
        2) check_install && update
        ;;
        3) check_install && uninstall
        ;;
        4) check_install && reset_user
        ;;
        5) check_install && reset_config
        ;;
        6) check_install && set_port
        ;;
        7) check_install && start
        ;;
        8) check_install && stop
        ;;
        9) check_install && restart
        ;;
        10) check_install && status
        ;;
        11) check_install && show_log
        ;;
        12) check_install && enable
        ;;
        13) check_install && disable
        ;;
        14) install_bbr
        ;;
        *) echo -e "${red}请输入正确的数字 [0-14]${plain}"
        ;;
    esac
}


if [[ $# > 0 ]]; then
    case $1 in
        "start") check_install 0 && start 0
        ;;
        "stop") check_install 0 && stop 0
        ;;
        "restart") check_install 0 && restart 0
        ;;
        "status") check_install 0 && status 0
        ;;
        "enable") check_install 0 && enable 0
        ;;
        "disable") check_install 0 && disable 0
        ;;
        "log") check_install 0 && show_log 0
        ;;
        "v2-ui") check_install 0 && migrate_v2_ui 0
        ;;
        "update") check_install 0 && update 0
        ;;
        "install") check_uninstall 0 && install 0
        ;;
        "uninstall") check_install 0 && uninstall 0
        ;;
        *) show_usage
    esac
else
    show_menu
fi
