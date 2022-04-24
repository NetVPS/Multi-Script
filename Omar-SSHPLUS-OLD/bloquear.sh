#!/bin/bash
 clear
 echo -e "\E[44;1;37mINFORMACION Y LISTA DE TODOS LOS USUARIOS CREADOS PARA BLOCKEAR DETALLADOS••••\033[0m"
 amorT=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody)
 var1=$(printf ' %-15s' $amorT)
 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 echo -e "\033[1;34m$var1\033[0m"
 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 echo -e "\E[44;1;37mESCRIVE EL NUMERO 1 PARA BLOCKEAR UN USUARIO OBSERVASION ESCRIVIRLOS SIN ERROR\033[0m"
 echo -e "\E[44;1;37mESCRIVE 1\033[0m"
 read opcion
 case $opcion in
 1)
 echo -e  "\E[44;1;37mESCRIVE EL USUARIO PARA BLOCKEAR\033[0m"
 read user
 usermod -L $user
 sleep 1s
 echo -e "\E[41;1;37mFUE BLOCKEADO\033[0m"
 echo -e "\E[44;1;37mESCRIVE 3 PARA AUTOVOLVER O 0 PARA SALIR DE TODO\033[0m          " "\033[1;33m\033[2;33m\E[41;1;37m[15]-MENU PRINCIPAL\033[0m"
 ;;
 esac
 opc=0
 until [ $opc -eq 0 ]
 do
 case $opc in
 2)/root/bloquear.sh
 ;;
 3)/root/omar
 esac
 read opc
 done
 [ $? -eq 0 ]
 while [ "$opcion" != "0" ]
 do
 read opcion
 case $opcion in
 
 3)/root/bloquear.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done 