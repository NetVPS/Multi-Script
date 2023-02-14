#!/bin/bash
#
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)

cd $HOME
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
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
		sleep 0.2
	done
done
echo -e " $full_in $full_en"
sleep 0.1s
}

print_center(){
  if [[ -z $2 ]]; then
    text="$1"
  else
    col="$1"
    text="$2"
  fi

  while read line; do
    unset space
    x=$(( ( 54 - ${#line}) / 2))
    for (( i = 0; i < $x; i++ )); do
      space+=' '
    done
    space+="$line"
    if [[ -z $2 ]]; then
      msg -azu "$space"
    else
      msg "$col" "$space"
    fi
  done <<< $(echo -e "$text")
}

############

SCPdir="/etc/adm-lite" 
#SCPfrm="${SCPdir}" && [[ ! -d ${SCPfrm} ]] && exit 
#SCPinst="${SCPdir}"&& [[ ! -d ${SCPinst} ]] && exit 
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" [5]="\e[1;36m" )

fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
}  


function install(){
    if [ ! -f "$HOME/.nami/bin/nami" ] || [ ! -f "$HOME/.nami/bin/joker" ] || [ ! -f "$HOME/.nami/bin/brook" ] || [ ! -f "$HOME/.nami/bin/jinbe" ] || [ `echo $PATH | grep $HOME/.nami/bin | wc -l` -eq 0 ];then
        echo
        echo -e "$PC"'>>> bash <(curl https://bash.ooo/nami.sh)'"$NC"
        os=""
        arch=""
        if [ $(uname -s) = "Darwin" ]; then
            os="darwin"
        fi
        if [ $(uname -s) = "Linux" ]; then
            os="linux"
        fi
        if [ $(uname -s | grep "MINGW" | wc -l) -eq 1 ]; then
            os="windows"
        fi
        if [ $(uname -m) = "x86_64" ]; then
            arch="amd64"
        fi
        if [ $(uname -m) = "arm64" ]; then
            arch="arm64"
        fi
        if [ $(uname -m) = "aarch64" ]; then
            arch="arm64"
        fi
        if [ "$os" = "" -o "$arch" = "" ]; then
            echo "Nami does not support your OS/ARCH yet. Please submit issue or PR to https://github.com/txthinking/nami"
            exit
        fi
        sfx=""
        if [ $os = "windows" ]; then
            sfx=".exe"
        fi
        mkdir -p $HOME/.nami/bin
        curl -L -o $HOME/.nami/bin/nami$sfx "https://github.com/txthinking/nami/releases/latest/download/nami_${os}_${arch}$sfx"
        chmod +x $HOME/.nami/bin/nami
        echo 'export PATH=$HOME/.nami/bin:$PATH' >> $HOME/.bashrc
        echo 'export PATH=$HOME/.nami/bin:$PATH' >> $HOME/.bash_profile
        echo 'export PATH=$HOME/.nami/bin:$PATH' >> $HOME/.zshenv
        export PATH=$HOME/.nami/bin:$PATH
        echo
        echo -e "$PC"'>>> nami install joker brook jinbe'"$NC"
        nami install joker brook jinbe
        restartsh="todo"
    fi
}

function aguarde() {
	sleep 1
	helice() {
		#install >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "  \033[1;37mINSTALANDO \033[1;32mNAMI \033[1;37m& \033[1;32mBROOK JOKER\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DDONE"
}

brook_fun () {
msg -bar
aguarde
msg -bar 
install
[[ -e /data/cert.key && -e /data/cert.crt ]] || {
unset x
[[ -d /data ]] && rm -rf /data
echo -e " CREAREMOS EL CERTIFICADO BETA EN /data" 
read -p " PRESIONA ENTER PARA CONTINUAR O Cntrol + X para salir" 
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
}
msg -bar
ip4=`curl -s -4 ipip.ooo`
ip6=`curl -s -6 ipip.ooo`
PC='\033[0;35m'
NC='\033[0m'
lang=""
restartsh=""
echo 
read -p "$(echo -e "\033[1;34m INGRESA TU DOMINIO ( ejemplo.com ) :")" domain
tput cuu1 >&2 && tput dl1 >&2
[[ -z $domain ]] && domain=$(wget -qO- ifconfig.me)
read -p "$(echo -e "\033[1;34m INGRESA PUERTO DEL SERVICIO ( 9999 ) :")" puerto
tput cuu1 >&2 && tput dl1 >&2
read -p "$(echo -e "\033[1;34m INGRESA CLAVE O PASSWD ( tuclave ) :")" password
tput cuu1 >&2 && tput dl1 >&2
read -p "$(echo -e "\033[1;34m INGRESA TU HOST SNI ( whatsapp.net ) :")" sni
tput cuu1 >&2 && tput dl1 >&2
fun_hb () {
echo -e " -> INICIANDO CONFIGURACION " | pv -qL 40
msg -bar
echo -e " -> DOMINIO : $domain" 
echo -e " -> PUERTO : $puerto" 
echo -e " -> CONTRASEÑA : $password" 
echo -e " -> HOST/SNI : $sni" 
echo -ne " HABILITANDO CONFIGURACION DEL WSS BROOK" 
}

echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m➮ ${cor[3]} I want to run brook server   "
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m➮ ${cor[3]} I want to run brook wsserver "
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m➮ ${cor[3]} I want to run brook wssserver"
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m➮ ${cor[3]} I want to run brook socks5 "
msg -bar #echo -e "$barra"
selection=$(selection_fun 4)
case ${selection} in
0)
source menu
exit
;;
1)
fun_hb
echo
echo -e "$PC"">>> joker brook server --listen :$puerto --password '$password'""$NC"
joker brook server --listen :$puerto --password "$password"
sleep 3
echo
echo -e "$PC"">>> joker list""$NC"
joker list
echo;
echo -e "$PC"'>>> joker log `joker last`'"$NC"
joker log `joker last`
if [ -n "$ip4" ]; then
echo;
echo -e "$PC"">>> brook link -s $ip4:$puerto -p '$password'""$NC"
brook link -s $ip4:$puerto -p "$password"
fi
if [ -n "$ip6" ]; then
echo;
echo -e "$PC"">>> brook link -s [$ip6]:$puerto -p '$password'""$NC"
brook link -s [$ip6]:$puerto -p "$password"
fi

read -p " Enter";;
2)
fun_hb
echo
echo -e "$PC"">>> joker brook wsserver --listen :$puerto --password '$password'""$NC"
#screen -dmS new$puerto 
joker brook wsserver --listen :$puerto --password "$password" --cert /data/cert.crt --certkey /data/cert.key && loll="ok" || loll=''
echo
echo -e "$PC"">>> joker list""$NC"
joker list
echo;
echo -e "$PC"'>>> joker log `joker last`'"$NC"
joker log `joker last`

if [ -n "$ip4" ]; then
echo;
echo -e "$PC"">>> brook link -s ws://$ip4:$puerto -p '$password'""$NC"
brook link --server ws://$sni:${puerto} -p "$password" -u "@ChumoGH" --address "$domain" --name "@ChumoGH" --insecure 
fi
if [ -n "$ip6" ]; then
echo;
echo -e "$PC"">>> brook link -s [$ip6]:$puerto -p '$password'""$NC"
brook link -s ws://[$ip6]:$puerto -p "$password" --cert /data/cert.crt --certkey /data/cert.key && loll="ok" || loll=''
fi
echo;
read -p " Enter";;
3)
fun_hb
[[ `brook -v | awk '{print $3}'` -le 20210701 ]] && {
echo -e "$PC"">>> joker brook wssserver --domain $domain --password '$password'""$NC"
joker brook wssserver --domain $domain --password "$password" --cert /data/cert.crt --certkey /data/cert.key && loll="ok" || loll=''
}
[[ `brook -v | awk '{print $3}'` -gt 20210701 ]] && {
echo -e "$PC"">>> joker brook wssserver --domainaddress $domain:${puerto} --password '$password'""$NC"
joker brook wssserver --domainaddress $domain:${puerto} --password "$password" --cert /data/cert.crt --certkey /data/cert.key && loll="ok" || loll=''
} 
[[ $loll = "ok" ]] && echo -e "DONE" || echo -e "FAIL"

echo
echo -e "$PC"">>> joker list""$NC"
joker list

echo;
echo -e "$PC"'>>> joker log `joker last`'"$NC"
joker log `joker last`

echo;
echo -e "$PC"">>> brook link -s wss://$domain:${puerto} -p '$password'""$NC"
msg -bar 
echo
brook link --server wss://$sni:${puerto} -p "$password" -u "@ChumoGH" --address "$domain" --name "@ChumoGH" --insecure
echo
msg -bar

read -p " Enter";;
4)
fun_hb
read -p " Enter";;
esac

read -p "  COPIA TU CONFIG WSS"
}



check_keyoficial () {   
IP=$(wget -qO- ifconfig.me)   
IP2="$IP"   
permited=$(curl -sSL "https://www.dropbox.com/s/a7551062y9ge8bd/RegKeyID")   
[[ $(echo $permited|grep "$IP2") = "" ]] && {   
clear && clear   
echo 'echo -e "\n\n\033[1;91m==============================================================\n 
KEY BANEADA! CONTATE A SU VENDEDOR\n==============================================================\n\n" ' > /usr/bin/vps-mx && chmod +x /usr/bin/vps-mx
echo 'echo -e "\n\n\033[1;91m==============================================================\n ??KEY BANEADA! CONTATE A SU VENDEDOR\n==============================================================\n\n" ' > /usr/bin/VPS-MX && chmod +x /usr/bin/VPS-MX   
sleep 5s   
exit && exit    
} || {   
echo "OK-OFI-@Kalix1" > /usr/bin/lickal   
}   
exit && exit && exit 
} 
#check_keyoficial&


_ports() {
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
x=1
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
	porta[$x]="$porta"
    svcs[$x]="$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)"
	x=$(($x+1))
done

for((i=1; i<$x; i++)); do
[[ ! -z ${svcs[$i]} ]] && texto="\033[1;34m ▸ \033[1;37m${svcs[$i]}: \033[1;31m${porta[$i]}" || texto=''
[[ ${svcs[$i]} = "apache2" ]] && texto="\033[1;34m ▸ \033[1;37mAPACHE: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "node" ]] && texto="\033[1;34m ▸ \033[1;37mWebSocket: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "clash" ]] && texto="\033[1;34m ▸ \033[1;37mClash: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "psiphond" ]] && texto="\033[1;34m ▸ \033[1;37mPSIPHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-v2-u" ]] && texto="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2-ui" ]] && texto="\033[1;34m ▸ \033[1;37mV2-UI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-linu" ]] && texto="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "x-ui" ]] && texto="\033[1;34m ▸ \033[1;37mXUI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto="\033[1;34m ◂ \033[1;37mOPENVPN-TCP: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid" ]] && texto="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid3" ]] && texto="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "dropbear" ]] && texto="\033[1;34m ▸ \033[1;37mDROPBEAR: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python3" ]] && texto="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python" ]] && texto="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "obfs-serv" ]] && texto="\033[1;34m ▸ \033[1;37mSSR (OBFS): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ss-server" ]] && texto="\033[1;34m ▸ \033[1;37mSSR (LIV): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sshd" ]] && texto="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ssh" ]] && texto="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "systemd-r" ]] && texto="\033[1;34m ▸ \033[1;37mSystem-DNS: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel4" ]] && texto="\033[1;34m ▸ \033[1;37mSSL: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2ray" ]] && texto="\033[1;34m ◂ \033[1;37mV2RAY: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "badvpn-ud" ]] && texto="\033[1;34m ▸ \033[1;37mBadVPN: \033[1;31mON"
[[ ${porta[$i]} = "7200" ]] && texto="\033[1;34m ▸ \033[1;37mNetflix: \033[1;31mON"
[[ ${svcs[$i]} = "trojan" ]] && texto="\033[1;34m ◂ \033[1;37mTrojan-GO: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sslh" ]] && texto="\033[1;34m ◂ \033[1;37mSSLH: \033[1;31m${porta[$i]}"
[[ ${porta[$i]} = "8888" ]] && texto="\033[1;34m ◂ \033[1;37mKeyGen: \033[1;31mON"
    i=$(($i+1))
[[ ! -z ${svcs[$i]} ]] && texto_="\033[1;34m ▸ \033[1;37m${svcs[$i]}: \033[1;31m${porta[$i]}" || texto_=''
[[ ${svcs[$i]} = "apache2" ]] && texto_="\033[1;34m ▸ \033[1;37mAPACHE: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "node" ]] && texto_="\033[1;34m ▸ \033[1;37mWebSocket: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "clash" ]] && texto_="\033[1;34m ▸ \033[1;37mClash: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "psiphond" ]] && texto_="\033[1;34m ▸ \033[1;37mPSIPHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-v2-u" ]] && texto_="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2-ui" ]] && texto_="\033[1;34m ▸ \033[1;37mV2-UI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-linu" ]] && texto_="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "x-ui" ]] && texto_="\033[1;34m ▸ \033[1;37mXUI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto_="\033[1;34m ◂ \033[1;37mOPENVPN-TCP: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid" ]] && texto_="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid3" ]] && texto_="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "dropbear" ]] && texto_="\033[1;34m ▸ \033[1;37mDROPBEAR: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python3" ]] && texto_="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python" ]] && texto_="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "obfs-serv" ]] && texto_="\033[1;34m ▸ \033[1;37mSSR (OBFS): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ss-server" ]] && texto_="\033[1;34m ▸ \033[1;37mSSR (LIV): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sshd" ]] && texto_="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ssh" ]] && texto_="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "systemd-r" ]] && texto_="\033[1;34m ▸ \033[1;37mSystem-DNS: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel4" ]] && texto_="\033[1;34m ▸ \033[1;37mSSL: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2ray" ]] && texto_="\033[1;34m ◂ \033[1;37mV2RAY: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray" ]] && texto_="\033[1;34m ◂ \033[1;37mXRAY: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "badvpn-ud" ]] && texto_="\033[1;34m ▸ \033[1;37mBadVPN: \033[1;31mON"
[[ ${porta[$i]} = "7200" ]] && texto_="\033[1;34m ▸ \033[1;37mNetflix: \033[1;31mON"
[[ ${svcs[$i]} = "trojan" ]] && texto_="\033[1;34m ◂ \033[1;37mTrojan-GO: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sslh" ]] && texto_="\033[1;34m ◂ \033[1;37mSSLH: \033[1;31m${porta[$i]}"
[[ ${porta[$i]} = "8888" ]] && texto_="\033[1;34m ◂ \033[1;37mKeyGen: \033[1;31mON"
    i=$(($i+1))
[[ ! -z ${svcs[$i]} ]] && texto_3="\033[1;34m ▸ \033[1;37m${svcs[$i]}: \033[1;31m${porta[$i]}" || texto_3=''
[[ ${svcs[$i]} = "apache2" ]] && texto_3="\033[1;34m ▸ \033[1;37mAPACHE: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "node" ]] && texto_3="\033[1;34m ▸ \033[1;37mWebSocket: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "clash" ]] && texto_3="\033[1;34m ▸ \033[1;37mClash: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "psiphond" ]] && texto_3="\033[1;34m ▸ \033[1;37mPSIPHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-v2-u" ]] && texto_3="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2-ui" ]] && texto_3="\033[1;34m ▸ \033[1;37mV2-UI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray-linu" ]] && texto_3="\033[1;34m ▸ \033[1;37mXRAY/UI: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "x-ui" ]] && texto_3="\033[1;34m ▸ \033[1;37mXUI/WEB: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto_3="\033[1;34m ◂ \033[1;37mOPENVPN-TCP: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid" ]] && texto_3="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "squid3" ]] && texto_3="\033[1;34m ◂ \033[1;37mSQUID: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "dropbear" ]] && texto_3="\033[1;34m ▸ \033[1;37mDROPBEAR: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python3" ]] && texto_3="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "python" ]] && texto_3="\033[1;34m ▸ \033[1;37mSOCKS/PYTHON: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "obfs-serv" ]] && texto_3="\033[1;34m ▸ \033[1;37mSSR (OBFS): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ss-server" ]] && texto_3="\033[1;34m ▸ \033[1;37mSSR (LIV): \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sshd" ]] && texto_3="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "ssh" ]] && texto_3="\033[1;34m ▸ \033[1;37mSSH: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "systemd-r" ]] && texto_3="\033[1;34m ▸ \033[1;37mSystem-DNS: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel4" ]] && texto_3="\033[1;34m ▸ \033[1;37mSSL: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "v2ray" ]] && texto_3="\033[1;34m ◂ \033[1;37mV2RAY: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "xray" ]] && texto_3="\033[1;34m ◂ \033[1;37mXRAY: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "badvpn-ud" ]] && texto_3="\033[1;34m ▸ \033[1;37mBadVPN: \033[1;31mON"
[[ ${porta[$i]} = "7200" ]] && texto_3="\033[1;34m ▸ \033[1;37mNetflix: \033[1;31mON"
[[ ${svcs[$i]} = "trojan" ]] && texto_3="\033[1;34m ◂ \033[1;37mTrojan-GO: \033[1;31m${porta[$i]}"
[[ ${svcs[$i]} = "sslh" ]] && texto_3="\033[1;34m ◂ \033[1;37mSSLH: \033[1;31m${porta[$i]}"
[[ ${porta[$i]} = "8888" ]] && texto_3="\033[1;34m ◂ \033[1;37mKeyGen: \033[1;31mON"
	echo -e "$texto $texto_ $texto_3"
done
PIDGEN=$(ps x | grep "teleBotGen" | grep -v grep |awk '{print $1}')
[[ ! -z $PIDGEN ]] && {
botG="\033[1;34m ▸ \033[1;37m BotGen Telegram 🤖 : \033[1;31m ⚡ ACTIVO ⚡"
msg -bar
echo -e "$botG"
}
}

mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1:$var2")" ]] || portas+="$var1:$var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
} 

fun_ports () {
portas1=$(mportas)
for i in ${portas1}; do
b=$(echo $i | awk -F ":" '{print $2}')
echo "$b"
done
}



menu () {
[[ -e /etc/bash.bashrc-bakup ]] && _autorun="\033[0;31m [\033[0;32mON\033[0;31m] " || _autorun="\033[0;31m [OFF]"
_ports
msg -bar2
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ➮${cor[3]} ADMINISTRAR USUARIOS                  "
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮${cor[3]} HERRAMIENTAS (\033[0;34mBad/VPN$_badvpn${cor[3]}) (\033[0;34mTCP-SPEED$_tcpspeed${cor[3]})    "
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m ➮\033[0;33m [!]${cor[3]} OPTIMIZAR VPS                     "
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m ➮\033[0;33m [!]\033[0;31m DESINSTALAR SCRIPT                "
echo -e "\033[0;35m [\033[0;36m6\033[0;35m]\033[0;31m ➮${cor[3]} Cont/Limit DE USUARIOS $VERIFICAR_PID              \033[1;31m ║"
echo -e "\033[0;35m [\033[0;36m7\033[0;35m]\033[0;31m ➮ \e[3;32mHERRAMIENTAS BETA\e[0m \033[0;33m (#EXPERIMENTAL)    "
echo -e "\033[0;35m [\033[0;36m8\033[0;35m]\033[0;31m ➮${cor[3]} AUTOINICIAR SCRIPT $_autorun             "
echo -e "\033[0;35m [\033[0;36m9\033[0;35m]\033[0;31m ➮${cor[3]} INSTALADOR DE PROTOCOLOS              "
msg -bar2
echo -e "\033[0;35m [\033[0;36m10\033[0;35m]\033[0;31m ➮\033[0;33m [!] \033[1;32mACTUALIZAR${cor[3]} |\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ Salir ]\e[0m")"
echo -ne "\033[1;31m ╰══════╣ OPCION :" && read -p "" opt

}





msg -bar
_ports 
msg -bar
fun_ports
read -p "D"
 #echo "MPORTAS1 ORIGINAL"
 #mportas1
