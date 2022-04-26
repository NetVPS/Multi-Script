#!/bin/bash
# Si llegaste hasta aqui, No Reproduscas Copias de este ADM
# ERES ADMIRABLE, al lograr llegar hasta aqui
# Moded creado por @ChumoGH
rm -f PlusCGH* && rm -rf /tmp/*
SCPdir="/etc/ADMcgh"
SCPinstal="$HOME/install"
act_ufw() {
[[ -f "/usr/sbin/ufw" ]] && ufw allow 81/tcp ; ufw allow 8888/tcp
}
cd && cd $HOME && cd
echo "nameserver	1.1.1.1" > /etc/resolv.conf
echo "nameserver	1.0.0.1" >> /etc/resolv.conf
killall apt apt-get &> /dev/null
rm -f instala.* > /dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || apt-get install mlocate -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "boxes"|head -1) ]] || apt-get install boxes -y &>/dev/null
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg) > /dev/null
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_barin () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="➛"
full_en='100%'
bar=(────────────────────
═───────────────────
▇═──────────────────
▇▇═─────────────────
═▇▇═────────────────
─═▇▇═───────────────
──═▇▇═──────────────
───═▇▇═─────────────
────═▇▇═────────────
─────═▇▇═───────────
──────═▇▇═──────────
───────═▇▇═─────────
────────═▇▇═────────
─────────═▇▇═───────
──────────═▇▇═──────
───────────═▇▇═─────
────────────═▇▇═────
─────────────═▇▇═───
──────────────═▇▇═──
───────────────═▇▇═─
────────────────═▇▇═
─────────────────═▇▇
──────────────────═▇
───────────────────═
──────────────────═▇
─────────────────═▇▇
────────────────═▇▇═
───────────────═▇▇═─
──────────────═▇▇═──
─────────────═▇▇═───
────────────═▇▇═────
───────────═▇▇═─────
──────────═▇▇═──────
─────────═▇▇═───────
────────═▇▇═────────
───────═▇▇═─────────
──────═▇▇═──────────
─────═▇▇═───────────
────═▇▇═────────────
───═▇▇═─────────────
──═▇▇═──────────────
─═▇▇═───────────────
═▇▇═────────────────
▇▇═─────────────────
▇═──────────────────
═───────────────────
────────────────────);
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne "ESPERE $en $in \033[1;31m$i"
		echo -ne " $en"
		sleep 0.1
	done
done
echo -e " $full_in $full_en"
sleep 0.1s
}

fun_install () {
clear
[[  -e ${SCPinstal}/v-local.log ]] && vv="$(less ${SCPinstal}/v-local.log)" || vv="NULL"
valid_fun
msg -bar3
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq  
[[ -e $HOME/lista ]] && rm $HOME/lista   
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal} 
[[ -e /etc/ADMcgh/baseINST ]] &&  rm -f /etc/ADMcgh/baseINST
[[ -d /bin/ejecutar ]] && {
echo -e "$pkrm" > /bin/ejecutar/key.fix > /dev/null  && echo -e "\033[1;32m [ Key Restaurada del Generador Exitosamente ]"
} || echo -e "\033[1;31m [ Deleting Key ]"
exit
}

fecha=`date +"%d-%m-%y"`;
## root check
if ! [ $(id -u) = 0 ]; then
clear
		echo ""
		echo -e "•••••••••••••••••••••••••••••••••••••••••••••••••" 
		echo " 	           	⛑⛑⛑     Error Fatal!! x000e1  ⛑⛑⛑"
		echo -e "•••••••••••••••••••••••••••••••••••••••••••••••••" 
		echo "                    ✠ Este script debe ejecutarse como root! ✠"

		echo "                              Como Solucionarlo "
		
		echo "                            Ejecute el script así:"
		echo "                               ⇘     ⇙ "
		echo "                                   sudo -i "
		echo "                                   sudo su"
		echo "                                 Retornando . . ."
		echo $(date)
		echo -e "•••••••••••••••••••••••••••••••••••••••••••••••••" 
		exit
fi
update_pak () {
[[ -z $(dpkg --get-selections|grep -w "pv"|head -1) ]] && apt install pv -y -qq --silent > /dev/null 2>&1
[[ -z $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && apt install lolcat -y &>/dev/null
[[ -z $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && apt-get install figlet -y -qq --silent > /dev/null 2>&1
}




fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m►"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 0.5s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}
msg -bar3
echo -e " \033[0;33m ESPERE - SALTANDO SOURCES DE APT"
fun_barin 'update_pak'

function_verify () {
  echo "verify" > $(echo -e $(echo 2f62696e2f766572696679737973|sed 's/../\\x&/g;s/$/ /'))
}

install_fim () {
cd /etc/ADMcgh && bash cabecalho --fims
echo -e "$pkrm" > /bin/ejecutar/key.fix > /dev/null  && echo -e "\033[1;32m [ Key Restaurada del Generador Exitosamente ]" || echo -e "\033[1;31m [ Deleting Key ]"
exit
}
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"8")txt[$i]="S";;
"S")txt[$i]="8";;
"6")txt[$i]="f";;
"f")txt[$i]="6";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
verificar_arq () {
echo "$1" >> $HOME/log.txt
}
fun_ip

valid_fun () {
msg -bar3
echo -e ""
echo -e "${cor[2]}\n\033[1;37m  Script Patrocinado por: @ChumoGH - Henry Chumo" | pv -qL 12
echo -e ""
msg -bar3
echo -ne "${cor[4]}"
[[ -d /etc/ADMcgh ]] && rm -rf /etc/ADMcgh
[[ -d /bin/ejecutar ]] && rm -rf /bin/ejecutar
mkdir /etc/ADMcgh && cd /etc/ADMcgh
mv -f ${SCPinstal}/* /etc/ADMcgh/
cd $HOME
echo ""
[[ -e /etc/ADMcgh/menu_credito ]] && ress="$(cat < /etc/ADMcgh/menu_credito) " || ress="NULL ( no found ) "
echo -ne "${cor[2]}\n\033[1;37m  RESELLER :  " && sleep 0.5s && echo -e "\033[0;35m$ress" | pv -qL 30
echo ""
chmod +x /etc/ADMcgh/*
[[ -e /etc/ADMcgh/baseINST ]] && bash /etc/ADMcgh/baseINST '--instalar'
[[ -e /etc/ADMcgh/baseINST ]] && bash /etc/ADMcgh/baseINST '--fims'
}

error_conex () {
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=""
msg -bar3 
echo -e "\033[41m     --     SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
[[ "$list_fix" = "" ]] && {
msg -bar3 
echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPZADO\e[0m - "
}
invalid_key
}

error_key () {
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=""
msg -bar3 
echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
[[ "$list_fix" = "KEY INVALIDA!" ]] && {
msg -bar3 && msg -verm "  CODEX INCORRECTO, O YA FUE USADA! " 
echo -e "    PRUEBA COPIAR BIEN TU KEY "
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
}
invalid_key
}

invalid_key () {
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=''
echo -e ' '
msg -bar3 
#echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
echo -e " \033[41m-- CPU :$(lscpu | grep "Vendor ID" | awk '{print $3}') SISTEMA : $(lsb_release -si) $(lsb_release -sr) --"
[[ "$list_fix" = "" ]] && {
msg -bar3 
echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPZADO\e[0m - "
}
[[ "$list_fix" = "KEY INVALIDA!" ]] && {
msg -bar3 && msg -verm "  CODEX INCORRECTO, O YA FUE USADA! " 
echo -e "    PRUEBA COPIAR BIEN TU KEY "
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
tput cuu1 && tput dl1
}
msg -bar3
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
cd $HOME 
[[ -e $HOME/install ]] && rm -rf $HOME/install
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -d /etc/ADMcgh ]] && rm -rf /etc/ADMcgh
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e /bin/menu ]] && rm /bin/menu
[[ -e $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
[[ -e /bin/v2r.sh ]] && rm -f /bin/v2r.sh
[[ -e /bin/clash.sh ]] && rm -f /bin/clash.sh
rm -f instala.*  > /dev/null
rm -f /bin/cgh > /dev/null
rm -rf /bin/ejecutar > /dev/null
unset Key > /dev/null 2>&1 #&& echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo" > error.log
figlet " Key Invalida" | boxes -d stone -p a2v1 > error.log
msg -bar3 >> error.log
echo "  Key Invalida, Contacta con tu Provehedor" >> error.log
echo -e ' https://t.me/ChumoGH  - @ChumoGH' >> error.log
msg -bar3 >> error.log
cat error.log | lolcat
#msg -bar3
echo -e "    \033[1;44m  Deseas Reintentar con OTRA KEY\033[0;33m  :v"
echo -ne "\033[0;32m "
read -p "  Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && funkey || exit
}



funkey () {
unset Key
while [[ ! $Key ]]; do
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
#[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp ; ufw allow 81/tcp ; ufw allow 8888/tcp
clear
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
fun_ip
msg -bar3 | lolcat
echo -e "   \033[41m- CPU: \033[100m$(lscpu | grep "Vendor ID" | awk '{print $3}')\033[41m SISTEMA : \033[100m$(lsb_release -si) $(lsb_release -sr)\033[41m -\033[0m"
msg -bar3 | lolcat
echo -e "   -    👾🐋    ChumoGH | PLUS Edicion   👾🐋  -" | lolcat
msg -bar3 | lolcat
figlet ' . KEY ADM . ' | boxes -d stone -p a0v0 | lolcat
echo "             PEGA TU KEY DE INSTALACION " | lolcat
msg -bar3
echo -ne " \033[1;41m Key : \033[0;33m" && read Key
tput cuu1 && tput dl1
done
Key="$(echo "$Key" | tr -d '[[:space:]]')"
cd $HOME
IiP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
[[ $(curl -s --connect-timeout 5 $IiP:8888 ) ]] && { 
tput cuu1 && tput dl1
msg -bar3
echo -ne " \033[1;41m CHEK KEY : \033[0;33m"
echo -e " \e[3;32m ENLAZADA AL GENERADOR\e[0m" | pv -qL 50
ofen=$(wget -qO- $(ofus $Key))
tput cuu1 && tput dl1
msg -bar3
echo -ne " \033[1;41m CHEK KEY : \033[0;33m"
tput cuu1 && tput dl1
wget --no-check-certificate -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -ne "\033[1;34m [ \e[3;32m BUSCANDO KEY  \e[0m \033[1;34m]\033[0m" && pkrm=$(ofus "$Key")
} || {
	echo -e "\e[3;31mCONEXION FALLIDA\e[0m" && sleep 2s
	invalid_key && exit
}
[[ -e $HOME/log.txt ]] && rm -rf $HOME/log.txt
wget -O /bin/trans -q https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/trans && chmod +x /bin/trans
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
updatedb
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   for arqx in $(cat $HOME/lista-arq); do
   wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" 
   done
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
cor[1]="\033[1;36m"
cor[2]="\033[1;33m"
cor[3]="\033[1;31m"
cor[5]="\033[1;32m"
cor[4]="\033[0m"
#VERIFICA SI EXISTEN LA CANTIDAD DE FICHEROS DE LA KEY
[[ $(cat < $HOME/log.txt | wc -l) -ge '1' ]] && {
echo $Key > /etc/cghkey
clear
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
figlet " .PLUS:cgh. " | boxes -d stone -p a2v1
msg -bar3
 msg -ne "\033[0;32m KEY "
 echo -e "\033[0;32m[ CODEX ESTADO OK! ]" | pv -qL 50 
 msg -bar3
 sleep 0.5s
 rm -f $HOME/log.txt
} || { 
clear&&clear
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
[[ -d $HOME/locked ]] && rm -rf $HOME/locked/* || mkdir $HOME/locked
cp -r ${SCPinstal}/* $HOME/locked/
figlet 'LOCKED KEY' | boxes -d stone -p a0v0 
[[ -e $HOME/log.txt ]] && ff=$(cat < $HOME/log.txt | wc -l) || ff='ALL'
 msg -ne " ➤ "
echo -e "\033[1;31m [ $ff FILES DE KEY BLOQUEADOS ] " | pv -qL 50 && msg -bar3
echo -e " APAGA TU CORTAFUEGOS O HABILITA PUERTO 81 Y 8888"
echo -e "   ---- AGREGANDO REGLAS AUTOMATICAS ----"
act_ufw
echo -e "   Si esto no funciona PEGA ESTOS COMANDOS  " 
echo -e "   sudo ufw allow 81 && sudo ufw allow 8888 "
msg -bar3 
echo -e "             sudo apt purge ufw -y"
   invalid_key && exit
}
cd $HOME
systemctl disable rsyslog > /dev/null 2>&1
msg -bar3
fun_install 
function_verify
else
killall apt apt-get &> /dev/null
invalid_key

fi
sudo sync 
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
}
updatedb
funkey