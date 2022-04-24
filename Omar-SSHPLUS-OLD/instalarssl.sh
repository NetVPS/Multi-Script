#!/bin/bash
 rm -rf /etc/stunnel/stunnel.pem
 apt-get install stunnel4 -y > /dev/null 2>&1
 openssl genrsa -out key.pem 2048 > /dev/null 2>&1
 (echo br; echo br; echo uss; echo speed; echo adm; echo ultimate; echo @admultimate)|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
 echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${pt}\naccept = 443" > /etc/stunnel/stunnel.conf
 cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel4 restart
 service stunnel4 start
 echo -e "\E[44;1;37mFIN ESCRIVE 4 PARA AUTOVOLVER O 0 PARA SALIR DE TODO\033[0m      ""\033[1;33m\033[2;33m\E[41;1;37m[15]-MENU PRINCIPAL\033[0m"
 while [ "$opcion" != "0" ]
 do
 echo ""
 echo -ne "\E[0;37;41mOPCION:\033[0m""\033[1;37m>>\033[0m "; read ff
 case $ff in
 
 4)/root/sl.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done
  