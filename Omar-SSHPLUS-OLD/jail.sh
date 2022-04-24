#!/bin/bash
 [[ -e /etc/bannerssh ]] && amor=$(echo -e "\033[1;31m[\033[1;35mON\033[1;31m]") || amor=$(echo -e "\033[1;31m[OFF]\033[0m")
 [[ -e /etc/sis3 ]] && sis=$(echo -e "\033[1;31m[\033[1;35mON\033[1;31m]\033[0m") || sis=$(echo -e "\033[1;31m[OFF]\033[0m")
 [[ -e /etc/as ]] && as=$(echo -e "\033[1;31m[\033[1;35mON\033[1;31m]\033[0m") || as=$(echo -e "\033[1;31m[\033[1;31mOFF\033[1;31m]\033[0m")
 [[ -e /etc/ss ]] && s=$(echo -e "\033[1;31m[\033[1;35mON\033[1;31m]\033[0m") || s=$(echo -e "\033[1;31m[\033[1;31mOFF\033[1;31m]\033[0m")
 [[ -e /etc/lv ]] && w=$(echo -e "\033[1;31m[\033[1;35mON\033[1;31m]\033[0m") || w=$(echo -e "\033[1;31m[\033[1;31mOFF\033[1;31m]\033[0m")
 clear
 echo -e               "\033[1;33m             ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m             ""\E[41;1;37m << HERRAMIENTAS DE SEGURIDA Y MAS PROTECCIÓN VPS >> \033[0m"
 echo -e               "\033[1;33m             ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[0;37;41mHERRAMIENTAS DE SEGURIDA Y HERRAMIENTAS DE SERVICIO\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] • INSTALAR FAIL2BAN VPS PROCTECCION\033[0m" $(ps x | grep "fail2ban"|grep -v grep > /dev/null && echo -e "\033[1;31m[\033[1;35mON\033[1;31m] " || echo -e "\033[1;31m[OFF] ")
 echo -e "\E[48;1;37m[2] • AGREGAR BANNER DE LA CONEXION VPS\033[0m"   $amor
 echo -e "\E[48;1;37m[3] • AUTO ELIMINAR LA CACHE AUTOMATICO\033[0m"   $sis
 echo -e "\E[48;1;37m[4] • INSTALAR RDP Y CONEXIONES REMOTAS\033[0m"   $as
 echo -e "\E[48;1;37m[5] • FIREWALL USO BLOQUEO Y DESBLOQUEO\033[0m"   $s
 echo -e "\E[48;1;37m[6] • AUTOELIMINACION USUARIOS VENCIDOS\033[0m"   $w
 echo ""
 echo -e "\E[0;37;41m[15]-AUTO-MENU\033[0m  " "\E[0;37;41m[00]-EXIT\033[0m"
 echo ""
 function g () {
 touch sis
 read -p "$(echo -e "\E[0;37;44mOPCION S INSTALAR OPCION N DESACTIVAR\033[0m""\033[1;33m[s/n]:\033[1;37m") " -e -i n amor
 if [[ "$amor" = 's' ]]; then
 echo ""
 echo -e "\E[0;37;41mINSTALANDO FAI2BAN PROTECCION VPS ESPERE\033[0m"
 touch sis
 sudo apt install fail2ban -y > /dev/null 2>&1
 sudo systemctl start fail2ban
 sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
 sudo systemctl restart fail2ban
 echo ""
 echo -e "\E[0;37;44mFAIL2BAN A SIDO INICIADO PROTCCION VPS\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 if [[ "$amor" = 'n' ]]; then
 service fail2ban stop > /dev/null 2>&1
 rm -rf sis
 sleep 2s
 /root/jail.sh
 fi
 }
 function h () {
 echo ""
 echo -e "\E[48;1;37m[1] DESEA AGREGAR UN BANNER\033[0m"
 echo -e "\E[48;1;37m[2] DESEA ELIMINAR BANNER\033[0m"
 echo ""
 read -p "$(echo -e "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m") " -e r
 if [[ "$r" = "2" ]]; then
 rm -rf /etc/bannerssh
 echo ""
 echo -e "\E[0;37;44mBANNER ELIMINADO\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 if [[ "$r" = "1" ]]; then
 echo ""
 echo -e "\E[48;1;37m[1] AGREGAR MULTICOLOR Y DOBLELINEA DE TEXTO\033[0m"
 echo -e "\E[48;1;37m[2] AGREGAR UNA SOLA LINEA DE TEXTO\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read m
 fi
 if [[ "$m" = "1" ]]; then
 echo ""
 echo -ne "\E[0;37;44mA ELEGIDO MULTICOLOR Y DOBLE TEXTO\033[0m"
 echo ""
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU PRIMER TEXTO A AGREGAR\033[0m""\033[1;37m>>\033[0m "; read g
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU SEGUNDO TEXTO A AGREGAR\033[0m""\033[1;37m>>\033[0m "; read v
 echo ""
 echo -e "\E[48;1;37m[1] ROJO Y VERDE\033[0m"
 echo -e "\E[48;1;37m[2] AMARIYO Y AZUL\033[0m"
 echo -e "\E[48;1;37m[3] NARANJA Y ROSADO\033[0m"
 echo -e "\E[48;1;37m[4] ROJO Y AZUL\033[0m"
 echo -e "\E[48;1;37m[5] ROJO Y ROJO\033[0m"
 echo -e "\E[48;1;37m[6] ROJO Y NEGRO\033[0m"
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU COLOR DESEADO\033[0m""\033[1;37m>>\033[0m "; read f
 if [[ "$f" = "1" ]]; then
 f="red"
 j="green"
 elif [[ "$f" = "2" ]]; then
 f="yellow"
 j="blue"
 elif [[ "$f" = "3" ]]; then
 f="#FF7F00"
 j="#F535AA"
 elif [[ "$f" = "4" ]]; then
 f="red"
 j="blue"
 elif [[ "$f" = "5" ]]; then
 f="red"
 j="#9932CD"
 elif [[ "$f" = "6" ]]; then
 f="red"
 j="black"
 fi
 echo ""
 chk=$(cat /etc/ssh/sshd_config | grep Banner)
 [[ $(netstat -nltp|grep 'dropbear' | wc -l) != '0' ]] && {
     local="/etc/bannerssh"
 	[[ $(grep -wc $local /etc/default/dropbear) = '0' ]] && echo 'DROPBEAR_BANNER"/etc/bannerssh"' >> /etc/default/dropbear
 }
 [[ "$(echo "$chk" | grep -v '#Banner' | grep Banner)" != "" ]] && {
 	local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 } || {
     local="/etc/bannerssh"
     [[ $(grep -wc $local /etc/ssh/sshd_config) = '0' ]] && echo "BANNER /etc/bannerssh" >> /etc/ssh/sshd_config
 }
 echo -e "<h1 style='text-aling:center'><font color='$f' style='text-align:center'>$g</font></h>" > /etc/bannerssh
 echo -e "<h1 style='text-aling:center'><font color='$j' style='text-aling:center'>$v</font></h>" >> /etc/bannerssh
 service ssh restart > /dev/null 2>&1 && service dropbear restart > /dev/null 2>&1
 echo -e "\E[0;37;44mBANNER AGREGADO CON EXITO\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 if [[ "$m" = "2" ]]; then
 echo ""
 echo -e "\E[0;37;44mA ELEGIDO SOLO UN COLOR\033[0m"
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU TEXTO A AGREGAR\033[0m""\033[1;37m>>\033[0m "; read g
 echo ""
 echo -e "\E[48;1;37m[1] ROJO\033[0m"
 echo -e "\E[48;1;37m[2] AZUL\033[0m"
 echo -e "\E[48;1;37m[3] AMARIYO\033[0m"
 echo -e "\E[48;1;37m[4] VERDE\033[0m"
 echo -e "\E[48;1;37m[5] NARANJA\033[0m"
 echo -e "\E[48;1;37m[6] ROSADO\033[0m"
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU COLOR A AGREGAR\033[0m""\033[1;37m>>\033[0m "; read d
 if [[ "$d" = "1" ]]; then
 d="red"
 elif [[ "$d" = "2" ]]; then
 d="blue"
 elif [[ "$d" = "3" ]]; then
 d="yellow"
 elif [[ "$d" = "4" ]]; then
 d="green"
 elif [[ "$d" = "5" ]]; then
 d="#FF7F00"
 elif [[ "$d" = "6" ]]; then
 d="#F535AA"
 fi
 chk=$(cat /etc/ssh/sshd_config | grep Banner)
 [[ $(netstat -nltp|grep 'dropbear' | wc -l) != '0' ]] && {
     local="/etc/bannerssh"
 	[[ $(grep -wc $local /etc/default/dropbear) = '0' ]] && echo 'DROPBEAR_BANNER="/etc/bannerssh"' >>  /etc/default/dropbear
 }
 [[ "$(echo "$chk" | grep -v '#Banner' | grep Banner)" != "" ]] && {
 	local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 } || {
     local="/etc/bannerssh"
     [[ $(grep -wc $local /etc/ssh/sshd_config) = '0' ]] && echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
 }
 echo -e "<h1 style='text-align:center'><font color='$d' style='text-align:center'>$g</font></h>" > /etc/bannerssh
 service ssh restart > /dev/null 2>&1 && service dropbear restart > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mBANNER AGREGADO CON EXITO\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 }
 function lt () {
 echo ""
 read -p "$(echo -e "\E[0;37;41mDESEA CONTINUAR EL PROCESO [s/n]\033[0m""\033[1;37m>>\033[0m") " -e -i n a
 if [[ "$a" = "n" ]]; then
 echo ""
 echo -e "\E[0;37;44mSE A CANCELADO EL PROCESO DE ACTIVACION\033[0m"
 sleep 3s
 /root/jail.sh
 exit
 fi
 if [[ "$a" = "s" ]]; then
 echo ""
 echo -e "\E[48;1;37m[1] ACTIVAR\033[0m"
 echo -e "\E[48;1;37m[2] DESACTIVAR\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read h
 fi
 if [[ "$h" = "1" ]]; then
 echo -e "\E[0;37;44mELIMINACION DE CACHE Y RAM ACTIVADO CON EXITO\033[0m"
 sleep 3s
 touch /etc/sis3
 touch /var/spool/cron/crontabs/root
 crontab -i /var/spool/cron/crontabs/root > /dev/null 2>&1
 sed -i '1i */1 * * * * sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1' /var/spool/cron/crontabs/root > /dev/null 2>&1
 sed -i '1i */1 * * * * su -c echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberadas' root && echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberada's' >> /var/spool/cron/crontabs/root > /dev/null 2>&1
 sed -i '1i 0 5 * * * sudo apt-get clean' >> /var/spool/cron/crontabs/root > /dev/null 2>&1
 echo ""
 echo ""
 echo -e "\E[0;37;41mELIMINACION AUTOMATICA DE CACHE A SIDO ACTIVADO\033[0m"
 sleep 3s
 /root/jail.sh
 elif [[ "$h" = "2" ]]; then
 rm -rf /etc/sis3
 echo ""
 rm -rf /etc/lv
 sed -i '1,$d' /var/spool/cron/crontabs/root
 sed -i '$ d' /var/spool/cron/crontabs/root
 sed -i '$ d' /var/spool/cron/crontabs/root
 sed -i '$ d' /var/spool/cron/crontabs/root
 echo -e "\E[0;37;44mAUTO ELIMINACION DESACTIVADO CON EXITO\033[0m"
 sleep 2s
 echo ""
 echo ""
 echo -e "\E[0;37;41mESTO TAMBIEN DESACTIVA LA AUTOELIMINACION DE USUARIOS EXPIRADOS SOLO ACTIVELO\033[0m"
 sleep 7s
 /root/jail.sh
 fi
 }
 function p () {
 echo ""
 read -p "$(echo -e "\E[0;37;41mDESEA CONTINUAR LA ACTIVACION S/N\033[0m""\033[1;37m>>\033[0m") " -e -i n m
 if [[ "$m" = @(n|N) ]]; then
 echo ""
 echo -e "\E[0;37;44mSE A CANCELADO EL PROCESO\033[0m"
 sleep 2.5s
 /root/jail.sh
 elif [[ "$m" = @(s|S) ]]; then
 echo ""
 echo -e "\E[48;1;37m[1] • ACTIVAR\033[0m"
 echo -e "\E[48;1;37m[2] • DESACTIVAR\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read k
 fi
 if [[ "$k" = "1" ]]; then
 touch /etc/lv
 touch /var/spool/cron/crontabs/root
 crontab -i /var/spool/cron/crontabs/root > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mA SIDO ACTIVADO CON EXITO\033[0m"
 sed -i '1i */5 * * * * /etc/fg.sh' /var/spool/cron/crontabs/root
 sed -i '1i */4 * * * * /etc/w.sh' /var/spool/cron/crontabs/root
 sleep 3s
 /root/jail.sh
 elif [[ "$k" = "2" ]]; then
 rm -rf /etc/lv
 echo ""
 rm -rf /etc/sis3
 echo -e "\E[0;37;44mA SIDO DESACTIVADO CON EXITO\033[0m"
 sed -i '1,$d' /var/spool/cron/crontabs/root
 sleep 2s
 echo ""
 echo ""
 echo -e "\E[0;37;41mESTO TAMBIEN DESACTIVA LA AUTOELIMINACION DE RAM Y CACHE SOLO ACTIVELO\033[0m"
 sleep 5s
 /root/jail.sh
 fi
 }
 function j () {
 read -p "$(echo -e "\E[0;37;41mDESEA CONTINUAR LA INSTALACION [S/N]\033[0m ""\033[1;37m>>\033[0m ")" -e -i n c
 if [[ "$c" = @(n|N) ]]; then
 echo ""
 echo -e "\E[0;37;44mPROCESO DE INSTALACION CANCELADO\033[0m"
 sleep 3.5s
 /root/jail.sh
 fi
 if [[ "$c" = @(s|S) ]]; then
 echo ""
 echo -e "\E[48;1;37m[1] INSTALAR\033[0m"
 echo -e "\E[48;1;37m[2] DESACTIVAR RDP\033[0m"
 echo -e "\E[48;1;37m[3] ACTIVAR RDP\033[0m"
 echo -e "\E[48;1;37m[4] CAMBIAR CONTRASEÑA VPS\033[0m"
 echo -e "\E[48;1;37m[5] VOLVER\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 if [[ "$opcion" = "2" ]]; then
 echo ""
 echo -e "\E[0;37;44mEL SERVICIO RDP A SIDO DESACTIVADO\033[0m"
 rm -rf /etc/as
 service xrdp stop
 sleep 3s
 /root/jail.sh
 elif [[ "$opcion" = "3" ]]; then
 echo ""
 echo -e "\E[0;37;44mEL SERVICIO RDP A SIDO ACTIVADO CON EXITO\033[0m"
 touch /etc/as
 service xrdp start
 sleep 2.5s
 /root/jail.sh
 elif [[ "$opcion" = "5" ]]; then
 echo ""
 echo -e "\E[0;37;44mVOLVIENDO\033[0m"
 sleep 3s
 /root/jail.sh
 elif [[ "$opcion" = "1" ]]; then
 touch /etc/as
 echo ""
 echo -e "\E[0;37;44mESPERE POR FAVOR\033[0m"
 sudo apt install -y xfce4 desktop-base xfce4-terminal tango-icon-theme > /dev/null 2>&1
 sudo apt install xrdp -y > /dev/null 2>&1
 sudo adduser xrdp ssl-cert > /dev/null 2>&1
 sudo ufw allow 3389/tcp > /dev/null 2>&1
 sed -i '$ d' /etc/xrdp/startwm.sh
 echo -e "#exec /bin/sh /etc/X11/Xsession" >> /etc/xrdp/startwm.sh
 echo -e "startxfce4" >> /etc/xrdp/startwm.sh
 sudo systemctl restart xrdp
 echo -e "\E[0;37;44mINSTALACION FINALIZADA PARA LA CONEXION REMOTA\033[0m"
 sudo apt install qupzilla -y > /dev/null 2>&1
 /root/jail.sh
 elif [[ "$opcion" = "4" ]]; then
 echo ""
 echo -e "\E[0;37;44mESCRIVE SU CONTRASEÑA QUE DESEE 2 VECES\033[0m"
 echo ""
 passwd
 /root/jail.sh
 elif [[ "$opcion" = "2" ]] ; then
 echo -e "\E[0;37;44mAGREGUE SU USUARIO QUE DESEA PARA OTRAS CONEXIONES REMOTAS\033[0m"
 echo ""
 sleep 3s
 echo -e "\E[0;37;44mSU USUARIO SE AGREGO DE FORMA AUTOMATICA POR SEGURIDA\033[0m"
 echo ""
 echo -e "\E[0;37;44mSOLO AGREGUE LA CONTRASEÑA AL USUARIO DE NOMBRE REMOTO EL RESTO\033[0m""\E[0;37;41m ENTER\033[0m"
 echo ""
 sudo adduser amor2
 sleep 5s
 /root/jail.sh
 fi
 fi
 }
 function m () {
 echo ""
 read -p "$(echo -ne "\E[0;37;41mDESEA SEGUIR PARA ACTIVAR EL SERVICIO DEL FIREWALL S/N\033[0m""\033[1;37m>>\033[0m") " -i n w
 if [[ "$w" = @(n|N) ]]; then
 echo ""
 echo -e "\E[0;37;44mSE A CANCELADO EL PROCESO DE ACTIVACION\033[0m"
 sleep 2.5s
 /root/jail.sh
 exit
 fi
 if [[ "$w" = @(s|S) ]]; then
 echo ""
 echo -e "\E[0;37;41mPARA ESTE PROCESO DEVES ACTIVAR FIREWALL ANTES OPCION\033[0m""\E[0;37;41m 1 \033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] ACTIVAR FIREWALL\033[0m"   $s
 echo -e "\E[48;1;37m[2] ACTIVAR PUERTOS EN EL FIREWALL TCP O UDP\033[0m"
 echo -e "\E[48;1;37m[3] ACTIVAR SU IP U OTRAS EN EL FIREWALL\033[0m"
 echo -e "\E[48;1;37m[4] BLOQUEAR PUERTOS EN EL FIREWALL TCP O UDP\033[0m"
 echo -e "\E[48;1;37m[5] BLOQUEAR IP EN EL FIREWALL\033[0m"
 echo -e "\E[48;1;37m[6] IPES Y PUERTOS BLOQUEADOS Y NO BLOQUEADOS EN FIREWALL\033[0m"
 echo -e "\E[48;1;37m[7] DESACTIVAR FIREWALL Y DETENER\033[0m"
 echo -e "\E[48;1;37m[8] VER IPES QUE SE AN METIDO AL VPS Y USUARIOS PERSONALES CONECTADOS\033[0m"
 echo -e "\E[48;1;37m[9] VOLVER\033[0m"
 echo ""
 echo -e "\E[48;1;37m[10] FIREWALL ACTIVAR PUERTOS ORACLE\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read a
 fi
 if [[ "$a" = "2" ]]; then
 echo -e "\E[0;37;44mESTO ACTIVARA LOS PUERTOS EN EL FIREWALL\033[0m"
 echo ""
 echo -e "\E[0;37;44mAGREGA TU PUERTO QUE DESEAS ACTIVAR EN EL TCP O UDP DEL FIREWALL\033[0m"
 echo ""
 echo -ne "\E[0;37;41mPUERTO\033[0m""\033[1;37m>>\033[0m "; read i
 echo ""
 echo -ne "\E[0;37;41mPROTOCOLO TCP O UDP EN MINUSCULAS\033[0m""\033[1;37m>>\033[0m "; read pt
 sudo ufw allow $i/$pt > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mEL PUERTO\033[0m""\E[0;37;41m $i \033[0m""\E[0;37;44mA SIDO ACTIVADO EN EL""\E[0;37;41m $pt \033[0m""\E[0;37;44m DEL FIREWALL PARA USARLO EN CONEXION\033[0m"
 sleep 8s
 lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN" > y
 sed -n ""p y | awk '{print $9}' | awk -F ":" '{print $2}' > j | cat j | sort | uniq > a
 /root/jail.sh
 elif [[ "$a" = "10" ]]; then
 echo ""
 echo -e "\E[0;37;44mACTIVAR PUERTOS EN EL FIREWALL A ORACLE CLOUD TCP O UDP\033[0m"
 echo ""
 echo -e "\E[48;1;37m[1] ACTIVAR\033[0m"
 echo -e "\E[48;1;37m[2] VOLVER\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read l
 if [[ "$l" = "1" ]]; then
 echo ""
 echo -ne "\E[0;37;41mESCRIVE TU PUERTO QUE VA ACTIVAR EN EL FIREWALL\033[0m""\033[1;37m>>\033[0m "; read y
 echo ""
 echo -e "\E[0;37;44mPROTOCOLO TCP O UDP ESCRIVA EN MINUSCULA\033[0m"
 echo ""
 echo -ne "\E[0;37;41mESCRIVA QUE PROTOCOLO DESEA ACTIVAR TCP O UDP\033[0m""\033[1;37m>>\033[0m "; read u
 firewall-cmd --zone=public --add-port=$y/$u --permanent > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mEL PUERTO\033[0m""\E[0;37;41m $y \033[0m""\E[0;37;44mY PROTOCOLO\033[0m""\E[0;37;41m $u \033[0m""\E[0;37;44mA SIDO ACTIVADO CON EXITO\033[0m"
 firewall-cmd --reload > /dev/null 2>&1
 sleep 3.5s
 /root/jail.sh
 fi
 if [[ "$l" = "2" ]]; then
 echo ""
 echo -e "\E[0;37;44mVOLVIENDO\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 elif [[ "$a" = "1" ]]; then
 touch /etc/ss
 echo ""
 sudo ufw enable
 echo ""
 echo -e "\E[0;37;44mEL FIREWALL A SIDO ACTIVADO LISTO PARA AGREGAR IPES Y PUERTOS O BLOQUEARLOS\033[0m"
 sleep 6s
 /root/jail.sh
 elif [[ "$a" = "3" ]]; then
 echo ""
 echo -e "\E[0;37;44mAGREGA IPES EN EL FIREWALL PARA QUE SEA ACTIVADAS Y ENTRAR CON EYAS AL VPS\033[0m"
 echo ""
 read -p "$(echo -e "\E[0;37;41mDESEA ASIGNAR SU IP U OTRAS IPES AL FIREWALL S/N\033[0m""\033[1;37m>>\033[0m") " -e -i n k
 if [[ "$k" = @(n|N) ]]; then
 echo ""
 echo -e "\E[0;37;44mSE A CANCELADO\033[0m"
 sleep 3s
 /root/jail.sh
 fi
 if [[ "$k" = @(s|S) ]]; then
 echo ""
 echo -e "\E[0;37;44mES NECESARIO QUE AGREGUE SU IP AL FIREWALL PARA QUE NO LA BLOQUEE EL SISTEMA Y PARA ENTRAR CON EYA AL VPS U OTRAS QUE USARA AL GUSTO\033[0m"
 echo ""
 echo -ne "\E[0;37;41mAGREGUE SU IP U OTRA QUE QUIERE ACTIVAR\033[0m""\033[1;37m>>\033[0m "; read f
 sudo ufw allow from $f > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mLA IP\033[0m""\E[0;37;41m $f \033[0m""\E[0;37;44mA SIDO AGREGADA Y ACTIVADA EN EL FIREWALL PARA USARCE\033[0m"
 sleep 6.5s
 /root/jail.sh
 fi
 elif [[ "$a" = "4" ]]; then
 echo ""
 echo -e "\E[0;37;44mAGREGUE EL PUERTO QUE DESEA BLOQUEAR EN EL FIREWALL Y ESE PUERTO NO PODRA ACCEDER A LA VPS\033[0m"
 echo ""
 echo -ne "\E[0;37;41mAGREGUE PUERTOS SOLO UNO\033[0m""\033[1;37m>>\033[0m "; read v
 echo ""
 echo -ne "\E[0;37;41mQUE PROTOCOLO DEL PUERTO TCP O UDP EN MINUSCULA\033[0m""\033[1;37m>>\033[0m "; read jp
 sudo ufw deny $v/$jp > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mEL PUERTO\033[0m""\E[0;37;41m $v \033[0m""\E[0;37;44mCON PROTOCOLO\033[0m""\E[0;37;41m $jp \033[0m""\E[0;37;44mA SIDO BLOQUEADO EN EL FIREWALL CON EXITO\033[0m"
 sleep 6s
 /root/jail.sh
 elif [[ "$a" = "5" ]]; then
 echo ""
 echo -e "\E[0;37;44mBLOQUEAR IPES EN EL FIREWALL PEGUE LA IP QUE DESEA BLOQUEAR Y ESA NO PODRA ENTRAR AL VPS\033[0m"
 echo ""
 echo -ne "\E[0;37;41mPEGUE SU IP A BLOQUEAR\033[0m""\033[1;37m>>\033[0m "; read t
 sudo ufw deny from $t > /dev/null 2>&1
 echo ""
 echo -e "\E[0;37;44mLA IP\033[0m""\E[0;37;41m $t \033[0m""\E[0;37;44mA SIDO BLOQUEADA EN EL FIREWALL\033[0m"
 sleep 6s
 /root/jail.sh
 elif [[ "$a" = "6" ]]; then
 echo ""
 echo -e "\E[0;37;44mPUERTOS\033[0m                    ""\E[0;37;44mSTATUS\033[0m      ""\E[0;37;44mIPES AGREGADAS AL FIREWALL\033[0m"
 sudo ufw status
 echo ""
 echo -e "\E[0;37;41m[4]-VOLVER\033[0m     ""\E[0;37;41m[15]-MENU\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read d
 case $d in
 1)50
 ;;
 4)/root/jail.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 elif [[ "$a" = "9" ]]; then
 echo ""
 echo -e "\E[0;37;44mVOLVIENDO\033[0m"
 sleep 2.5s
 /root/jail.sh
 elif [[ "$a" = "7" ]]; then
 echo ""
 rm -rf /etc/ss
 echo -e "\E[0;37;44mEL FIREWALL SE A DESACTIVADO\033[0m"
 sudo ufw disable > /dev/null 2>&1
 sleep 2.5s
 /root/jail.sh
 elif [[ "$a" = "8" ]]; then
 echo ""
 echo -e "\E[0;37;44mAKI PODRA VER TODAS LAS IPES QUE ENTRAN A SU VPS ICLUYENDO LA IP QUE USA PARA ENTRAR YA FUERA LA DE SU MAQUINA U OTRA TAMBIEN INCLUYENDO LA IP QUE SE UTILIZA PARA SUS USUARIOS QUE A CREADO CUANDO SE CONECTEN QUEDARAN SUS LOGS O REGISTRADOS EN ESTA LISTA\033[0m"
 echo ""
 echo -e "\E[0;37;44mSOLO BUSQUE LAS IPES QUE CONCIDERE QUE NO SON SUYAS O QUE NO A UTILIZADO PARA ENTRAR A SU VPS DE CASO CONTRARIO SI HAY IPES EXTRAÑAS PODRA BANEARLAS CON LA OPCION DE BANEAR IPES TAMBIEN SU PUERTO QUE USAN AKI EN ESTE LISTADO QUEDARAN TODAS LAS IPES LOGEADAS DE LAS QUE ENTRAN A SU VPS INCLUYENDO LA SUYA O CUALQUIER OTRA QUE USE\033[0m"
 echo ""
 sudo cat /var/log/auth* | grep Accepted | awk '{print $1 " " $2 "\t" $3 "\t" $11 "\t" $9 "\t" $12 "\t" $13}'
 echo ""
 echo -e "\E[0;37;44mBUSQUE LAS IPES QUE NO SON SUYAS Y BANEELAS EN LA OPCION DE BANEAR IPES PARA QUE NO PUEDA VOLVER A ENTRAR AL VPS SOLO IPES EXTRAÑAS NO BANEE LA DE SU VPS NI LA DE SUS USUARIOS NO PODRIA VOLVER A ENTRAR NI CONECTARCE A SU VPS SUS USUARIOS\033[0m"
 echo ""
 echo -e "\E[0;37;41m[4]-VOLVER\033[0m   ""\E[0;37;41m[15]-MENU-PRINCIPAL\033[0m"
 echo ""
 echo -ne "\E[0;37;41mOPCION\033[0m""\033[1;37m>>\033[0m "; read b
 case $b in
 1)
 ;;
 4)/root/jail.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 fi
 }
 
 echo -ne "\E[0;37;41mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 1)g
 ;;
 2)h
 ;;
 3)lt
 ;;
 4)j
 ;;
 15)/root/menu
 ;;
 5)m
 ;;
 6)p
 ;;
 esac
 clear
 exit
  