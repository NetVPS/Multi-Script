#!/bin/bash

[[ -e /etc/adm-lite/ShellBot.sh ]] && rm /etc/adm-lite/ShellBot.sh 
[[ -e /etc/adm-lite/ultimatebot ]] && rm /etc/adm-lite/ultimatebot 
wget -q -O /etc/adm-lite/ShellBot.sh https://www.dropbox.com/s/mho5ulrxcr3rpcf/ShellBot.sh && chmod +x /etc/adm-lite/ShellBot.sh > /dev/null
#wget -q -O /etc/adm-lite/ShellBot.sh https://raw.githubusercontent.com/ChumoGH/VPSbot/main/ShellBot.sh && chmod +x /etc/adm-lite/ShellBot.sh > /dev/null
#wget -q -O /etc/adm-lite/ultimatebot https://www.dropbox.com/s/6hzvja2mhgknl02/ultimatebot && chmod +x /etc/adm-lite/ultimatebot > /dev/null
wget -q -O /etc/adm-lite/ultimatebot https://www.dropbox.com/s/kqx37io7pdccvou/ultimatebot-ant.sh?dl=0 && chmod +x /etc/adm-lite/ultimatebot > /dev/null
#wget -q -O /etc/adm-lite/bot_codes https://www.dropbox.com/s/wj53654gm0lhuja/bot_codes && chmod +x /etc/adm-lite/bot_codes > /dev/null
wget -q -O /etc/adm-lite/bot_codes https://www.dropbox.com/s/23cjojjxaaun6f1/bot_codes-ant.sh?dl=0 && chmod +x /etc/adm-lite/bot_codes > /dev/null
telegran_bot () {
cd /etc/adm-lite
if [[ "$(ps x | grep "ultimatebot" | grep -v "grep")" = "" ]]; then
echo -e "${barra}"
echo -e " INGRESA TUS CREDENCIALES DE ACCESO AL BOT"
echo -e "${barra}"
read -p " TELEGRAN BOT TOKEN: " tokenxx
read -p " TELEGRAN BOT LOGUIN: " loguin
read -p " TELEGRAN BOT PASS: " pass
#read -p " IDIOMA DEL BOT [ES]: " lang
[[ -z $lang ]] && lang="es"
echo -e "${barra}"
echo -e "${loguin}:${pass}" > ./bottokens
screen -dmS telebotusr bash ./ultimatebot "$tokenxx" "$lang" > /dev/null 2>&1
echo -e " INICIANDO CONFIGURACION DEL BOT, ESPERE"
sleep 2s
[[ $(ps x | grep "ultimatebot" | grep -v "grep" | awk '{print $1}') ]] && echo -e " RUNNING" || echo -e "BOT NO INICIADO"
echo -e "${barra}"
echo -e " COLOCA TUS CREDENCIALES EN EL BOT HACI :"
echo -e "   /access $loguin $pass"
echo -e "${barra}"
read -p " PRESIONA ENTER PARA CONTINUAR"
else
kill -9 $(ps x | grep "ultimatebot" | grep -v "grep" | awk '{print $1}') > /dev/null 2>&1
kill $(ps x | grep "telebotusr" | grep -v "grep" | awk '{print $1}') > /dev/null 2>&1
[[ -e ./bottokens ]] && rm ./bottokens
echo -e "${barra}"
echo -e " ESTAMOS DETENIENDO EL BOT"
echo -e "${barra}"
[[ -e /etc/adm-lite/ShellBot.sh ]] && rm /etc/adm-lite/ShellBot.sh 
[[ -e /etc/adm-lite/ultimatebot ]] && rm /etc/adm-lite/ultimatebot 
[[ -e /etc/adm-lite/bot_codes ]] && rm /etc/adm-lite/bot_codes
fi
cd $HOME
exit
}
telegran_bot
return 