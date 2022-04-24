#!/bin/bash
 sudo apt install apache2 -y > /dev/null 2>&1
 echo -e Listen 81 > /etc/apache2/ports.conf
 service apache2 stop
 service apache2 start
 echo -e "\E[44;1;37mAPACHE Y PUERTO INSTALADO CON EXITO\033[0m"
 echo -e "\E[44;1;37mPRESIONA TU OPCION DESEADA PARA SALIR O RGRESAR AL MENU\033[0m"
 echo ""
 echo -e "                                                       ""\E[41;1;37m[15]-AUTO-MENU\033[0m"    "\E[41;1;37m[00]-EXIT\033[0m"
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 1)
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done