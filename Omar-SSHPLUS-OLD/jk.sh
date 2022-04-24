#!/bin/bash
clear
echo -e "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33m                 ""\E[41;1;37m << INSTALACION Y DESINSTALACION DE BADVPN >> \033[0m"
echo -e "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "\E[48;1;37m[1] • ACTIVAR BADVPN\033[0m"
echo -e "\E[48;1;37m[2] • DESACTIVAR BADVPN\033[0m"
echo ""
echo -e "\033[1;33m\033[0m                                                                 ""\E[41;1;37m[04]-AUTO MENU\033[0m"
echo -e "\033[1;33m\033[0m                                                                 ""\E[41;1;37m[0]-SALIR\033[0m"
while [ "$opcion" != "0" ]; do
    echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "
    read opcion
    case $opcion in 

    1)
        echo -e "\E[44;1;37mBADVPN ACTIVADO CON EXITO\033[0m"
        sleep 1s
        screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 && /root/menu
        ;;
    2)
        echo -e "\E[44;1;37mBADVPN DESACTIVADO CON EXITO\033[0m"
        sleep 1s
        screen -r -S "udpvpn" -X quit && /root/menu
        ;;
    3) ;;

    4)
        /root/menu
        ;;
    esac
    exit
done
clear
