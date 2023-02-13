#!/bin/bash
# INSTALADO --- ACTULIZADO EL 12-01-2023 --By @Kalix1
clear && clear
colores="$(pwd)/colores"
rm -rf ${colores}
wget -O ${colores} "https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/colores" &>/dev/null
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
  link="https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Source-List/$1.list"
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
    wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/sshd_config >/dev/null 2>&1
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
  echo "$v1" >/etc/SCRIPT-LATAM/temp/version_instalacion
  v22=$(cat /etc/SCRIPT-LATAM/temp/version_instalacion)
  vesaoSCT="\e[1;31m [ \e[1;32m( $v22 )\e[1;97m\e[1;31m ]"
  #-- CONFIGURACION BASICA
  os_system
  repo "${vercion}"
  msgi -bar2
  echo -e " \e[5m\e[1;100m   =====>> ►►     MULTI SCRIPT     ◄◄ <<=====    \e[1;37m"
  msgi -bar2
  #-- VERIFICAR VERSION
  v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Vercion")
  msgi -ama "   PREPARANDO INSTALACION | VERSION: $vesaoSCT"
  ## PAQUETES-UBUNTU PRINCIPALES
  echo ""
  echo -e "\e[1;97m         🔎 IDENTIFICANDO SISTEMA OPERATIVO"
  echo -e "\e[1;32m                 | $distro $vercion |"
  echo ""
  echo -e "\e[1;97m    ◽️ DESACTIVANDO PASS ALFANUMERICO "
  sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password >/dev/null 2>&1
  barra_intallb "service ssh restart > /dev/null 2>&1 "
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
  wget -O /bin/install https://raw.githubusercontent.com/NetVPS/VPS-MX_Oficial/master/Instalador/Install-Sin-Key.sh &>/dev/null
  chmod +rwx /bin/install
}

post_reboot() {
  /bin/cp /etc/skel/.bashrc ~/
  install -c
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
  -s | --start) install_inicial && post_reboot  ;;
  #&& time_reboot "15"
  -c | --continue)
    install_paquetes
    rm -rf /root/LATAM &>/dev/null
    break
    ;;
  -m | --menu)
    clear && clear
    break
    ;;
  *) exit ;;
  esac
done

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
  echo "$v1" >/etc/SCRIPT-LATAM/temp/version_instalacion
  v22=$(cat /etc/SCRIPT-LATAM/temp/version_instalacion)
  vesaoSCT="\e[1;31m [ \e[1;32m( $v22 )\e[1;97m\e[1;31m ]"
msgi -ama "   PREPARANDO INSTALACION | VERSION: $vesaoSCT"
msgi -bar2
echo -ne "\e[1;93m [\e[1;32m1\e[1;93m]\e[1;31m >\e[1;97m VPS-MX FINAL OFICIAL..(8.5)  \e[1;31m 🎁 FREE \e[97m \n"
echo -ne "\e[1;93m [\e[1;32m2\e[1;93m]\e[1;31m >\e[1;97m LACASITAMX............(9.0X) \e[1;31m 🎁 FREE \e[97m \n"
echo -ne "\e[1;93m [\e[1;32m3\e[1;93m]\e[1;31m >\e[1;97m ADMRufu                      \e[1;31m 🎁 FREE\e[97m \n"
echo -ne "\e[1;93m [\e[1;32m4\e[1;93m]\e[1;31m >\e[1;97m ChumoGH...............(5.6)  \e[1;31m 🎁 FREE\e[97m \n"
echo -ne "\e[1;93m [\e[1;32m5\e[1;93m]\e[1;31m >\e[1;97m LATAM.................(2.0)  \e[1;96m 💎 VIP\e[97m \n"
msgi -bar2
echo -ne "\e[1;93m [\e[1;32m ARCHIVOS Y LINKS TOTALMENTE ABIERTOS Y PUBLICOS \e[1;93m]\e[1;96m\n       https://github.com/NetVPS/Multi-Script\e[97m \n"
msgi -bar2
echo -ne "\e[1;97mDigite solo el numero segun su respuesta:\e[32m "
read opcao
case $opcao in
1)
  install_oficial
  ;;
2)
  install_mod
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
