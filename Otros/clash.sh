fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ INFORMACION ]${Font_color_suffix}"
Error="${Red_font_prefix}[# ERROR #]${Font_color_suffix}"
Tip="${Green_font_prefix}[ NOTA ]${Font_color_suffix}"
Separator_1="——————————————————————————————"
config="/etc/v2ray/config.json"

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "

echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}



Set_config_port(){
msg -bar
	while true
	do
	echo -e "\e[92m 2) Por favor ingrese un Puerto para el Perfil Clash "
msg -bar
	stty erase '^H' && read -p "(Predeterminado: 990):" ssr_port
	[[ -z "$ssr_port" ]] && ssr_port="990"
	expr ${ssr_port} + 0 &>/dev/null
	if [[ $? == 0 ]]; then
		if [[ ${ssr_port} -ge 1 ]] && [[ ${ssr_port} -le 65535 ]]; then
			echo && echo -e "	Port : ${Green_font_prefix}${ssr_port}${Font_color_suffix}" && echo
			break
		else
			echo -e "${Error} Por favor ingrese el numero correcto (1-65535)"
		fi
	else
		echo -e "${Error} Por favor ingrese el numero correcto (1-65535)"
	fi
	done
}

Set_config_method(){
msg -bar
	echo -e "\e[92m 4) Seleccione tipo de Encriptacion para el Perfil Clash\e[0m
$(msg -bar)
 ${Green_font_prefix} 1.${Font_color_suffix} Ninguno
 ${Green_font_prefix} 2.${Font_color_suffix} rc4
 ${Green_font_prefix} 3.${Font_color_suffix} rc4-md5
 ${Green_font_prefix} 4.${Font_color_suffix} rc4-md5-6
 ${Green_font_prefix} 5.${Font_color_suffix} aes-128-ctr
 ${Green_font_prefix} 6.${Font_color_suffix} aes-192-ctr
 ${Green_font_prefix} 7.${Font_color_suffix} aes-256-ctr
 ${Green_font_prefix} 8.${Font_color_suffix} aes-128-cfb
 ${Green_font_prefix} 9.${Font_color_suffix} aes-192-cfb
 ${Green_font_prefix}10.${Font_color_suffix} aes-256-cfb
 ${Green_font_prefix}11.${Font_color_suffix} aes-128-cfb8
 ${Green_font_prefix}12.${Font_color_suffix} aes-192-cfb8
 ${Green_font_prefix}13.${Font_color_suffix} aes-256-cfb8
 ${Green_font_prefix}14.${Font_color_suffix} salsa20
 ${Green_font_prefix}15.${Font_color_suffix} chacha20
 ${Green_font_prefix}16.${Font_color_suffix} chacha20-ietf
 
 ${Red_font_prefix}17.${Font_color_suffix} xsalsa20
 ${Red_font_prefix}18.${Font_color_suffix} xchacha20
$(msg -bar)
 ${Tip} Para salsa20/chacha20-*:\n Porfavor instale libsodium:\n Opcion 4 en menu principal SSRR"
msg -bar
	stty erase '^H' && read -p "(Predeterminado: 16. chacha20-ietf):" ssr_method
msg -bar
	[[ -z "${ssr_method}" ]] && ssr_method="16"
	if [[ ${ssr_method} == "1" ]]; then
		ssr_method="Ninguno"
	elif [[ ${ssr_method} == "2" ]]; then
		ssr_method="rc4"
	elif [[ ${ssr_method} == "3" ]]; then
		ssr_method="rc4-md5"
	elif [[ ${ssr_method} == "4" ]]; then
		ssr_method="rc4-md5-6"
	elif [[ ${ssr_method} == "5" ]]; then
		ssr_method="aes-128-ctr"
	elif [[ ${ssr_method} == "6" ]]; then
		ssr_method="aes-192-ctr"
	elif [[ ${ssr_method} == "7" ]]; then
		ssr_method="aes-256-ctr"
	elif [[ ${ssr_method} == "8" ]]; then
		ssr_method="aes-128-cfb"
	elif [[ ${ssr_method} == "9" ]]; then
		ssr_method="aes-192-cfb"
	elif [[ ${ssr_method} == "10" ]]; then
		ssr_method="aes-256-cfb"
	elif [[ ${ssr_method} == "11" ]]; then
		ssr_method="aes-128-cfb8"
	elif [[ ${ssr_method} == "12" ]]; then
		ssr_method="aes-192-cfb8"
	elif [[ ${ssr_method} == "13" ]]; then
		ssr_method="aes-256-cfb8"
	elif [[ ${ssr_method} == "14" ]]; then
		ssr_method="salsa20"
	elif [[ ${ssr_method} == "15" ]]; then
		ssr_method="chacha20"
	elif [[ ${ssr_method} == "16" ]]; then
		ssr_method="chacha20-ietf"
	elif [[ ${ssr_method} == "17" ]]; then
		ssr_method="xsalsa20"
	elif [[ ${ssr_method} == "18" ]]; then
		ssr_method="xchacha20"
	else
		ssr_method="aes-256-cfb"
	fi
	echo && echo -e "	Encriptacion: ${Green_font_prefix}${ssr_method}${Font_color_suffix}" && echo
}

Set_config_protocol(){
msg -bar
	echo -e "\e[92m 5) Por favor, seleccione un Protocolo
$(msg -bar)
 ${Green_font_prefix}1.${Font_color_suffix} origin
 ${Green_font_prefix}2.${Font_color_suffix} auth_sha1_v4
 ${Green_font_prefix}3.${Font_color_suffix} auth_aes128_md5
 ${Green_font_prefix}4.${Font_color_suffix} auth_aes128_sha1
 ${Green_font_prefix}5.${Font_color_suffix} auth_chain_a
 ${Green_font_prefix}6.${Font_color_suffix} auth_chain_b
 ${Red_font_prefix}7.${Font_color_suffix} auth_chain_c
 ${Red_font_prefix}8.${Font_color_suffix} auth_chain_d
 ${Red_font_prefix}9.${Font_color_suffix} auth_chain_e
 ${Red_font_prefix}10.${Font_color_suffix} auth_chain_f
$(msg -bar)
 ${Tip}\n Si selecciona el protocolo de serie auth_chain_ *:\n Se recomienda establecer el metodo de cifrado en ninguno"
msg -bar
	stty erase '^H' && read -p "(Predterminado: 1. origin):" ssr_protocol
msg -bar
	[[ -z "${ssr_protocol}" ]] && ssr_protocol="1"
	if [[ ${ssr_protocol} == "1" ]]; then
		ssr_protocol="origin"
	elif [[ ${ssr_protocol} == "2" ]]; then
		ssr_protocol="auth_sha1_v4"
	elif [[ ${ssr_protocol} == "3" ]]; then
		ssr_protocol="auth_aes128_md5"
	elif [[ ${ssr_protocol} == "4" ]]; then
		ssr_protocol="auth_aes128_sha1"
	elif [[ ${ssr_protocol} == "5" ]]; then
		ssr_protocol="auth_chain_a"
	elif [[ ${ssr_protocol} == "6" ]]; then
		ssr_protocol="auth_chain_b"
	elif [[ ${ssr_protocol} == "7" ]]; then
		ssr_protocol="auth_chain_c"
	elif [[ ${ssr_protocol} == "8" ]]; then
		ssr_protocol="auth_chain_d"
	elif [[ ${ssr_protocol} == "9" ]]; then
		ssr_protocol="auth_chain_e"
	elif [[ ${ssr_protocol} == "10" ]]; then
		ssr_protocol="auth_chain_f"
	else
		ssr_protocol="origin"
	fi
	echo && echo -e "	Protocolo : ${Green_font_prefix}${ssr_protocol}${Font_color_suffix}" && echo
	if [[ ${ssr_protocol} != "origin" ]]; then
		if [[ ${ssr_protocol} == "auth_sha1_v4" ]]; then
			stty erase '^H' && read -p "Set protocol plug-in to compatible mode(_compatible)?[Y/n]" ssr_protocol_yn
			[[ -z "${ssr_protocol_yn}" ]] && ssr_protocol_yn="y"
			[[ $ssr_protocol_yn == [Yy] ]] && ssr_protocol=${ssr_protocol}"_compatible"
			echo
		fi
	fi
}
Set_config_obfs(){
msg -bar
	echo -e "\e[92m 6) Por favor, seleccione el metodo OBFS
$(msg -bar)
 ${Green_font_prefix}1.${Font_color_suffix} plain
 ${Green_font_prefix}2.${Font_color_suffix} http_simple
 ${Green_font_prefix}3.${Font_color_suffix} http_post
 ${Green_font_prefix}4.${Font_color_suffix} random_head
 ${Green_font_prefix}5.${Font_color_suffix} tls1.2_ticket_auth
$(msg -bar)
  Si elige tls1.2_ticket_auth, entonces el cliente puede\n  elegir tls1.2_ticket_fastauth!"
msg -bar
	stty erase '^H' && read -p "(Predeterminado: 5. tls1.2_ticket_auth):" ssr_obfs
	[[ -z "${ssr_obfs}" ]] && ssr_obfs="5"
	if [[ ${ssr_obfs} == "1" ]]; then
		ssr_obfs="plain"
	elif [[ ${ssr_obfs} == "2" ]]; then
		ssr_obfs="http_simple"
	elif [[ ${ssr_obfs} == "3" ]]; then
		ssr_obfs="http_post"
	elif [[ ${ssr_obfs} == "4" ]]; then
		ssr_obfs="random_head"
	elif [[ ${ssr_obfs} == "5" ]]; then
		ssr_obfs="tls1.2_ticket_auth"
	else
		ssr_obfs="tls1.2_ticket_auth"
	fi
	echo && echo -e "	obfs : ${Green_font_prefix}${ssr_obfs}${Font_color_suffix}" && echo
	msg -bar
	if [[ ${ssr_obfs} != "plain" ]]; then
			stty erase '^H' && read -p "Configurar modo Compatible (Para usar SS)? [y/n]: " ssr_obfs_yn
			[[ -z "${ssr_obfs_yn}" ]] && ssr_obfs_yn="y"
			[[ $ssr_obfs_yn == [Yy] ]] && ssr_obfs=${ssr_obfs}"_compatible"
	fi
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
figlet -p -f slant < /root/name
echo -e "\033[1;37m      【     ★ ChumoGH - ADM 2021 ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
echo -e "\033[1;37m ∆ Linux Dist:	$distribution › Version: $os_version\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m =======================================\033[1;33m"
echo -e "\033[1;37m - INSTALADOR Clash for Android - ChumoGH \033[0m"
echo -e "\033[1;36m Se instalara¡ el servidor de \033[1;32mClash\033[0m"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mGO Lang\033[0m"
[[ -d /usr/local/go ]] && echo -e "\033[1;33m Go Lang Instalado" || echo -e "\033[1;33m Instale Go Lang en ( *\033[1;33m menu\033[1;32m *\033[1;33m opcion 7 \033[1;32m*\033[1;33m opcion 15 \033[1;32m)"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mTrojan Server ( Obligatorio ) & V2RAY y SSR (\033[1;33mOpcional \033[1;32m)\033[0m"
#echo -e "\033[1;33m IMPORTANTE DEBES TENER LIBRES PUERTOS \033[1;32m7890 / 7891 / 7892 / 9090\033[0m"
#echo -e "\033[1;33m Para continuar digita S, para Cancelar Preciona N?\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m #######################################\033[1;33m"
echo -e "\033[1;37mSeleccione :    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
unset yesno
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
killall clash 1> /dev/null 2> /dev/null
echo -e "🦎” Creando Directorios y Archivos"
[[ -d /root/.config ]] && rm -rf /root/.config
mkdir /root/.config 1> /dev/null 2> /dev/null
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
#wget -q -O /root/.config/clash/clash.gz https://github.com/Dreamacro/clash/releases/download/v1.4.2/clash-linux-amd64-v1.4.2.gz
#gzip -d /root/.config/clash/clash.gz
#chmod +x /root/.config/clash/clash
echo -e "🦎” Cargando Configuracion del Repositorio Original 匚卄ㄩ爪ㄖᎶ卄"
fun_bar 'go get -u -v github.com/Dreamacro/clash' # 1> /dev/null 2> /dev/null
clear
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Ingresa tu Whatsapp junto a tu codigo de Pais"
read -p " Ejemplo: +593987072611 : " numwt
if [[ -z $numwt ]]; then
numwt="【＋５９３９８７０７２６１１】"
fi
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Ingresa Clase de Servidor ( Gratis - PREMIUM )"
read -p " Ejemplo: PREMIUM : " srvip
if [[ -z $srvip ]]; then
srvip="V.I.P🪐"
fi
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el password de Trojan Server"
read -p ": " tropass
echo -e "\033[1;33mÎ” Escriba el SNI de su metodo"
read -p ": " trosni
echo -e "Î” Iniciando Servidor"
echo 'port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: Rule
log-level: info
external-controller: '0.0.0.0:9090'
secret: ''

proxy-groups:
- name: "ChumoGH-ADM"
  type: select
  proxies:
    #- Trojan_Public🦎_CGH
    #- V2ray_v-2
    #- Trojan_Public2_v-3
    #- V2ray_vss
    #- Trojan_Public3_v-4
    #- V2ray_vxx
    #- Trojan_Public4_v-5
    #- Trojan_Public5_v-6
    #- Trojan_Public6_v-7
    #- SSR-Public_ax1
    #- SSR-Public_s2
    #- Trojan_Public7_v-8
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChumoGH-ADM

# By ChumoGH By CGH
- name: "【 ✵ 𝚂𝚎𝚛𝚟𝚎𝚛-𝙿𝚁𝙴𝙼𝙸𝚄𝙼 ✵ 】"
  type: select
  proxies: 
    - "ChumoGH-ADM"

- name: "【＋５９３９８７０７２６１１】"
  type: select
  proxies:
    - "ChumoGH-ADM"
    
    
rules:
- DOMAIN-SUFFIX,local,ChumoGH-ADM
- DOMAIN-SUFFIX,google.com,ChumoGH-ADM
- DOMAIN-KEYWORD,google,ChumoGH-ADM
- DOMAIN,google.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ad.com,ChumoGH-ADM
- SRC-IP-CIDR,192.168.1.201/32,ChumoGH-ADM
- IP-CIDR,127.0.0.0/8,ChumoGH-ADM
- GEOIP,IR,ChumoGH-ADM
- MATCH, ChumoGH-ADM

proxies:
- name: 🦖Trojan_Public🦎_CGH
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' > /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public🦎_CGH/- 🦖Trojan_Public🦎_CGH/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/CGH/$nameperfil/g" /root/.config/clash/config.yaml
#sed -i "s/Trojan_Public2_CGH/$nameperfil/g" /root/.config/clash/config.yaml
echo -e "\033[1;33m Deseas Añadir V2ray si Existe?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
if [[ $(v2ray info | grep TLS) = "TLS: open" ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
read -p ": " v2port
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_v-2
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
sed -i 's///c/g' patch 1> /dev/null 2> /dev/null
x=$(sed 's/^.//g' patch)
echo $x > patch
s=$(sed 's/.$//g' patch)
echo $s > patch
parche=$(cat < patch)
#parche=$(path=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && path='')
echo "Ruta pach = "$parche
uid=$(v2ray info | grep UUID)
uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
echo "Habilitando Seleccion en Menu"
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- V2ray_v-2/- 🦖V2ray_v-2/g' /root/.config/clash/config.yaml
sleep 1
echo "Habilitando IP"
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Nombre en Menu"
sed -i "s/v-2/$nameperfil/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando UUID en V2ray"
sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando SNI del MEtodo"
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Puerto V2ray en Clash"
sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Pach en Clash V2ray"
sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
read -p "V2ray Configurado, Enter to Continued"
else
echo -e "\033[1;31mV2ray no Found 00x3, $(v2ray info | grep TLS)"
	if [[ $(v2ray info | grep TLS) = "TLS: close" ]]; then
	unset yesno
	fun_ip
	figlet -p -f smslant < /root/name
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Ingrese ADDRESS / IP ( Invertido ): "
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " addes
	echo -e "\033[1;33mÎ” Ingrese AlterID : "
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " vbb
	echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " nameperfil
	echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
	read -p ": " v2port
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
	read -p ": " trosni
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_v-2
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: vbbs
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
	#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
	sed -i 's///c/g' patch 1> /dev/null 2> /dev/null
	x=$(sed 's/^.//g' patch)
	echo $x > patch
	s=$(sed 's/.$//g' patch)
	echo $s > patch
	parche=$(cat < patch)
	echo "Ruta pach = "$parche
	uid=$(v2ray info | grep UUID)
	uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
	echo "Habilitando Seleccion en Menu"
	#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
	sed -i 's/#- V2ray_v-2/- 🦖V2ray_v-2/g' /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando IP / address"
	sed -i "s/ipdelservidor/$addes/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando AlterID"
	sed -i "s/vbbs/$vbb/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando TLS en CLOSED Posiblemente no funcione"
	sleep 1
	echo "Habilitando Nombre en Menu"
	sed -i "s/vss/$nameperfil/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando UUID en V2ray"
	sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando SNI del MEtodo"
	sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Puerto V2ray en Clash"
	sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Pach en Clash V2ray"
	sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
	read -p "V2ray Configurado, Enter to Continued"
	else
	echo -e "\033[1;31mV2ray no Found 00x3, V2RAY No INSTALL"
	fi
fi
fi
unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 2?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
#read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "Î” Iniciando Servidor"
echo -e '
- name: 🦖Trojan_Public2_v-3
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml

#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public2_v-3/- 🦖Trojan_Public2_v-3/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-3/$nameperfil/g" /root/.config/clash/config.yaml
fi
#V2RAY - 2
unset yesno
echo -e "\033[1;33m Deseas Añadir V2ray 2 SNI si Existe?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
if [[ $(v2ray info | grep TLS) = "TLS: open" ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
read -p ": " v2port
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vss
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
sed -i 's///c/g' patch patch 1> /dev/null 2> /dev/null
x=$(sed 's/^.//g' patch)
echo $x > patch
s=$(sed 's/.$//g' patch)
echo $s > patch
parche=$(cat < patch)
echo "Ruta pach = "$parche
uid=$(v2ray info | grep UUID)
uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
echo "Habilitando Seleccion en Menu"
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- V2ray_vss/- 🦖V2ray_vss/g' /root/.config/clash/config.yaml
sleep 1
echo "Habilitando IP"
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Nombre en Menu"
sed -i "s/vss/$nameperfil/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando UUID en V2ray"
sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando SNI del MEtodo"
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Puerto V2ray en Clash"
sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Pach en Clash V2ray"
sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
read -p "V2ray Configurado, Enter to Continued"
else
echo -e "\033[1;31mV2ray no Found 00x3, $(v2ray info | grep TLS)"
	if [[ $(v2ray info | grep TLS) = "TLS: close" ]]; then
	unset yesno
	fun_ip
	figlet -p -f smslant < /root/name
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Ingrese ADDRESS / IP "
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " addes
	echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " nameperfil
	echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
	read -p ": " v2port
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
	read -p ": " trosni
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vss
type: vmess
server: ipdelservidor
port: portacces
mduuid
alterId: 0
cipher: auto
udp: true
tls: false
skip-cert-verify: true
network: ws
ws-path: /parchetate/
ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
	#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
	sed -i 's///c/g' patch
	x=$(sed 's/^.//g' patch)
	echo $x > patch
	s=$(sed 's/.$//g' patch)
	echo $s > patch
	parche=$(cat < patch)
	echo "Ruta pach = "$parche
	uid=$(v2ray info | grep UUID)
	uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
	echo "Habilitando Seleccion en Menu"
	#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
	sed -i 's/#- V2ray_vss/- 🦖V2ray_vss/g' /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando IP"
	sed -i "s/ipdelservidor/$addes/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Nombre en Menu"
	sed -i "s/vss/$nameperfil/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando UUID en V2ray"
	sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando SNI del MEtodo"
	sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Puerto V2ray en Clash"
	sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Pach en Clash V2ray"
	sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
	read -p "V2ray Configurado, Enter to Continued"
	else
	echo -e "\033[1;31mV2ray no Found 00x3, V2RAY No INSTALL"
	fi
fi
fi
#FIN V2RAY 2
unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 3?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
#read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖Trojan_Public3_v-4
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public3_v-4/- 🦖Trojan_Public3_v-4/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-4/$nameperfil/g" /root/.config/clash/config.yaml
fi
#V2RAY - 3
unset yesno
echo -e "\033[1;33m Deseas Añadir V2ray 3 SNI si Existe?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
if [[ $(v2ray info | grep TLS) = "TLS: open" ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil 3 Clash de V2RAY"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
read -p ": " v2port
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vxx
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
sed -i 's///c/g' patch
x=$(sed 's/^.//g' patch)
echo $x > patch
s=$(sed 's/.$//g' patch)
echo $s > patch
parche=$(cat < patch)
echo "Ruta pach = "$parche
uid=$(v2ray info | grep UUID)
uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
echo "Habilitando Seleccion en Menu"
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- V2ray_vxx/- 🦖V2ray_vxx/g' /root/.config/clash/config.yaml
sleep 1
echo "Habilitando IP"
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Nombre en Menu"
sed -i "s/vxx/$nameperfil/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando UUID en V2ray"
sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando SNI del MEtodo"
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Puerto V2ray en Clash"
sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Pach en Clash V2ray"
sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
read -p "V2ray Configurado, Enter to Continued"
else
echo -e "\033[1;31mV2ray no Found 00x3, $(v2ray info | grep TLS)"
	if [[ $(v2ray info | grep TLS) = "TLS: close" ]]; then
	unset yesno
	fun_ip
	figlet -p -f smslant < /root/name
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Ingrese ADDRESS / IP "
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " addes
	echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " nameperfil
	echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
	read -p ": " v2port
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
	read -p ": " trosni
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vxx
type: vmess
server: ipdelservidor
port: portacces
mduuid
alterId: 0
cipher: auto
udp: true
tls: false
skip-cert-verify: true
network: ws
ws-path: /parchetate/
ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
	#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
	sed -i 's///c/g' patch
	x=$(sed 's/^.//g' patch)
	echo $x > patch
	s=$(sed 's/.$//g' patch)
	echo $s > patch
	parche=$(cat < patch)
	echo "Ruta pach = "$parche
	uid=$(v2ray info | grep UUID)
	uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
	echo "Habilitando Seleccion en Menu"
	#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
	sed -i 's/#- V2ray_vxx/- 🦖V2ray_vxx/g' /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando IP"
	sed -i "s/ipdelservidor/$addes/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Nombre en Menu"
	sed -i "s/vxx/$nameperfil/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando UUID en V2ray"
	sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando SNI del MEtodo"
	sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Puerto V2ray en Clash"
	sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Pach en Clash V2ray"
	sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
	read -p "V2ray Configurado, Enter to Continued"
	else
	echo -e "\033[1;31mV2ray no Found 00x3, V2RAY No INSTALL"
	fi
fi
fi
#FIN V2RAY 3
unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 4?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖Trojan_Public4_v-5
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public4_v-5/- 🦖Trojan_Public4_v-5/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-5/$nameperfil/g" /root/.config/clash/config.yaml
fi

unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 5?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su 5 Perfil Clash"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖Trojan_Public5_v-6
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public5_v-6/- 🦖Trojan_Public5_v-6/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-6/$nameperfil/g" /root/.config/clash/config.yaml
fi


unset yesno
echo -e "\033[1;33m Deseas Añadir SSR Clash?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
[[ -e /usr/local/shadowsocksr ]] &&
{
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Perfil SSR"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Clave SSR"
read -p ": " claveacces
Set_config_port
Set_config_method
Set_config_protocol
Set_config_obfs
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖SSR-Public_ax1
  type: ssr
  server: ipdelservidor
  port: fghd
  cipher: cpers
  password: claveacces
  obfs: ssr_obpers
  protocol: syca
  obfs-param: sniacces
  protocol-param: "#"
  udp: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- SSR-Public_ax1/- 🦖SSR-Public_ax1/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/cpers/$ssr_method/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/ssr_obpers/$ssr_obfs/g" /root/.config/clash/config.yaml
sed -i "s/syca/$ssr_protocol/g" /root/.config/clash/config.yaml
sed -i "s/fghd/$ssr_port/g" /root/.config/clash/config.yaml
sed -i "s/ax1/$nameperfil/g" /root/.config/clash/config.yaml
} || {
echo -e " Estado actual: ${Red_font_prefix}No Instalado${Font_color_suffix}"
}
fi



unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 6?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el password de Trojan Server"
read -p ": " tropass
echo -e "\033[1;33mÎ” Escriba el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖Trojan_Public6_v-7
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public6_v-7/- 🦖Trojan_Public6_v-7/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-7/$nameperfil/g" /root/.config/clash/config.yaml
fi

unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 7?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods.       ã€‘\033[0m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
#echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
#read -p ": " troport
#echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el password de Trojan Server"
#read -p ": " tropass
echo -e "\033[1;33mÎ” Escriba el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: 🦖Trojan_Public7_v-8
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan_Public7_v-8/- 🦖Trojan_Public7_v-8/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-8/$nameperfil/g" /root/.config/clash/config.yaml
fi

#V2RAY - 4
unset yesno
echo -e "\033[1;33m Deseas Añadir V2ray 4 SNI si Existe?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
if [[ $(v2ray info | grep TLS) = "TLS: open" ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil 3 Clash de V2RAY"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
read -p ": " v2port
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Ingresa el AlterID ( Defauld 0 )"
read -p ": " mekuy
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vxx
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: mekuy
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
sed -i 's///c/g' patch
x=$(sed 's/^.//g' patch)
echo $x > patch
s=$(sed 's/.$//g' patch)
echo $s > patch
parche=$(cat < patch)
echo "Ruta pach = "$parche
uid=$(v2ray info | grep UUID)
uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
echo "Habilitando Seleccion en Menu"
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- V2ray_vxx/- 🦖V2ray_vxx/g' /root/.config/clash/config.yaml
sleep 1
echo "Habilitando IP"
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Nombre en Menu"
sed -i "s/vxx/$nameperfil/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando UUID en V2ray"
sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando SNI del MEtodo"
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando AlterID"
sed -i "s/mfku/$mekuy/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Puerto V2ray en Clash"
sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Pach en Clash V2ray"
sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
read -p "V2ray Configurado, Enter to Continued"
else
echo -e "\033[1;31mV2ray no Found 00x3, $(v2ray info | grep TLS)"
	if [[ $(v2ray info | grep TLS) = "TLS: close" ]]; then
	unset yesno
	fun_ip
	figlet -p -f smslant < /root/name
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Ingrese ADDRESS / IP "
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " addes
	echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	read -p ": " nameperfil
	echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
	read -p ": " v2port
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
	echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
	read -p ": " trosni
	echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: 🦖V2ray_vxx
type: vmess
server: ipdelservidor
port: portacces
mduuid
alterId: 0
cipher: auto
udp: true
tls: false
skip-cert-verify: true
network: ws
ws-path: /parchetate/
ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
	#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
	sed -i 's///c/g' patch 
	x=$(sed 's/^.//g' patch)
	echo $x > patch
	s=$(sed 's/.$//g' patch)
	echo $s > patch
	parche=$(cat < patch)
	echo "Ruta pach = "$parche
	uid=$(v2ray info | grep UUID)
	uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
	echo "Habilitando Seleccion en Menu"
	#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
	sed -i 's/#- V2ray_vxx/- 🦖V2ray_vxx/g' /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando IP"
	sed -i "s/ipdelservidor/$addes/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Nombre en Menu"
	sed -i "s/vxx/$nameperfil/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando UUID en V2ray"
	sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando SNI del MEtodo"
	sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Puerto V2ray en Clash"
	sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
	sleep 1
	echo "Habilitando Pach en Clash V2ray"
	sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
	read -p "V2ray Configurado, Enter to Continued"
	else
	echo -e "\033[1;31mV2ray no Found 00x3, V2RAY No INSTALL"
	fi
fi
fi
#FIN V2RAY 4


figlet -p -f smslant < /root/name
echo -e "🦎” \033[1;32mIniciando y Reiniciando Servicio CLASH > Trojan > V2ray"
sed -i "s/Public/$srvip🪐/g" /root/.config/clash/config.yaml
sed -i 's/ChumoGH-ADM/✵ℂ𝕙𝕦𝕞𝕠𝔾ℍ-𝔸𝔻𝕄✵/g' /root/.config/clash/config.yaml
sed -i 's/🦖Trojan_/✮/g' /root/.config/clash/config.yaml
sed -i 's/🦖/✵/g' /root/.config/clash/config.yaml
#screen -dmS clashse /root/.config/clash/clash
read -p "Ingrese Nombre del Poster WEB de la configuracion: " cocolon
cp /root/.config/clash/config.yaml /var/www/html/$cocolon.yaml
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;32mLink Clash Valido por 30 minutos : http://$IP:81/$cocolon.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
echo "#!/bin/bash
sleep 1800s
rm -rf /var/www/html/$cocolon.yaml
rm -rf /root/.config/clash/$cocolon.sh
exit" > /root/.config/clash/$cocolon.sh && bash /root/.config/clash/$cocolon.sh &
read -p " "
fi