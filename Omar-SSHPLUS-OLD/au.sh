#!/bin/bash
 clear
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                   ""\E[41;1;37m  << ACTIVA Y DESACTIVA MENU AUTOMATICO >> \033[0m"
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] • ACTIVAR EL MENU AUTOMATICO\033[0m"
 echo -e "\E[48;1;37m[2] • DESACTIVAR MENU AUTOMATICO\033[0m"
 echo -e                                                                          "\033[1;37m\033[0m                                               ""   \E[41;1;37m[15]-AUTO-MENU\033[0m    ""\E[41;1;37m[00]-EXIT\033[0m"
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 
 1)echo -e "\E[44;1;37mEL MENU A SIDO ACTIVADO\033[0m"
 sleep 1.5s
 /root/amor.sh && /root/menu
 ;;
 2)echo -e "\E[44;1;37mEL MENU A SIDO DESACTIVADO\033[0m"
 sleep 1.5s
 sed -i '/menu;/d' /etc/profile && /root/menu
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done
  