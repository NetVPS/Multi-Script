#!/bin/bash
 apt install python -y > /dev/null 2>&1
 apt install screen -y > /dev/null 2>&1
 
 screen -dmS python python proxy.py -p 80
 echo -e "\E[44;1;37mINSTALACION DEL PUERTO FINALIZADA CON EXITO\033[0m"
 echo -e "\033[1;33m\033[0m                                                                 ""\E[41;1;37m[04]-AUTO MENU\033[0m"
 echo -e "\033[1;33m\033[0m                                                                 ""\E[41;1;37m[0]-SALIR\033[0m"
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 
 4)/root/menu
 ;;
 esac
 exit
 done
  