#!/bin/bash
 clear
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                   ""\E[41;1;37m  << INSTALA Y DESINSTALA SSL TUNNEL  >>   \033[0m"
 echo -e               "\033[1;33m                   ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[41;1;37mPARA ESTE PROCESO DEVES INSTALAR SSL PRIMERO\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] • INSTALAR SSL\033[0m                     ""\E[48;1;37m[5] • AGREGAR DIRECCION INTERNA AL SSL\033[0m"
 echo -e "\E[48;1;37m[2] • ACTIVAR PORT SSL ACTUALES\033[0m        ""\E[48;1;37m[6] • AGREGAR SSL PUERTO EXTRA\033[0m"
 echo -e "\E[48;1;37m[3] • DESACTIVAR PORT SSL ACTUALES\033[0m     ""\E[48;1;37m[7] • REINICIAR SSL Y PORT\033[0m"
 echo ""
 echo -e "                ""\E[48;1;37m[8] • CLOUDFRONT CERTIFICADO CNAME\033[0m"
 echo ""
 echo -e "\033[1;33m\033[0m                                                                 ""\E[0;37;41m[04]-AUTO MENU\033[0m"
 echo -e "\033[1;33m\033[0m                                                                 ""\E[0;37;41m[0]-SALIR\033[0m"
 function ek () {
 echo -ne "\E[0;37;41mESCRIVE TU PUERTO SSL EN USO\033[0m""\033[1;37m>>\033[0m "; read r
 sleep 2.5s
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU PUERTO DE REDIRECCION INTERNA\033[0m""\033[1;37m>>\033[0m "; read n
 echo ""
 echo -ne "\E[0;37;41mDESEA AGREGAR OTRA DIRECCIÓN INTERNA\033[0m""\033[1;37m>>\033[0m "; read c
 echo ""
 echo -e "\E[0;37;44mREDIRECCION INTERNA AGREGADO\033[0m"
 sleep 2.5s
 (
 less << h > /etc/stunnel/stunnel.conf
 cert = /etc/stunnel/stunnel.pem
 client = no
 socket = a:SO_REUSEADDR=1
 socket = l:TCP_NODELAY=1
 socket = r:TCP_NODELAY=1
 
 [stunnel]
 connect = 127.0.0.1:$n
 connect = 127.0.0.1:$c
 accept = $r
 h
 )
 service stunnel4 stop
 service stunnel4 start
 /root/sl.sh
 }
 function g () {
 echo -ne "\E[0;37;41mESCRIVE TU NUEVO PUERTO NO 443 PARA AGREGAR:\033[0m""\033[1;37m>>\033[0m "; read v
 sleep 2.5s
 echo -e "\E[0;37;44mEL PUERTO \E[0;37;41m$v\033[0m""\E[0;37;44m SSL A SIDO AGREGADO\033[0m"
 sleep 2.5s
 (
 less << f > /etc/stunnel/stunnel.conf
 cert = /etc/stunnel/stunnel.pem
 client = no
 socket = a:SO_REUSEADDR=1
 socket = l:TCP_NODELAY=1
 socket = r:TCP_NODELAY=1
 
 [stunnel]
 connect = 127.0.0.1:
 accept = 443
 accept = $v
 f
 )
 service stunnel4 stop
 service stunnel4 start
 /root/sl.sh
 }
 function w () {
 echo ""
 echo -e "\E[0;37;44mAGREGAR CERTIFICADO SSL CLOUDFRONT CNAME\033[0m"
 sleep 2.5s
 echo ""
 touch /etc/f
 echo -ne "\E[0;37;41mPEGUE SU LINK DEL CERTIFICADO .ZIP O GENERAL\033[0m""\033[1;37m>>\033[0m "; read y
 wget $y > /dev/null 2>&1
 unzip *.zip > /dev/null 2>&1
 cat private.key certificate.crt ca_bundle.crt > /etc/stunnel/stunnel.pem
 service stunnel4 restart
 echo ""
 rm -rf private.key certificate.crt ca_bundle.crt
 rm *.zip
 echo -e "\E[0;37;44mFINALIZADO CON EXITO\033[0m"
 sleep 2.5s
 /root/sl.sh
 }
 while [ "$opcion" != "0" ]
 do
 echo -ne "\E[0;37;41mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 
 1)/root/instalarssl.sh
 echo -e "\E[44;1;37mSSL INSTALADO CON EXITO\033[0m"
 ;;
 2)echo -e "\E[44;1;37mSSL ACTIVADO CON EXITO\033[0m"
 sleep 1s
 service stunnel4 stop
 service stunnel4 start && /root/sl.sh
 ;;
 3)echo -e "\E[44;1;37mSSL AUTO DETENIDO CON EXITO\033[0m"
 sleep 1s
 service stunnel4 stop && /root/sl.sh
 ;;
 4)/root/menu
 ;;
 5)ek
 ;;
 6)g
 ;;
 7)
 echo -ne "\E[0;37;41mDESEA CONTINUAR> [S/N]:\033[0m""\033[1;37m>>\033[0m "; read h
 [[ $h = @(n|N) ]] && /root/sl.sh && exit
 echo -e "\E[0;37;44mSSL A SIDO REINICIADO Y DESACTIVADO\033[0m"
 sleep 3s
 pkill stunnel
 /root/sl.sh
 ;;
 8)w
 ;;
 esac
 exit
 done
  