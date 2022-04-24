#!/bin/bash
 clear
 echo -e               "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                 ""\E[41;1;37m << INSTALAR Y CREAR CUENTA V2RAY WEBSOCKET >> \033[0m"
 echo -e               "\033[1;33m                 ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e " \E[41;1;37mCONFIGURAR V2RAY WEBSOCKET HTTP\033[0m                " "\E[41;1;37mCONFIGURAR XRAY WEBSOCKET HTTP\033[0m"
 echo -e " \E[48;1;37m[1] • PARA INSTALAR V2RAY WS\033[0m                   " "\E[48;1;37m[7] • PARA INSTALAR XRAY WS\033[0m"
 echo -e " \E[48;1;37m[2] • PARA AGREGAR DOMINIO\033[0m                     " "\E[48;1;37m[8] • PARA AGREGAR DOMINIO\033[0m"
 echo -e " \E[48;1;37m[3] • PARA CAMBIAR PUERTO \033[0m                     " "\E[48;1;37m[9] • PARA CAMBIAR PUERTO\033[0m"
 echo -e " \E[48;1;37m[4] • PARA VER CUENTA V2RAY\033[0m                     ""\E[48;1;37m[10]• PARA VER CUENTA XRAY\033[0m"
 echo -e " \E[48;1;37m[5] • PARA DESACTIVAR V2RAY\033[0m                     ""\E[48;1;37m[11]• PARA DESACTIVAR XRAY\033[0m"
 echo -e " \E[48;1;37m[6] • PARA ACTIVAR V2RAY WS\033[0m                     ""\E[48;1;37m[12]• PARA ACTIVAR XRAY WS\033[0m"
 echo -e " \E[41;1;37mAGREGAR NUEVA CUENTA V2RAY Y DEL\033[0m                ""\E[41;1;37mAGREGAR NUEVA CUENTA XRAY Y DEL\033[0m"
 echo -e " \E[48;1;37m[16]• AGREGAR + CUENTAS V2RAY\033[0m                   ""\E[48;1;37m[20]• AGREGAR + CUENTAS XRAY\033[0m"
 echo -e " \E[48;1;37m[17]• Y ELIMINA CUENTAS V2\033[0m                      ""\E[48;1;37m[21]• Y ELIMINA CUENTAS XY\033[0m"
 echo -e " \E[48;1;37m[18]• ABRE O CIERRA TCPFAST\033[0m                     ""\E[48;1;37m[22]• ABRE O CIERRA TCPFAST\033[0m"
 echo -e " \E[48;1;37m[19]• Y AGREGA DOMINIO CDN\033[0m                      ""\E[48;1;37m[23]• Y AGREGA DOMINIO CDN\033[0m"
 echo ""
 echo -e "                   ""\E[41;1;37mHACER LIMPIEZA DEL V2RAY Y XRAY CACHES WS\033[0m"
 echo -e "                        ""\E[48;1;37m[24] • LIMPIAR V2RAY Y XRAY\033[0m"
 echo ""
 echo -e "                  "" \E[41;1;37mPRESIONA 13 PARA DESINSTALAR V2RAY Y XRAY\033[0m"
 echo ""
 function instala () {
 clear
 echo -e "\E[44;1;37mISTALANDO V2RAY WS ESPERE\033[0m"
 source <(curl -sL https://multi.netlify.app/v2ray.sh)
 echo -e "\E[44;1;37mINFORMACION DE CUENTA V2AY INSTALADA\033[0m"
 echo ""
 echo -e   "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m"     " \E[41;1;37m[00]-EXIT\033[0m "  " \E[41;1;37m[04]-V2RAY\033[0m   " "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function domi () {
 clear
 echo -e "\E[44;1;37mAGREGA TU DOMINIO CLOUDFLARE\033[0m"
 v2ray stream
 echo -e "\E[44;1;37mAGREGADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function port () {
 clear
 echo -e "\E[44;1;37mAGREGA Y CAMBIA PUERTO V2RAY HTTP\033[0m"
 v2ray port
 echo -e "\E[44;1;37mPUERTO CAMBIADO Y AGREGADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function info () {
 clear
 echo -e "\E[44;1;37mINFORMACION DE CUENTA V2RAY\033[0m"
 v2ray info
 echo ""
 echo -e "\E[44;1;37mLISTADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function dct () {
 echo -e "\E[44;1;37mV2RAY DESACTIVADO Y DESCONECTADO CON EXITO\033[0m"
 service v2ray stop
 sleep 1.5s
 /root/jl.sh
 }
 function act () {
 echo -e "\E[44;1;37mV2RAY ACTIVADO Y CONECTADO CON EXITO\033[0m"
 service v2ray start
 sleep 1.5s
 /root/jl.sh
 }
 function ins () {
 clear
 echo -e "\E[44;1;37mINSTALANDO XRAY WS ESPERE\033[0m"
 source <(curl -sL https://multi.netlify.app/v2ray.sh)
 echo -e "\E[44;1;37mINFORMACION DE CUENTA XRAY INSTALADA\033[0m"
 echo ""
 echo -e   "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m"     "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function nio () {
 clear
 echo -e "\E[44;1;37mAGREGA TU DOMINIO CLOUDFLARE\033[0m"
 xray stream
 echo -e "\E[44;1;37mAGREGADO CON EXIT\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function pt () {
 clear
 echo -e "\E[44;1;37mAGREGA Y CAMBIA PUERTO XRAY HTTP\033[0m"
 xray port
 echo -e "\E[44;1;37mPUERTO CAMBIADO Y AGREGADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function fn () {
 clear
 echo -e "\E[44;1;37mINFORMACION DE CUENTA XRAY\033[0m"
 xray info
 echo ""
 echo -e "\E[44;1;37mLISTADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function fg () {
 echo -e "\E[44;1;37mXRAY DESACTIVADO Y DESCONECTADO CON EXITO\033[0m"
 service xray stop
 sleep 1.5s
 /root/jl.sh
 }
 function fl () {
 echo -e "\E[44;1;37mXRAY ACTIVADO Y CONECTADO CON EXITO\033[0m"
 service xray start
 sleep 1.5s
 /root/jl.sh
 }
 function rs () {
 clear
 echo -e "\E[44;1;37mDESINSTALANDO V2RAY Y XRAY WEBSOCKET\033[0m"
 source <(curl -sL https://multi.netlify.app/v2ray.sh) --remove
 echo -e "\E[44;1;37mDESINSTALADO CON EXTIO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA >>\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-VOLVER\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function v2ad () {
 clear
 echo -e "\E[44;1;37mESCRIVE TU PUERTO QUERIDO HTTP\033[0m"
 v2ray add
 clear
 echo -e "\E[44;1;37mNUEVA CUENTA WEBSOCKET AGREGADA CON EXITO SE CLASIFICA POR LETRAS A,B,C\033[0m"
 v2ray info
 sleep 1s
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function xa () {
 clear
 echo -e "\E[44;1;37mESCRIVE TU PUERTO QUERIDO HTTP\033[0m"
 xray add
 clear
 echo -e "\E[44;1;37mNUEVA CUENTA WEBSOCKET AGREGADA CON EXITO SE CLASIFICA POR LETRAS A,B,C\033[0m"
 xray info
 sleep 1s
 echo -e "\E[44;1;37mESCOGE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function veli () {
 clear
 echo -e "\E[44;1;37mESCRIVE LA LETRA A,B,C DE LA CUENTA EN MAYUSCULA PARA ELININAR\033[0m"
 v2ray del
 sleep 1s
 echo -e "\E[44;1;37mCUENTA ELIMINADA CON EXITO\033[0m"
 echo -e "\E[44;1;37mPRESIONA TU OPCION QUERINA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function xb () {
 clear
 echo -e "\E[44;1;37mESCRIVE LA LETRA A,B,C DE LA CUENTA EN MAYUSCULA PARA ELIMINAR\033[0m"
 xray del
 sleep 1s
 echo -e "\E[44;1;37mCUENTA ELIMINADA CON EXITO\033[9m"
 echo -e "\E[44;1;37mPRESIONA TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function over () {
 clear
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUE DESEAS DE FASTCP EN NUMEROS 1,2,3\033[0m"
 v2ray tfo
 echo -e "\E[44;1;37mTERMINADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function bb () {
 clear
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUE DESEAS DE FASTCP EN NUMEROS 1,2,3\033[0m"
 xray tfo
 echo -e "\E[44;1;37mTERMINADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>> "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function ccc () {
 clear
 echo -e "\E[44;1;37mAGREGA DOMINIO CDN V2RAY\033[0m"
 v2ray cdn
 echo -e  "\E[44;1;37mTERMINADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[0m" "\E[41;1;37m[04]-MENU-V2RAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function nn () {
 clear
 echo -e "\E[44;1;37mAGREGA DOMINIO CDN XRAY\033[0m"
 xray cdn
 echo -e "\E[44;1;37mTERMINADO CON EXITO\033[0m"
 echo ""
 echo -e "\E[44;1;37mESCRIVE TU OPCION QUERIDA\033[0m" "\E[41;1;37m[00]-EXIT\033[9m" "\E[41;1;37m[04]-MENU-XRAY\033[0m" "\E[41;1;37m[15]-AUTO-MENU\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>> "; read opcion
 case $opcion in
 4)/root/jl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 }
 function ui () {
 echo -e "\E[44;1;37mV2RAY Y XRAY A SIDO LIMPIADO CON EXITO\033[0m"
 sleep 2.5s
 v2ray clean
 xray clean
 clear
 /root/jl.sh
 }
 echo -e    "                          "  "\E[41;1;37m[15]-AUTO-MENU\033[0m" "\E[41;1;37m[00]-EXIT\033[0m"
 echo ""
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 1)instala
 ;;
 2)domi
 ;;
 3)port
 ;;
 4)info
 ;;
 5)dct
 ;;
 6)act
 ;;
 7)ins
 ;;
 8)nio
 ;;
 9)pt
 ;;
 10)fn
 ;;
 11)fg
 ;;
 12)fl
 ;;
 13)rs
 ;;
 15)/root/menu
 ;;
 16)v2ad
 ;;
 17)veli
 ;;
 18)over
 ;;
 19)ccc
 ;;
 20)xa
 ;;
 21)xb
 ;;
 22)bb
 ;;
 23)nn
 ;;
 24)ui
 ;;
 esac
 exit
 done
  