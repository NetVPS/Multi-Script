#!/bin/bash
# INSTALADO --- ACTULIZADO EL 12-01-2023 --By @Kalix1
clear && clear
colores="$(pwd)/colores"
rm -rf ${colores}
wget -O ${colores} "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Otros/colores" &>/dev/null
[[ ! -e ${colores} ]] && exit
chmod +x ${colores} &>/dev/null
source ${colores}
CTRL_C() {
  rm -rf ${colores}
  rm -rf /root/LATAM
  exit
}
trap "CTRL_C" INT TERM EXIT
#rm $(pwd)/$0 &>/dev/null
#-- VERIFICAR ROOT
if [ $(whoami) != 'root' ]; then
  echo ""
  echo -e "\e[1;31m NECESITAS SER USER ROOT PARA EJECUTAR EL SCRIPT \n\n\e[97m                DIGITE: \e[1;32m sudo su\n"
  exit
fi
os_system() {
  system=$(cat -n /etc/issue | grep 1 | cut -d ' ' -f6,7,8 | sed 's/1//' | sed 's/      //')
  distro=$(echo "$system" | awk '{print $1}')

  case $distro in
  Debian) vercion=$(echo $system | awk '{print $3}' | cut -d '.' -f1) ;;
  Ubuntu) vercion=$(echo $system | awk '{print $2}' | cut -d '.' -f1,2) ;;
  esac
}
repo() {
  link="https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Source-List/$1.list"
  case $1 in
  8 | 9 | 10 | 11 | 16.04 | 18.04 | 20.04 | 20.10 | 21.04 | 21.10 | 22.04) wget -O /etc/apt/sources.list ${link} &>/dev/null ;;
  esac
}
## PRIMER PASO DE INSTALACION
install_inicial() {
  clear && clear
  #--VERIFICAR IP MANUAL
  tu_ip() {
    echo ""
    echo -ne "\e[1;96m #Digite tu IP Publica (IPV4): \e[32m" && read IP
    val_ip() {
      local ip=$IP
      local stat=1
      if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
      fi
      return $stat
    }
    if val_ip $IP; then
      echo "$IP" >/root/.ssh/authrized_key.reg
    else
      echo ""
      echo -e "\e[31mLa IP Digitada no es valida, Verifiquela"
      echo ""
      sleep 5s
      fun_ip
    fi
  }
  #CONFIGURAR SSH-ROOT PRINCIPAL AMAZON, GOOGLE
  pass_root() {
    wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Otros/sshd_config >/dev/null 2>&1
    chmod +rwx /etc/ssh/sshd_config
    service ssh restart
    msgi -bar
    echo -ne "\e[1;97m DIGITE NUEVA CONTRASEÑA:  \e[1;31m" && read pass
    (
      echo $pass
      echo $pass
    ) | passwd root 2>/dev/null
    sleep 1s
    msgi -bar
    echo -e "\e[1;94m     CONTRASEÑA AGREGADA O EDITADA CORECTAMENTE"
    echo -e "\e[1;97m TU CONTRASEÑA ROOT AHORA ES: \e[41m $pass \e[0;37m"

  }
  #-- VERIFICAR VERSION
  v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Vercion")
  echo "$v1" >/etc/version_instalacion
  v22=$(cat /etc/version_instalacion)
  vesaoSCT="\e[1;31m [ \e[1;32m( $v22 )\e[1;97m\e[1;31m ]"
  #-- CONFIGURACION BASICA
  os_system
  repo "${vercion}"
  msgi -bar2
  echo -e " \e[5m\e[1;100m   =====>> ►►     MULTI SCRIPT     ◄◄ <<=====    \e[1;37m"
  msgi -bar2
  #-- VERIFICAR VERSION
  msgi -ama "   PREPARANDO INSTALACION | VERSION: $vesaoSCT"
  ## PAQUETES-UBUNTU PRINCIPALES
  echo ""
  echo -e "\e[1;97m         🔎 IDENTIFICANDO SISTEMA OPERATIVO"
  echo -e "\e[1;32m                 | $distro $vercion |"
  echo ""
  echo -e "\e[1;97m        ◽️ DESACTIVANDO PASS ALFANUMERICO "
  [[ $(dpkg --get-selections | grep -w "libpam-cracklib" | head -1) ]] || barra_intallb "apt-get install libpam-cracklib -y &>/dev/null"
  echo -e '# Modulo Pass Simple
password [success=1 default=ignore] pam_unix.so obscure sha512
password requisite pam_deny.so
password required pam_permit.so' >/etc/pam.d/common-password && chmod +x /etc/pam.d/common-password
  [[ $(dpkg --get-selections | grep -w "libpam-cracklib" | head -1) ]] && barra_intallb "date"
  service ssh restart > /dev/null 2>&1 
  echo ""
  msgi -bar2
  fun_ip() {
    TUIP=$(wget -qO- ifconfig.me)
    echo "$TUIP" >/root/.ssh/authrized_key.reg
    echo -e "\e[1;97m ESTA ES TU IP PUBLICA? \e[32m$TUIP"
    msgi -bar2
    echo -ne "\e[1;97m Seleccione  \e[1;31m[\e[1;93m S \e[1;31m/\e[1;93m N \e[1;31m]\e[1;97m: \e[1;93m" && read tu_ip
    #read -p " Seleccione [ S / N ]: " tu_ip
    [[ "$tu_ip" = "n" || "$tu_ip" = "N" ]] && tu_ip
  }
  fun_ip
  msgi -bar2
  echo -e "\e[1;93m             AGREGAR Y EDITAR PASS ROOT\e[1;97m"
  msgi -bar
  echo -e "\e[1;97m CAMBIAR PASS ROOT? \e[32m"
  msgi -bar2
  echo -ne "\e[1;97m Seleccione  \e[1;31m[\e[1;93m S \e[1;31m/\e[1;93m N \e[1;31m]\e[1;97m: \e[1;93m" && read pass_root
  #read -p " Seleccione [ S / N ]: " tu_ip
  [[ "$pass_root" = "s" || "$pass_root" = "S" ]] && pass_root
  msgi -bar2
  echo -e "\e[1;93m\a\a\a      SE PROCEDERA A INSTALAR LAS ACTULIZACIONES\n PERTINENTES DEL SISTEMA, ESTE PROCESO PUEDE TARDAR\n VARIOS MINUTOS Y PUEDE PEDIR ALGUNAS CONFIRMACIONES \e[0;37m"
  msgi -bar
  read -t 120 -n 1 -rsp $'\e[1;97m           Preciona Enter Para continuar\n'
  clear && clear
  apt update
  apt upgrade -y
  wget -O /usr/bin/install https://raw.githubusercontent.com/NetVPS/Multi-Script/main/0-Instalador/install.sh &>/dev/null
  chmod +rwx /usr/bin/install
}

time_reboot() {
  clear && clear
  msgi -bar
  echo -e "\e[1;93m     CONTINUARA INSTALACION DESPUES DEL REBOOT"
  echo -e "\e[1;93m         O EJECUTE EL COMANDO: \e[1;92mLATAM -c "
  msgi -bar
  REBOOT_TIMEOUT="$1"
  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  reboot
}

dependencias() {
  dpkg --configure -a >/dev/null 2>&1
  apt -f install -y >/dev/null 2>&1
  soft="sudo bsdmainutils zip unzip ufw curl python python3 python3-pip openssl cron iptables lsof pv boxes at mlocate gawk bc jq curl npm nodejs socat netcat netcat-traditional net-tools cowsay figlet lolcat apache2"
  for i in $soft; do
    paquete="$i"
    echo -e "\e[1;97m INSTALANDO PAQUETE \e[93m >>> \e[36m $i"
    barra_intall "apt-get install $i -y"
  done
}

install_paquetes() {
  clear && clear
  /bin/cp /etc/skel/.bashrc ~/
  #------- BARRA DE ESPERA
  msgi -bar2
  echo -e " \e[5m\e[1;100m   =====>> ►►     MULTI SCRIPT     ◄◄ <<=====    \e[1;37m"
  msgi -bar
  echo -e "  \e[1;41m      -- INSTALACION DE PAQUETES MULTI --      \e[49m"
  msgi -bar
  dependencias
  sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf >/dev/null 2>&1
  service apache2 restart >/dev/null 2>&1
  [[ $(sudo lsof -i :81) ]] || ESTATUSP=$(echo -e "\e[1;91m      >>>  FALLO DE INSTALACION EN APACHE <<<") &>/dev/null
  [[ $(sudo lsof -i :81) ]] && ESTATUSP=$(echo -e "\e[1;92m          PUERTO APACHE ACTIVO CON EXITO") &>/dev/null
  echo ""
  echo -e "$ESTATUSP"
  echo ""
  echo -e "\e[1;97m        REMOVIENDO PAQUETES OBSOLETOS - \e[1;32m OK"
  apt autoremove -y &>/dev/null
  echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
  echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
  msgi -bar2
  read -t 30 -n 1 -rsp $'\e[1;97m           Preciona Enter Para continuar\n'
}

#SELECTOR DE INSTALACION
while :; do
  case $1 in
  -s | --start)
    install_inicial && install_paquetes
    break
    ;;
  -c | --continue)
    install_paquetes
    break
    ;;
  -m | --menu)
    break
    ;;
  *) exit ;;
  esac
done

#VPS-MX 8.5 OFICIAL
install_vps_mx_85_oficial() {
  clear && clear
  msgi -bar2
  echo -ne "\033[1;97m Digite su slogan: \033[1;32m" && read slogan
  tput cuu1 && tput dl1
  echo -e "$slogan"
  msgi -bar2
  clear && clear
  mkdir /etc/VPS-MX >/dev/null 2>&1
  cd /etc
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/VPS-MX-8.5-Final%20Oficial/VPS-MX.tar.xz >/dev/null 2>&1
  tar -xf VPS-MX.tar.xz >/dev/null 2>&1
  chmod +x VPS-MX.tar.xz >/dev/null 2>&1
  rm -rf VPS-MX.tar.xz
  cd
  chmod -R 755 /etc/VPS-MX
  rm -rf /etc/VPS-MX/MEUIPvps
  echo "/etc/VPS-MX/menu" >/usr/bin/menu && chmod +x /usr/bin/menu
  echo "/etc/VPS-MX/menu" >/usr/bin/VPSMX && chmod +x /usr/bin/VPSMX
  echo "$slogan" >/etc/VPS-MX/message.txt
  [[ ! -d /usr/local/lib ]] && mkdir /usr/local/lib
  [[ ! -d /usr/local/lib/ubuntn ]] && mkdir /usr/local/lib/ubuntn
  [[ ! -d /usr/local/lib/ubuntn/apache ]] && mkdir /usr/local/lib/ubuntn/apache
  [[ ! -d /usr/local/lib/ubuntn/apache/ver ]] && mkdir /usr/local/lib/ubuntn/apache/ver
  [[ ! -d /usr/share ]] && mkdir /usr/share
  [[ ! -d /usr/share/mediaptre ]] && mkdir /usr/share/mediaptre
  [[ ! -d /usr/share/mediaptre/local ]] && mkdir /usr/share/mediaptre/local
  [[ ! -d /usr/share/mediaptre/local/log ]] && mkdir /usr/share/mediaptre/local/log
  [[ ! -d /usr/share/mediaptre/local/log/lognull ]] && mkdir /usr/share/mediaptre/local/log/lognull
  [[ ! -d /etc/VPS-MX/B-VPS-MXuser ]] && mkdir /etc/VPS-MX/B-VPS-MXuser
  [[ ! -d /usr/local/protec ]] && mkdir /usr/local/protec
  [[ ! -d /usr/local/protec/rip ]] && mkdir /usr/local/protec/rip
  [[ ! -d /etc/protecbin ]] && mkdir /etc/protecbin
  cd
  [[ ! -d /etc/VPS-MX/v2ray ]] && mkdir /etc/VPS-MX/v2ray
  [[ ! -d /etc/VPS-MX/Slow ]] && mkdir /etc/VPS-MX/Slow
  [[ ! -d /etc/VPS-MX/Slow/install ]] && mkdir /etc/VPS-MX/Slow/install
  [[ ! -d /etc/VPS-MX/Slow/Key ]] && mkdir /etc/VPS-MX/Slow/Key
  touch /usr/share/lognull &>/dev/null
  wget -O /bin/resetsshdrop https://raw.githubusercontent.com/NetVPS/Multi-Script/main/VPS-MX-8.5-Final%20Oficial/Otros/resetsshdrop &>/dev/null
  chmod +x /bin/resetsshdrop
  grep -v "^PasswordAuthentication" /etc/ssh/sshd_config >/tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
  echo "PasswordAuthentication yes" -e "\e[1;92m             >> INSTALACION COMPLETADA <<" >>/etc/ssh/sshd_configecho && msgi -bar2
  rm -rf /usr/local/lib/systemubu1 &>/dev/null
  rm -rf /etc/versin_script &>/dev/null
  v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/VPS-MX-8.5-Final%20Oficial/Otros/Version")
  echo "$v1" >/etc/versin_script
  wget -O /etc/versin_script_new https://raw.githubusercontent.com/NetVPS/Multi-Script/main/VPS-MX-8.5-Final%20Oficial/Otros/Version &>/dev/null
  echo '#!/bin/sh -e' >/etc/rc.local
  sudo chmod +x /etc/rc.local
  echo "sudo resetsshdrop" >>/etc/rc.local
  echo "sleep 2s" >>/etc/rc.local
  echo "exit 0" >>/etc/rc.local
  echo 'clear' >>.bashrc
  echo 'echo ""' >>.bashrc
  echo 'echo -e "\t\033[91m __     ______  ____        __  ____  __ " ' >>.bashrc
  echo 'echo -e "\t\033[91m \ \   / /  _ \/ ___|      |  \/  \ \/ / " ' >>.bashrc
  echo 'echo -e "\t\033[91m  \ \ / /| |_) \___ \ _____| |\/| |\  /  " ' >>.bashrc
  echo 'echo -e "\t\033[91m   \ V / |  __/ ___) |_____| |  | |/  \  " ' >>.bashrc
  echo 'echo -e "\t\033[91m    \_/  |_|   |____/      |_|  |_/_/\_\ " ' >>.bashrc
  echo 'wget -O /etc/versin_script_new https://raw.githubusercontent.com/NetVPS/Multi-Script/main/VPS-MX-8.5-Final%20Oficial/Otros/Version &>/dev/null' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'mess1="$(less /etc/VPS-MX/message.txt)" ' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\t\033[92mRESELLER : $mess1 "' >>.bashrc
  echo 'echo -e "\t\e[1;33mVERSION: \e[1;31m$(cat /etc/versin_script_new)"' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\t\033[97mPARA MOSTAR PANEL BASH ESCRIBA: sudo VPSMX o menu "' >>.bashrc
  echo 'echo ""' >>.bashrc
  rm -rf /usr/bin/pytransform &>/dev/null
  rm -rf VPS-MX.sh
  rm -rf lista-arq
  service ssh restart &>/dev/null
  clear && clear
  msgi -bar2
  echo -e "\e[1;92m             >> INSTALACION COMPLETADA <<" && msgi -bar2
  echo -e "      COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
  echo -e "                      \033[1;41m  menu  \033[0;37m" && msgi -bar2

}

#LACASITA V9
install_LACASITA_90() {
  clear && clear
  msgi -bar2
  echo -ne "\033[1;97m Digite su slogan: \033[1;32m" && read slogan
  tput cuu1 && tput dl1
  echo -e "$slogan"
  msgi -bar2
  clear && clear
  mkdir /etc/VPS-MX >/dev/null 2>&1
  cd /etc
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/VPS-MX.tar.gz >/dev/null 2>&1
  tar -xf VPS-MX.tar.gz >/dev/null 2>&1
  chmod +x VPS-MX.tar.gz >/dev/null 2>&1
  rm -rf VPS-MX.tar.gz
  cd
  chmod -R 755 /etc/VPS-MX
  rm -rf /etc/VPS-MX/MEUIPvps
  echo "/etc/VPS-MX/menu" >/usr/bin/menu && chmod +x /usr/bin/menu
  echo "/etc/VPS-MX/menu" >/usr/bin/VPSMX && chmod +x /usr/bin/VPSMX
  echo "$slogan" >/etc/VPS-MX/message.txt
  #UNLOKERS
  [[ ! -d /usr/local/lib ]] && mkdir /usr/local/lib
  [[ ! -d /usr/local/lib/ubuntn ]] && mkdir /usr/local/lib/ubuntn
  [[ ! -d /usr/local/lib/ubuntn/apache ]] && mkdir /usr/local/lib/ubuntn/apache
  [[ ! -d /usr/local/lib/ubuntn/apache/ver ]] && mkdir /usr/local/lib/ubuntn/apache/ver
  [[ ! -d /usr/share ]] && mkdir /usr/share
  [[ ! -d /usr/share/mediaptre ]] && mkdir /usr/share/mediaptre
  [[ ! -d /usr/share/mediaptre/local ]] && mkdir /usr/share/mediaptre/local
  [[ ! -d /usr/share/mediaptre/local/log ]] && mkdir /usr/share/mediaptre/local/log
  [[ ! -d /usr/share/mediaptre/local/log/lognull ]] && mkdir /usr/share/mediaptre/local/log/lognull
  [[ ! -d /etc/VPS-MX/B-VPS-MXuser ]] && mkdir /etc/VPS-MX/B-VPS-MXuser
  [[ ! -d /usr/local/megat ]] && mkdir /usr/local/megat
  [[ ! -d /usr/local/include ]] && mkdir /usr/local/include
  [[ ! -d /usr/local/include/snaps ]] && mkdir /usr/local/include/snaps
  [[ ! -d /usr/local/lib/sped ]] && mkdir /usr/local/lib/sped
  [[ ! -d /usr/local/lib/rm ]] && mkdir /usr/local/lib/rm
  [[ ! -d /usr/local/libreria ]] && mkdir /usr/local/libreria
  [[ ! -d /usr/local/lib/rm ]] && mkdir /usr/local/lib/rm
  cd /etc/VPS-MX/herramientas
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/VPS-MX.tar.gz >/dev/null 2>&1
  tar -xf speedtest_v1.tar >/dev/null 2>&1
  rm -rf speedtest_v1.tar >/dev/null 2>&1
  cd
  [[ ! -d /etc/VPS-MX/v2ray ]] && mkdir /etc/VPS-MX/v2ray
  [[ ! -d /etc/VPS-MX/Slow ]] && mkdir /etc/VPS-MX/Slow
  [[ ! -d /etc/VPS-MX/Slow/install ]] && mkdir /etc/VPS-MX/Slow/install
  [[ ! -d /etc/VPS-MX/Slow/Key ]] && mkdir /etc/VPS-MX/Slow/Key
  touch /usr/share/lognull &>/dev/null
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/SPR -O /usr/bin/SPR &>/dev/null &>/dev/null
  chmod 775 /usr/bin/SPR &>/dev/null
  wget -O /bin/rebootnb https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/rebootnb &>/dev/null
  chmod +x /bin/rebootnb
  wget -O /bin/resetsshdrop https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/resetsshdrop &>/dev/null
  chmod +x /bin/resetsshdrop
  wget -O /etc/versin_script_new https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/Version &>/dev/null
  wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/sshd &>/dev/null
  chmod 777 /etc/ssh/sshd_config
  wget -O /usr/bin/trans https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/trans &>/dev/null
  wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/desbloqueo.sh &>/dev/null
  chmod +x /bin/Desbloqueo.sh
  wget -O /bin/monitor.sh https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/monitor.sh &>/dev/null
  chmod +x /bin/monitor.sh
  wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/estilos.css &>/dev/null
  [[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp &>/dev/null
  ufw allow 80/tcp &>/dev/null
  ufw allow 3128/tcp &>/dev/null
  ufw allow 8799/tcp &>/dev/null
  ufw allow 8080/tcp &>/dev/null
  ufw allow 81/tcp &>/dev/null
  grep -v "^PasswordAuthentication" /etc/ssh/sshd_config >/tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
  echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config
  rm -rf /usr/local/lib/systemubu1 &>/dev/null
  rm -rf /etc/versin_script &>/dev/null
  v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/Version")
  echo "$v1" >/etc/versin_script
  wget -O /etc/versin_script_new https://raw.githubusercontent.com/NetVPS/Multi-Script/main/LACASITAMX-v9x/Otros/Version &>/dev/null
  echo '#!/bin/sh -e' >/etc/rc.local
  sudo chmod +x /etc/rc.local
  echo "sudo rebootnb" >>/etc/rc.local
  echo "sudo resetsshdrop" >>/etc/rc.local
  echo "sleep 2s" >>/etc/rc.local
  echo "exit 0" >>/etc/rc.local
  /bin/cp /etc/skel/.bashrc ~/
  echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/' >>/etc/profile
  echo 'clear' >>.bashrc
  echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/' >>.bashrc
  echo 'echo ""' >>.bashrc
  #
  echo 'figlet -f slant "LACASITA" |lolcat' >>.bashrc
  echo 'mess1="$(less /etc/VPS-MX/message.txt)" ' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\t\033[92mRESELLER : $mess1 "' >>.bashrc
  echo 'echo -e "\t\e[1;33mVERSION: \e[1;31m$(cat /etc/versin_script_new)"' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\t\033[1;100mPARA MOSTAR PANEL BASH ESCRIBA:\e[0m\e[1;41m sudo menu \e[0m"' >>.bashrc
  echo 'echo ""' >>.bashrc
  rm -rf /usr/bin/pytransform &>/dev/null
  rm -rf LACASITA.sh
  rm -rf lista-arq
  [[ ! -e /etc/autostart ]] && {
    echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
    chmod +x /etc/autostart
  } || {
    #[[ $(ps x | grep "bot_plus" | grep -v grep | wc -l) != '0' ]] && wget -qO- https://raw.githubusercontent.com/carecagm/main/Install/ShellBot.sh >/etc/SSHPlus/ShellBot.sh
    for proc in $(ps x | grep 'dmS' | grep -v 'grep' | awk {'print $1'}); do
      screen -r -S "$proc" -X quit
    done
    screen -wipe >/dev/null
    echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
    chmod +x /etc/autostart
  }
  crontab -r >/dev/null 2>&1
  (
    crontab -l 2>/dev/null
    echo "@reboot /etc/autostart"
    echo "* * * * * /etc/autostart"
  ) | crontab -
  service ssh restart &>/dev/null
  export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
  rm -rf /usr/bin/pytransform &>/dev/null
  rm -rf VPS-MX.sh
  rm -rf lista-arq
  service ssh restart &>/dev/null
  clear && clear
  msgi -bar2
  echo -e "\e[1;92m             >> INSTALACION COMPLETADA <<" && msgi -bar2
  echo -e "      COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
  echo -e "                      \033[1;41m  menu  \033[0;37m" && msgi -bar2

}
#ADMRufus
install_ADMRufu() {
  clear && clear
  msgi -bar2
  echo -ne "\033[1;97m Digite su slogan: \033[1;32m" && read slogan
  tput cuu1 && tput dl1
  echo -e "$slogan"
  msgi -bar2
  clear && clear
  mkdir /etc/ADMRufu >/dev/null 2>&1
  cd /etc
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/R9/ADMRufu.tar.xz >/dev/null 2>&1
  tar -xf ADMRufu.tar.xz >/dev/null 2>&1
  chmod +x ADMRufu.tar.xz >/dev/null 2>&1
  rm -rf ADMRufu.tar.xz
  cd
  chmod -R 755 /etc/ADMRufu
  ADMRufu="/etc/ADMRufu" && [[ ! -d ${ADMRufu} ]] && mkdir ${ADMRufu}
  ADM_inst="${ADMRufu}/install" && [[ ! -d ${ADM_inst} ]] && mkdir ${ADM_inst}
  SCPinstal="$HOME/install"
  rm -rf /usr/bin/menu
  rm -rf /usr/bin/adm
  rm -rf /usr/bin/ADMRufu
  echo "$slogan" >/etc/ADMRufu/tmp/message.txt
  echo "${ADMRufu}/menu" >/usr/bin/menu && chmod +x /usr/bin/menu
  echo "${ADMRufu}/menu" >/usr/bin/adm && chmod +x /usr/bin/adm
  echo "${ADMRufu}/menu" >/usr/bin/ADMRufu && chmod +x /usr/bin/ADMRufu
  [[ -z $(echo $PATH | grep "/usr/games") ]] && echo 'if [[ $(echo $PATH|grep "/usr/games") = "" ]]; then PATH=$PATH:/usr/games; fi' >>/etc/bash.bashrc
  echo '[[ $UID = 0 ]] && screen -dmS up /etc/ADMRufu/chekup.sh' >>/etc/bash.bashrc
  echo 'v=$(cat /etc/ADMRufu/vercion)' >>/etc/bash.bashrc
  echo '[[ -e /etc/ADMRufu/new_vercion ]] && up=$(cat /etc/ADMRufu/new_vercion) || up=$v' >>/etc/bash.bashrc
  echo -e "[[ \$(date '+%s' -d \$up) -gt \$(date '+%s' -d \$(cat /etc/ADMRufu/vercion)) ]] && v2=\"Nueva Vercion disponible: \$v >>> \$up\" || v2=\"Script Vercion: \$v\"" >>/etc/bash.bashrc
  echo '[[ -e "/etc/ADMRufu/tmp/message.txt" ]] && mess1="$(less /etc/ADMRufu/tmp/message.txt)"' >>/etc/bash.bashrc
  echo '[[ -z "$mess1" ]] && mess1="@Rufu99"' >>/etc/bash.bashrc
  echo 'clear && echo -e "\n$(figlet -f big.flf "  ADMRufu")\n        RESELLER : $mess1 \n\n   Para iniciar ADMRufu escriba:  menu \n\n   $v2\n\n"|lolcat' >>/etc/bash.bashrc

  update-locale LANG=en_US.UTF-8 LANGUAGE=en
  clear && clear
  msgi -bar2
  echo -e "\e[1;92m             >> INSTALACION COMPLETADA <<" && msgi -bar2
  echo -e "      COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
  echo -e "                      \033[1;41m  menu  \033[0;37m" && msgi -bar2
}

#CHUMOGH
install_ChumoGH() {
  msgi -bar2
  clear && clear
  mkdir /etc/adm-lite >/dev/null 2>&1
  cd /etc
  wget https://raw.githubusercontent.com/NetVPS/Multi-Script/main/ChuGH-5.7u/adm-lite.tar.gz >/dev/null 2>&1
  tar -xf adm-lite.tar.gz >/dev/null 2>&1
  chmod +x adm-lite.tar.gz >/dev/null 2>&1
  rm -rf /etc/adm-lite.tar.gz
  cd
  chmod -R 755 /etc/adm-lite
  /bin/cp /etc/skel/.bashrc ~/
  rm -rf /etc/bash.bashrc >/dev/null 2>&1
  echo "$slogan" >/etc/adm-lite/menu_credito
  fecha=$(date +"%d-%m-%y")
  dom='base64 -d'
  SCPdir="/etc/adm-lite"
  SCPinstal="$HOME/install"
  SCPidioma="${SCPdir}"
  SCPusr="${SCPdir}"
  cd /etc/adm-lite
  echo "cd /etc/adm-lite && ./menu" >/bin/menu
  echo "cd /etc/adm-lite && ./menu" >/bin/cgh
  echo "cd /etc/adm-lite && ./menu" >/bin/adm
  chmod +x /bin/menu
  chmod +x /bin/cgh
  chmod +x /bin/adm
  cd $HOME
  echo ""
  rm -rf mkdir /bin/ejecutar >/dev/null
  [[ -e /etc/adm-lite/menu_credito ]] && ress="$(cat </etc/adm-lite/menu_credito) " || ress="NULL ( no found ) "
  chmod +x /etc/adm-lite/*
  [[ -e ${SCPinstal}/v-local.log ]] && vv="$(cat <${SCPinstal}/v-local.log)" || vv="NULL"
  #cd /etc/adm-lite && bash cabecalho --instalar
  echo "verify" >$(echo -e $(echo 2f62696e2f766572696679737973 | sed 's/../\\x&/g;s/$/ /'))
  fecha=$(date +"%d-%m-%y")

  [[ -d /bin/ejecutar ]] && rm -rf /bin/ejecutar
  [[ -e /etc/adm-lite/gerar.sh ]] && rm -f /etc/adm-lite/gerar.sh
  [[ -z $name ]] && {
    rm -f /root/name
  } || {
    echo $name >/etc/adm-lite/name
    chmod +x /etc/adm-lite/name
    echo $name >/root/name
  }
  opti=0

  /etc/adm-lite/cabecalho --instalar
  echo "verify" >$(echo -e $(echo 2f62696e2f766572696679737973 | sed 's/../\\x&/g;s/$/ /'))
  echo 'MOD @ChumoGH ChumoGHADM' >$(echo -e $(echo 2F7573722F6C69622F6C6963656E6365 | sed 's/../\\x&/g;s/$/ /'))

  echo "Verified【 ChumoGHADM  " >/bin/ejecutar/exito
  clear && clear
  msgi -bar2
  echo -e "\e[1;92m             >> INSTALACION COMPLETADA <<" && msgi -bar2
  echo -e "      COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
  echo -e "                      \033[1;41m  menu  \033[0;37m" && msgi -bar2
}

#SCRIPT LATAM 2.0
install_latam() {
  #CARPETAS PRINCIPALES
  mkdir -p /etc/SCRIPT-LATAM >/dev/null 2>&1
  mkdir -p /etc/SCRIPT-LATAM/temp >/dev/null 2>&1
  mkdir -p /etc/SCRIPT-LATAM/filespy >/dev/null 2>&1
  mkdir -p /etc/SCRIPT-LATAM/botmanager >/dev/null 2>&1
  mkdir -p /etc/SCRIPT-LATAM/PortM >/dev/null 2>&1
  mkdir -p /etc/SCRIPT-LATAM/v2ray >/dev/null 2>&1
  mkdir -p /root/.ssh >/dev/null 2>&1
  Install_key() {
    wget /root/LATAM https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Instalador/LATAM -O /usr/bin/LATAM &>/dev/null
    chmod +x /usr/bin/LATAM
    /bin/cp /etc/skel/.bashrc ~/
    clear && clear
    SCPdir="/etc/SCRIPT-LATAM"
    SCPinstal="$HOME/install"
    Filbot="${SCPdir}/botmanager"
    Filpy="${SCPdir}/filespy"
    Filotros="${SCPdir}/temp"
    IP=$(cat /root/.ssh/authrized_key.reg)
    function_verify() {
      permited=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Control-IP")
      [[ $(echo $permited | grep "${IP}") = "" ]] && {
        clear && clear
        echo -e "\n\n\n\e[1;91m————————————————————————————————————————————————————\n      ¡ESTA KEY NO CONCUERDA CON EL INSTALADOR! \n                 CONATACTE A @Kalix1\n————————————————————————————————————————————————————\n\n\n"
        # [[ -d /etc/SCRIPT-LATAM ]] && rm -rf /etc/SCRIPT-LATAM
        exit 1
      } || {
        ### INSTALAR VERSION DE SCRIPT
        v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version")
        echo "$v1" >/etc/SCRIPT-LATAM/temp/version_instalacion
        FIns=$(printf '%(%D-%H:%M:%S)T')
        echo "$FIns" >/etc/SCRIPT-LATAM/F-Instalacion
      }
    }
    fun_idi() {
      clear && clear
      msgi -bar2
      echo -e "\e[1;32m————————————————————————————————————————————————————"
      figlet -w 85 -f smslant "         SCRIPT
         LATAM  " | lolcat
      msgi -ama "          [ ----- \e[1;97m 🐲 By @Kalix1 🐲\e[1;33m ----- ]"
      echo -e "\e[1;32m————————————————————————————————————————————————————"
      pv="$(echo es)"
      [[ ${#id} -gt 2 ]] && id="es" || id="$pv"
      byinst="true"
    }
    install_fim() {
      echo -e "               \e[1;4;32mFinalizando Instalacion\e[0;39m"
      wget -O /bin/rebootnb https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/rebootnb.sh &>/dev/null
      chmod +x /bin/rebootnb
      wget -O /etc/SCRIPT-LATAM/temp/version_actual https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version &>/dev/null
      msgi -bar2
      echo '#!/bin/sh -e' >/etc/rc.local
      sudo chmod +x /etc/rc.local
      echo "sudo rebootnb reboot" >>/etc/rc.local
      echo "sleep 2s" >>/etc/rc.local
      echo "exit 0" >>/etc/rc.local
      echo 'clear && clear' >>.bashrc
      echo 'rebootnb login >/dev/null 2>&1' >>.bashrc
      echo 'echo -e "\e[1;31m————————————————————————————————————————————————————" ' >>.bashrc
      echo 'echo -e "\e[1;93m════════════════════════════════════════════════════" ' >>.bashrc
      echo 'sudo figlet -w 85 -f smslant "         SCRIPT
         LATAM"   | lolcat' >>.bashrc
      echo 'echo -e "\e[1;93m════════════════════════════════════════════════════" ' >>.bashrc
      echo 'echo -e "\e[1;31m————————————————————————————————————————————————————" ' >>.bashrc
      echo 'mess1="$(less -f /etc/SCRIPT-LATAM/message.txt)" ' >>.bashrc
      echo 'echo "" ' >>.bashrc
      echo 'echo -e "\e[92m  -->> SLOGAN:\e[93m $mess1 "' >>.bashrc
      echo 'echo "" ' >>.bashrc
      echo 'echo -e "\e[1;97m ❗️ PARA MOSTAR PANEL BASH ESCRIBA ❗️\e[92m menu "' >>.bashrc
      echo 'wget -O /etc/SCRIPT-LATAM/temp/version_actual https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version &>/dev/null' >>.bashrc
      echo 'echo ""' >>.bashrc
      #-BASH SOPORTE ONLINE
      wget https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Fixs%20Remotos/SPR.sh -O /usr/bin/SPR >/dev/null 2>&1
      chmod +x /usr/bin/SPR
      SPR >/dev/null 2>&1
      timeespera="1"
      times="10"
      if [ "$timeespera" = "1" ]; then
        echo -e "\e[1;97m         ❗️ REGISTRANDO IP y KEY EN LA BASE ❗️            "
        msgi -bar2
        while [ $times -gt 0 ]; do
          echo -ne "                         -$times-\e[0K\r"
          sleep 1
          : $((times--))
        done
        tput cuu1 && tput dl1
        tput cuu1 && tput dl1
        tput cuu1 && tput dl1
        msgi -bar2
        echo -e " \e[1;92m              LISTO REGISTRO COMPLETO "
        echo -e " \e[1;97m       COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
        echo -e " \e[1;41m                    menu o MENU                   \e[0;37m" && msgi -bar2
      fi
      meu_ip() {
        if [[ -e /tmp/IP ]]; then
          echo "$(cat /tmp/IP)"
        else
          MEU_IP=$(wget -qO- ifconfig.me)
          echo "$MEU_IP" >/tmp/IP
        fi
      }
      meu_ip
      exit
    }
    ofus() {
      unset server
      server=$(echo ${txt_ofuscatw} | cut -d':' -f1)
      unset txtofus
      number=$(expr length $1)
      for ((i = 1; i < $number + 1; i++)); do
        txt[$i]=$(echo "$1" | cut -b $i)
        case ${txt[$i]} in
        ".") txt[$i]="v" ;;
        "v") txt[$i]="." ;;
        "1") txt[$i]="@" ;;
        "@") txt[$i]="1" ;;
        "2") txt[$i]="?" ;;
        "?") txt[$i]="2" ;;
        "4") txt[$i]="p" ;;
        "p") txt[$i]="4" ;;
        "-") txt[$i]="L" ;;
        "L") txt[$i]="-" ;;
        esac
        txtofus+="${txt[$i]}"
      done
      echo "$txtofus" | rev
    }
    verificar_arq() {
      case $1 in
      "menu.sh" | "message.txt") ARQ="${SCPdir}/" ;;
      "LATAMbot.sh") ARQ="${Filbot}/" ;;
      "PDirect.py" | "PPub.py" | "PPriv.py" | "POpen.py" | "PGet.py") ARQ="${Filpy}/" ;;
      *) ARQ="${Filotros}/" ;;
      esac
      mv -f ${SCPinstal}/$1 ${ARQ}/$1
      chmod +x ${ARQ}/$1
    }
    #fun_ip
    [[ $1 = "" ]] && fun_idi || {
      [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
    }
    error_fun() {
      msgi -bar2
      msgi -bar2
      sleep 3s
      clear && clear
      echo "Codificacion Incorrecta" >/etc/SCRIPT-LATAM/errorkey
      msgi -bar2
      [[ $1 = "" ]] && fun_idi || {
        [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
      }
      echo -e "\e[1;31m               ¡# ERROR INESPERADO #¡\n          ESTA KEY YA FUE USADA O EXPIRO "
      echo -e "\e[0;93m    -SI EL ERROR PERCISTE REVISAR PUERTO 81 TCP -"
      msgi -bar2
      echo -ne "\e[1;97m DESEAS REINTENTAR CON OTRA KEY  \e[1;31m[\e[1;93m S \e[1;31m/\e[1;93m N \e[1;31m]\e[1;97m: \e[1;93m" && read incertar_key
      service apache2 restart >/dev/null 2>&1
      [[ "$incertar_key" = "s" || "$incertar_key" = "S" ]] && incertar_key
      clear && clear
      msgi -bar2
      msgi -bar2
      rm -rf lista-arq
      echo -e "\e[1;97m          ---- INSTALACION CANCELADA  -----"
      msgi -bar2
      msgi -bar2
      exit 1
    }
    invalid_key() {
      msgi -bar2
      msgi -bar2
      sleep 3s
      clear && clear
      echo "Codificacion Incorrecta" >/etc/SCRIPT-LATAM/errorkey
      msgi -bar2
      [[ $1 = "" ]] && fun_idi || {
        [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
      }
      echo -e "\e[1;31m    CIFRADO INVALIDO -- #¡La Key fue Invalida#! "
      msgi -bar2
      echo -ne "\e[1;97m DESEAS REINTENTAR CON OTRA KEY  \e[1;31m[\e[1;93m S \e[1;31m/\e[1;93m N \e[1;31m]\e[1;93m: \e[1;93m" && read incertar_key
      [[ "$incertar_key" = "s" || "$incertar_key" = "S" ]] && incertar_key
      clear && clear
      msgi -bar2
      msgi -bar2
      echo -e "\e[1;97m          ---- INSTALACION CANCELADA  -----"
      msgi -bar2
      msgi -bar2
      exit 1
    }

    incertar_key() {

      [[ -d /etc/SCRIPT-LATAM/errorkey ]] && rm -rf /etc/SCRIPT-LATAM/errorkey >/dev/null 2>&1
      echo "By Kalix1" >/etc/SCRIPT-LATAM/errorkey
      msgi -bar2
      echo -ne "\e[1;93m       OBTEN DOS KEYS FREE AL DIA EN EL BOT \n           \e[1;97m https://t.me/Panel_NetVPS_bot\n\n"
      echo -ne "\e[1;96m          >>> INTRODUZCA LA KEY ABAJO <<<\n\e[1;31m   " && read Key
      [[ -z "$Key" ]] && Key="NULL"
      tput cuu1 && tput dl1
      msgi -ne "    \e[1;93m# Verificando Key # : "
      cd $HOME
      IPL=$(cat /root/.ssh/authrized_key.reg)
      wget -O $HOME/lista-arq $(ofus "$Key")/$IPL >/dev/null 2>&1 && echo -e "\e[1;32m Codificacion Correcta" || {
        echo -e "\e[1;31m Codificacion Incorrecta"
        invalid_key
        exit
      }
      IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" >/usr/bin/vendor_code
      sleep 1s
      function_verify
      updatedb
      if [[ -e $HOME/lista-arq ]] && [[ ! $(cat /etc/SCRIPT-LATAM/errorkey | grep "Codificacion Incorrecta") ]]; then
        msgi -bar2
        msgi -verd " Ficheros Copiados \e[97m[\e[93m Key By @Panel_NetVPS_bot \e[97m]"
        REQUEST=$(ofus "$Key" | cut -d'/' -f2)
        [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
        pontos="."
        stopping="Configurando Directorios"
        for arqx in $(cat $HOME/lista-arq); do
          msgi -verm "${stopping}${pontos}"
          wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} >/dev/null 2>&1 && verificar_arq "${arqx}" || {
            error_fun
            exit
          }
          tput cuu1 && tput dl1
          pontos+="."
        done
        sleep 1s
        msgi -bar2
        listaarqs="$(locate "lista-arq" | head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs
        cat /etc/bash.bashrc | grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >/etc/bash.bashrc.2
        echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >>/etc/bash.bashrc.2
        mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
        echo "${SCPdir}/menu.sh" >/usr/bin/menu && chmod +x /usr/bin/menu
        echo "${SCPdir}/menu.sh" >/usr/bin/MENU && chmod +x /usr/bin/MENU
        echo "$Key" >${SCPdir}/key.txt
        [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
        [[ ${byinst} = "true" ]] && install_fim
      else
        invalid_key
      fi
    }
    incertar_key
  }
  Install_key
}
#MENUS
clear && clear
/bin/cp /etc/skel/.bashrc ~/
/bin/cp /etc/skel/.bashrc /etc/bash.bashrc
msgi -bar2
echo -e " \e[5m\e[1;100m   =====>> ►►  MENU DE INSTALACION  ◄◄ <<=====   \e[1;37m"
msgi -bar2
#-- VERIFICAR VERSION
v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Vercion")
echo "$v1" >/etc/version_instalacion
v22=$(cat /etc/version_instalacion)
vesaoSCT="\e[1;31m [ \e[1;32m( $v22 )\e[1;97m\e[1;31m ]"
msgi -ama "   PREPARANDO INSTALACION | VERSION: $vesaoSCT"
msgi -bar2
echo -ne "\e[1;93m [\e[1;32m1\e[1;93m]\e[1;31m >\e[1;97m VPS-MX FINAL OFICIAL..(8.5)  \e[1;31m 🎁 FREE \e[97m \n"
echo -ne "\e[1;93m [\e[1;32m2\e[1;93m]\e[1;31m >\e[1;97m LACASITAMX............(9X)   \e[1;31m 🎁 FREE \e[97m \n"
echo -ne "\e[1;93m [\e[1;32m3\e[1;93m]\e[1;31m >\e[1;97m ADMRufu                      \e[1;31m 🎁 FREE OLD vercion\e[97m \n"
echo -ne "\e[1;93m [\e[1;32m4\e[1;93m]\e[1;31m >\e[1;97m ChumoGH...............(5.7u) \e[1;31m 🎁 FREE \e[97m \n"
echo -ne "\e[1;93m [\e[1;32m5\e[1;93m]\e[1;31m >\e[1;97m LATAM.................(2.0)  \e[1;96m 💎 VIP\e[97m \n"
msgi -bar2
echo -ne "\e[1;93m [\e[1;32m ARCHIVOS Y LINKS TOTALMENTE ABIERTOS Y PUBLICOS \e[1;93m]\e[1;96m\n       https://github.com/NetVPS/Multi-Script\e[97m \n"
msgi -bar2
echo -ne "\e[1;97mDigite solo el numero segun su respuesta:\e[32m "
read opcao
case $opcao in
1)
  install_vps_mx_85_oficial
  ;;
2)
  install_LACASITA_90
  ;;
3)
  install_ADMRufu
  ;;
4)
  install_ChumoGH
  ;;
5)
  install_latam
  ;;
esac
exit
