#!/bin/bash
 clear
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                   ""\E[41;1;37m  << INSTALA Y DESINSTALAR APACHE PORT  >> \033[0m"
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] • INSTALAR APACHE Y PUERTO\033[0m"
 echo -e "\E[48;1;37m[2] • DESACTIVAR APACHE PUERTO\033[0m"
 echo -e "\E[48;1;37m[3] • ACTIVAR APACHE Y PUERTO\033[0m"
 echo -e "                                              ""\E[41;1;37m[15]-AUTO-MENU\033[0m      ""\E[41;1;37m[00]-EXIT\033[0m"
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 
 1)/root/ap.sh
 ;;
 2)echo -e "\E[44;1;37mAPACHE Y PUERTO DESACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 service apache2 stop && /root/menu
 ;;
 3)echo -e "\E[44;1;37mAPACHE Y PUERTO ACTIVADO CON EXITO\033[0m"
 sleep 2.5s
 service apache2 start && /root/menu
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done
  