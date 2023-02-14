#!/bin/bash
#19/12/2019
clear
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && mkdir /etc/ger-frm
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && mkdir /etc/ger-inst
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
menu_org () {
sudo bash -c "$(curl -fsSL https://www.dropbox.com/s/zxzdpjtitc21a6j/openvpn.sh)"
}

menu_kali () {
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && mkdir /etc/ger-frm
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && mkdir /etc/ger-inst
SCPdir="/etc/VPS-MX" && [[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPdir}/herramientas
SCPinst="${SCPdir}/protocolos" && [[ ! -d ${SCPinst} ]] && mkdir ${SCPdir}/protocolos
SCPidioma="${SCPdir}/idioma" && [[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
wget -O /tmp/openvpn.sh -q https://www.dropbox.com/s/zxzdpjtitc21a6j/openvpn.sh && chmod +x /tmp/openvpn.sh && cd /tmp && ./openvpn.sh && cd

#source <(curl -sL https://www.dropbox.com/s/omykq6x27ua54fb/openvpn-install.sh)

}
source /etc/adm-lite/cabecalho
echo -e $barra
echo -e "          \033[1;42mBIENVENIDO NUEVAMENTE!\033[0m"
echo -e $barra
echo -e " \033[1;44mEstas Funciones Aun no estan Completas\033[0m, \n \033[1;44mpor lo que pueden presentar errores criticos\033[0m,\n \033[1;44mUselas bajo su Propio Riesgo\033[0m"
echo -e $barra
echo -ne $(msg -verm2 "    Instalador OpenVPN") && msg -azu "  ( Estado Critico )  "
echo " "
echo -e $barra
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m INICIAR Menu OPENVPN Original "
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m INICIAR Menu OPENVPN By @Kalix1"
echo -e $barra
echo -e "\033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m SALIR"
unset inst
echo -e $barra
echo -ne "\033[97m ESCOJE [ 1 / 2 ]: "
read inst
[[ $inst = "1" ]] && menu_org
[[ $inst = "2" ]] && menu_kali
#[[ $inst = "3" ]] && stop_ser
[[ $inst = "0" ]] && menu