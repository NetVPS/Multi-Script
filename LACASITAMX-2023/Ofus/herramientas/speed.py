#!/bin/bash
SCPdir="/etc/VPS-MX"
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${SCPdir}/protocolos"&& [[ ! -d ${SCPinst} ]] && exit

cas () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

[[ $(dpkg --get-selections|grep -w "speedtest-cli"|head -1) ]] || apt-get install speedtest-cli -y &>/dev/null 

clear
msg -bar
echo -e "   \033[1;32mTESTIANDO VELOCIDAD DEL SERVIDOR !\033[0m"
msg -bar
scp(){
speedtest-cli --share > speed
}
cas 'scp'
msg -bar
png=$(cat speed | sed -n '5 p' |awk -F : {'print $NF'})
download=$(cat speed | sed -n '7 p' |awk -F :  {'print $NF'})
upload=$(cat speed | sed -n '9 p' |awk -F :  {'print $NF'})
link=$(cat speed | sed -n '10 p' |awk {'print $NF'})
msg -bar
echo -e "	\033[1;32mPING (LATENCIA):\033[1;37m$png"
echo -e "	\033[1;32mDESCARGA:\033[1;37m$download"
echo -e "	\033[1;32mSUBIDA:\033[1;37m$upload"
echo -e "\033[1;32mLINK: \033[1;36m$link\033[0m"
msg -bar
#rm speed &>/dev/null
#