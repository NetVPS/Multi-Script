#!/bin/bash
 clear
 rm -rf /usr/bin/cuss.sh
 ln -s /root/cuss.sh /usr/bin/cuss.sh
 echo -e " \E[44;1;37mCUENTA SSH Y FECHA\033[0m"
 echo -ne "\033[1;32mNombre de usuario:\033[1;37m "; read usuario
 echo -ne "\033[1;32mContraseña:\033[1;37m "; read passwd
 echo -ne "\033[1;32mDias Para Expirar:\033[1;37m "; read dias
 echo -ne "\033[1;32mLímite de conexión:\033[1;37m "; read limiteconexion
 [ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo -e "\033[1;32mIP: \033[1;37m$IP" ; echo -e "\033[1;32mUsuário: \033[1;37m$usuario" ; echo -e "\033[1;32mContraseña: \033[1;37m$passwd" ; echo -e "\033[1;32mExpira en: \033[1;37m$gui" ; echo -e "\033[1;32mLimite de conexiónes: \033[1;37m$limiteconexion" ; echo "" || echo "No se pudo crear un usuario!" ; tput sgr0
 final=$(date "+%Y-%m-%d" -d "+$dias days")
 gui=$(date "+%d/%m/%Y" -d "+$dias days")
 pass=$(perl -e 'print crypt($ARGV[0], "passwd")' $passwd)
 sleep 0.5s
 useradd -e $final -M -s /bin/false -p $pass $usuario
 echo "$passwd" > /etc/SSHPlus/amor/$usuario
 echo "$usuario $limiteconexion " >> /root/usuarios.db
 clear
 o="$(ip addr | grep inet | grep -v inet6 | grep -v "host lo" | awk '{print $2}' | awk -F "/" '{print $1}')"
 echo -e "\E[41;1;37mCREADA CON EXITO\033[0m"
 [ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo -e "\033[1;32mIP:\033[1;37m$o \033[1;37m$IP" ; echo -e "\033[1;32mUsuário: \033[1;37m$usuario" ; echo -e "\033[1;32mContraseña: \033[1;37m$passwd" ; echo -e "\033[1;32mExpira en: \033[1;37m$gui" ; echo -e "\033[1;32mLimite de conexiónes: \033[1;37m$limiteconexion" ; echo "" || echo "No se pudo crear un usuario!" ; tput sgr0
 echo "#!/bin/bash
 userdel --force $usuario > /dev/null 2>&1
 rm /etc/SSHPlus/amor/$usuario
 rm -rf /etc/SSHPlus/amor/$usuario.sh
 exit" > /etc/SSHPlus/amor/$usuario.sh
 chmod +x /etc/SSHPlus/amor/$usuario.sh
 at -f /etc/SSHPlus/amor/$usuario.sh now + 3 $dias > /dev/null 2>&1
 echo -e "\E[44;1;37mA SIDO CREADA ESCRIVE 1 PARA AUTOVOLVER\033[0m               " "\033[1;33m\033[2;33m\E[41;1;37m[15]-MENU PRINCIPAL\033[0m"
 echo -e "\E[44;1;37mA SIDO CREADA ESCRIVE 0 PARA SALIR DE TODO\033[0m"
 while [ "$opcion" != "0" ]
 do
 read opcion
 case $opcion in
 
 1)/root/cuss.sh
 ;;
 15)/root/menu
 ;;
 esac
 exit
 done
  