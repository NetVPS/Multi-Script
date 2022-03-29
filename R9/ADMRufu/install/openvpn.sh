#!/bin/bash
#19/12/2019
clear
msg -bar

# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	print_center -ama "Este script se utiliza con bash"
	enter
fi

if [[ "$EUID" -ne 0 ]]; then
	print_center -ama "Sorry, solo funciona como root"
	enter
fi

if [[ ! -e /dev/net/tun ]]; then
	print_center -ama "El TUN device no esta disponible"
	print_center -ama "Necesitas habilitar TUN antes de usar este script"
	enter
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	print_center -ama "Sistema no compatible para este script"
	enter
fi
del(){
	for (( i = 0; i < $1; i++ )); do
		tput cuu1 && tput dl1
	done
}

agrega_dns(){
	msg -ama " Escriba el HOST DNS que desea Agregar"
	read -p " [NewDNS]: " SDNS
	cat /etc/hosts|grep -v "$SDNS" > /etc/hosts.bak && mv -f /etc/hosts.bak /etc/hosts
	if [[ -e /etc/opendns ]]; then
		cat /etc/opendns > /tmp/opnbak
		mv -f /tmp/opnbak /etc/opendns
		echo "$SDNS" >> /etc/opendns 
	else
		echo "$SDNS" > /etc/opendns
	fi
	[[ -z $NEWDNS ]] && NEWDNS="$SDNS" || NEWDNS="$NEWDNS $SDNS"
	unset SDNS
}

dns_fun(){
	case $1 in
		1)
			if grep -q "127.0.0.53" "/etc/resolv.conf"; then
				RESOLVCONF='/run/systemd/resolve/resolv.conf'
			else
				RESOLVCONF='/etc/resolv.conf'
			fi 
			grep -v '#' $RESOLVCONF | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
				echo "push \"dhcp-option DNS $line\"" >> /etc/openvpn/server.conf
			done;;
		2) #cloudflare
			echo 'push "dhcp-option DNS 1.1.1.1"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 1.0.0.1"' >> /etc/openvpn/server.conf;;
		3) #google
			echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server.conf;;
		4) #OpenDNS
			echo 'push "dhcp-option DNS 208.67.222.222"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 208.67.220.220"' >> /etc/openvpn/server.conf;;
		5) #Verisign
			echo 'push "dhcp-option DNS 64.6.64.6"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 64.6.65.6"' >> /etc/openvpn/server.conf;;
		6) #Quad9
			echo 'push "dhcp-option DNS 9.9.9.9"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 149.112.112.112"' >> /etc/openvpn/server.conf;;
		7) #UncensoredDNS
			echo 'push "dhcp-option DNS 91.239.100.100"' >> /etc/openvpn/server.conf
			echo 'push "dhcp-option DNS 89.233.43.71"' >> /etc/openvpn/server.conf;;
	esac
}

IP="$(fun_ip)"

instala_ovpn(){
	clear
	msg -bar
	print_center -ama "INSTALADOR DE OPENVPN"
	msg -bar
	# OpenVPN setup and first user creation
	msg -ama " Algunos ajustes son necesario para conf OpenVPN"
	msg -bar
	# Autodetect IP address and pre-fill for the user
	IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
	if echo "$IP" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then
		PUBLICIP=$(fun_ip)
	fi
	msg -ama "    Seleccione el protocolo de conexiones OpenVPN"
	msg -bar
	menu_func "UDP" "TCP"
	msg -bar
	while [[ -z $PROTOCOL ]]; do
		msg -ne " opcion: "
		read PROTOCOL
		case $PROTOCOL in
			1)PROTOCOL=udp; del "6"; msg -nazu " PROTOCOLO: "; msg -verd "UDP";;
			2)PROTOCOL=tcp; del "6"; msg -nazu " PROTOCOLO: "; msg -verd "TCP";;
			*)tput cuu1 && tput dl1; print_center -verm2 "selecciona una opcion entre 1 y 2"; sleep 2s; tput cuu1 && tput dl1; unset PROTOCOL;;
		esac
	done
	msg -bar
	print_center -ama "Ingresa un puerto OpenVPN (Default 1194)"
	msg -bar
	while [[ -z $PORT ]]; do
		msg -ne " Puerto: "
		read PORT
		if [[ -z $PORT ]]; then
			PORT="1194"
		elif [[ ! $PORT =~ $numero ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "ingresa solo numeros"
			sleep 2s
			tput cuu1 && tput dl1
			unset PORT
		fi

		[[ $(mportas|grep -w "${PORT}") ]] && {
			tput cuu1 && tput dl1
			print_center -verm2 "Puerto en uso"
			sleep 2s
			tput cuu1 && tput dl1
			unset PORT
        }
	done
	del "3"
	msg -nazu " PUERTO: "; msg -verd "$PORT"
	msg -bar
	print_center -ama "Seleccione DNS (default VPS)"
	msg -bar
	menu_func "DNS del Sistema" "Cloudflare" "Google" "OpenDNS" "Verisign" "Quad9" "UncensoredDNS"
	msg -bar
	while [[ -z $DNS ]]; do
		msg -ne " opcion: "
		read DNS
		if [[ -z $DNS ]]; then
			DNS="1"
		elif [[ ! $DNS =~ $numero ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "ingresa solo numeros"
			sleep 2s
			tput cuu1 && tput dl1
			unset DNS
		elif [[ $DNS != @([1-7]) ]]; then
			tput cuu1 && tput dl1
			print_center -ama "solo numeros entre 1 y 7"
			sleep 2s
			tput cuu1 && tput dl1
			unset DNS
		fi
	done
	case $DNS in
		1)P_DNS="DNS del Sistema";;
		2)P_DNS="Cloudflare";;
		3)P_DNS="Google";;
		4)P_DNS="OpenDNS";;
		5)P_DNS="Verisign";;
		6)P_DNS="Quad9";;
		7)P_DNS="UncensoredDNS";;
	esac
	del "11"
	msg -nazu " DNS: "; msg -verd "$P_DNS"
	msg -bar
	print_center -ama " Seleccione la codificacion para el canal de datos"
	msg -bar
	menu_func "AES-128-CBC" "AES-192-CBC" "AES-256-CBC" "CAMELLIA-128-CBC" "CAMELLIA-192-CBC" "CAMELLIA-256-CBC" "SEED-CBC" "NONE"
	msg -bar
	while [[ -z $CIPHER ]]; do
		msg -ne " opcion: "
		read CIPHER
		if [[ -z $CIPHER ]]; then
			CIPHER="1"
		elif [[ ! $CIPHER =~ $numero ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "ingresa solo numeros"
			sleep 2s
			tput cuu1 && tput dl1
			unset CIPHER
		elif [[ $CIPHER != @([1-8]) ]]; then
			tput cuu1 && tput dl1
			print_center -ama "solo numeros entre 1 y 8"
			sleep 2s
			tput cuu1 && tput dl1
			unset CIPHER
		fi
	done
	case $CIPHER in
		1) CIPHER="cipher AES-128-CBC";;
		2) CIPHER="cipher AES-192-CBC";;
		3) CIPHER="cipher AES-256-CBC";;
		4) CIPHER="cipher CAMELLIA-128-CBC";;
		5) CIPHER="cipher CAMELLIA-192-CBC";;
		6) CIPHER="cipher CAMELLIA-256-CBC";;
		7) CIPHER="cipher SEED-CBC";;
		8) CIPHER="cipher none";;
	esac
	del "12"
	codi=$(echo $CIPHER|awk -F ' ' '{print $2}')
	msg -nazu " CODIFICACION: "; msg -verd "$codi"
	msg -bar
	msg -ama " Estamos listos para configurar su servidor OpenVPN"
	enter
	if [[ "$OS" = 'debian' ]]; then
		apt-get update
		apt-get install openvpn iptables openssl ca-certificates -y
	else
		# 
		yum install epel-release -y
		yum install openvpn iptables openssl ca-certificates -y
	fi
	# Get easy-rsa
	EASYRSAURL='https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz'
	wget -O ~/easyrsa.tgz "$EASYRSAURL" 2>/dev/null || curl -Lo ~/easyrsa.tgz "$EASYRSAURL"
	tar xzf ~/easyrsa.tgz -C ~/
	mv ~/EasyRSA-3.0.7/ /etc/openvpn/
	mv /etc/openvpn/EasyRSA-3.0.7/ /etc/openvpn/easy-rsa/
	chown -R root:root /etc/openvpn/easy-rsa/
	rm -f ~/easyrsa.tgz
	cd /etc/openvpn/easy-rsa/
	# 
	./easyrsa init-pki
	./easyrsa --batch build-ca nopass
	./easyrsa gen-dh
	./easyrsa build-server-full server nopass
	EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
	# 
	cp pki/ca.crt pki/private/ca.key pki/dh.pem pki/issued/server.crt pki/private/server.key pki/crl.pem /etc/openvpn
	# 
	chown nobody:$GROUPNAME /etc/openvpn/crl.pem
	# 
	openvpn --genkey --secret /etc/openvpn/ta.key
	# 
	echo "port $PORT
proto $PROTOCOL
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA512
tls-auth ta.key 0
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
	echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
	# DNS

	dns_fun "$DNS"
	
	echo "keepalive 10 120
${CIPHER}
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
verb 3
crl-verify crl.pem" >> /etc/openvpn/server.conf
updatedb
PLUGIN=$(locate openvpn-plugin-auth-pam.so | head -1)
[[ ! -z $(echo ${PLUGIN}) ]] && {
echo "client-to-client
client-cert-not-required
username-as-common-name
plugin $PLUGIN login" >> /etc/openvpn/server.conf
}
	# 
	echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/30-openvpn-forward.conf
	# 
	echo 1 > /proc/sys/net/ipv4/ip_forward
	if pgrep firewalld; then
		# 
		#
		# 
		# 
		firewall-cmd --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --zone=trusted --add-source=10.8.0.0/24
		firewall-cmd --permanent --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
		# 
		firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
		firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
	else
		# 
		if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
			echo '#!/bin/sh -e
exit 0' > $RCLOCAL
		fi
		chmod +x $RCLOCAL
		# 
		iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
		sed -i "1 a\iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP" $RCLOCAL
		if iptables -L -n | grep -qE '^(REJECT|DROP)'; then
			#
			# 
			# 
			iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
			iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
			iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
			sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
		fi
	fi
	# 
	if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
		# 
		if ! hash semanage 2>/dev/null; then
			yum install policycoreutils-python -y
		fi
		semanage port -a -t openvpn_port_t -p $PROTOCOL $PORT
	fi
	# 
	if [[ "$OS" = 'debian' ]]; then
		# 
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
		else
			/etc/init.d/openvpn restart
		fi
	else
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
			systemctl enable openvpn@server.service
		else
			service openvpn restart
			chkconfig openvpn on
		fi
	fi
	# 
	if [[ "$PUBLICIP" != "" ]]; then
		IP=$PUBLICIP
	fi
	# 
	echo "# OVPN_ACCESS_SERVER_PROFILE=ADMRufu
client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
remote $IP $PORT
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA512
${CIPHER}
setenv opt block-outside-dns
key-direction 1
verb 3
auth-user-pass" > /etc/openvpn/client-common.txt
clear
msg -bar
print_center -verd "Configuracion Finalizada!"
msg -bar
print_center -ama " Crear un usuario SSH para generar el (.ovpn)!"
enter
}

edit_ovpn_host(){
	msg -ama " CONFIGURACION HOST DNS OPENVPN"
	msg -bar
	while [[ $DDNS != @(n|N) ]]; do
		echo -ne "\033[1;33m"
		read -p " Agregar host [S/N]: " -e -i n DDNS
		[[ $DDNS = @(s|S|y|Y) ]] && agrega_dns
	done
	[[ ! -z $NEWDNS ]] && sed -i "/127.0.0.1[[:blank:]]\+localhost/a 127.0.0.1 $NEWDNS" /etc/hosts
	msg -bar
	msg -ama " Es Necesario el Reboot del Servidor Para"
	msg -ama " Para que las configuraciones sean efectudas"
	enter
}

fun_openvpn(){
	[[ -e /etc/openvpn/server.conf ]] && {
		unset OPENBAR
		[[ $(mportas|grep -w "openvpn") ]] && OPENBAR="\033[1;32m [ONLINE]" || OPENBAR="\033[1;31m [OFFLINE]"
		clear
		msg -bar
		print_center -ama "CONFIGURACION OPENVPN"
		msg -bar

		menu_func "$(msg -verd "INICIAR O PARAR OPENVPN") $OPENBAR" "EDITAR CONFIGURACION CLIENTE $(msg -ama "(MEDIANTE NANO)")" "EDITAR CONFIGURACION SERVIDOR $(msg -ama "(MEDIANTE NANO)")" "CAMBIAR HOST DE OPENVPN" "$(msg -verm2 "DESINSTALAR OPENVPN")"
		back
		while [[ $xption != @([0-5]) ]]; do
			echo -ne "\033[1;33m $(fun_trans "Opcion"): " && read xption
			tput cuu1 && tput dl1
		done
		case $xption in 
			5)
				clear
				msg -bar
				echo -ne "\033[1;97m"
				read -p "QUIERES DESINTALAR OPENVPN? [Y/N]: " -e REMOVE
				msg -bar
				if [[ "$REMOVE" = 'y' || "$REMOVE" = 'Y' ]]; then
					PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
					PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
					if pgrep firewalld; then
						IP=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.8.0.0/24 '"'"'!'"'"' -d 10.8.0.0/24 -j SNAT --to ' | cut -d " " -f 10)
						# 
						firewall-cmd --zone=public --remove-port=$PORT/$PROTOCOL
						firewall-cmd --zone=trusted --remove-source=10.8.0.0/24
						firewall-cmd --permanent --zone=public --remove-port=$PORT/$PROTOCOL
						firewall-cmd --permanent --zone=trusted --remove-source=10.8.0.0/24
						firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
						firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
					else
						IP=$(grep 'iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to ' $RCLOCAL | cut -d " " -f 14)
						iptables -t nat -D POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
						sed -i '/iptables -t nat -A POSTROUTING -s 10.8.0.0\/24 ! -d 10.8.0.0\/24 -j SNAT --to /d' $RCLOCAL
						if iptables -L -n | grep -qE '^ACCEPT'; then
							iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
							iptables -D FORWARD -s 10.8.0.0/24 -j ACCEPT
							iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
							sed -i "/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT/d" $RCLOCAL
							sed -i "/iptables -I FORWARD -s 10.8.0.0\/24 -j ACCEPT/d" $RCLOCAL
							sed -i "/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT/d" $RCLOCAL
						fi
					fi
					if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
						semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT
					fi
					if [[ "$OS" = 'debian' ]]; then
						apt-get remove --purge -y openvpn
					else
						yum remove openvpn -y
					fi
					rm -rf /etc/openvpn
					rm -f /etc/sysctl.d/30-openvpn-forward.conf
					clear
					msg -bar
					print_center -verd "OpenVPN removido!"
					enter
				else
					clear
					msg -bar
					print_center -verm2 "Desinstalacion abortada!"
					enter
				fi
				return 1;;
			2)
				nano /etc/openvpn/client-common.txt;;
			3)
				nano /etc/openvpn/server.conf;;
			4)
				edit_ovpn_host;;
			1)
				[[ $(mportas|grep -w openvpn) ]] && {
					/etc/init.d/openvpn stop > /dev/null 2>&1
					killall openvpn &>/dev/null
					systemctl stop openvpn@server.service &>/dev/null
					service openvpn stop &>/dev/null
					#ps x |grep openvpn |grep -v grep|awk '{print $1}' | while read pid; do kill -9 $pid; done
				} || {
					cd /etc/openvpn
					screen -dmS ovpnscr openvpn --config "server.conf" > /dev/null 2>&1
					cd $HOME
				}
				print_center -ama "Procedimiento con Exito"
				enter;;
			0)
				return 1;;
		esac
		return 0
	}
	[[ -e /etc/squid/squid.conf ]] && instala_ovpn && return 0
	[[ -e /etc/squid3/squid.conf ]] && instala_ovpn && return 0
	instala_ovpn || return 1
}

while [[ ! $rec = 1 ]]; do
	fun_openvpn
	rec="$?"
	unset xption
done
return 1