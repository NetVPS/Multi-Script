#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $v2rdir/conf ]] && echo "autBackup 0" > $v2rdir/conf
if [[ $(cat $v2rdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $v2rdir/conf
fi
barra="\033[0;31m=====================================================\033[0m"
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')

 
on_off_res(){
	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		echo -e "\033[0;31m[off]"
	else
		echo -e "\033[1;92m[on]"
	fi
 }

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
}

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}

col2(){

	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}

vacio(){

	blanco "\n no se puede ingresar campos vacios..."
}

cancelar(){

	echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}

continuar(){

	echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}

title2(){
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	echo -e $barra
	[[ $v1 = $v2 ]] && echo -e "   \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] \033[0m" || echo -e " \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] >> \033[1;92m[$v2] \033[0m"
}

title(){
	echo -e $barra
	blanco "$1"
	echo -e $barra
}

userDat(){
	blanco "	N°    Usuarios 		  fech exp   dias"
	echo -e $barra
}


restart_v2r(){
	v2ray restart
	#echo "reiniciando"
}

add_user(){
	users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"
	opcion=$name
	dias=$tdias
	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios
	mv $config $temp
	num=$(jq '.inbounds[].settings.clients | length' $temp)
	new=".inbounds[].settings.clients[$num]"
	new_id=$(uuidgen)
	new_mail="email:\"$opcion\""
	aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
	echo jq \'$new += \{alterId:${aid},id:\"$new_id\","$new_mail"\}\' $temp \> $config | bash
	echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	restart_v2r
	view_user $opcion
	}


view_user(){
name=$1
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp
			[[ $name = "$i" ]] && escopt="$n"
			let n++
		done
		opcion=$escopt
		let opcion--

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config) && [[ $path = null ]] && path=''
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		tput cuu1 >&2 && tput dl1 >&2
		tput cuu1 >&2 && tput dl1 >&2
		blanco $barra
		blanco "              VMESS LINK CONFIG"
		blanco $barra
		vmess
		blanco $barra
		echo -n "vmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)" | qrencode -s8 -o /bin/ejecutar/${name}_vmess_qr.png
		[[ -e /bin/ejecutar/${name}_vmess_qr.png ]] && {
		mv /bin/ejecutar/${name}_vmess_qr.png /var/www/html/${name}_vmess_qr.png 
		echo -e "vmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)" > /bin/ejecutar/${name}_vmess.txt
		echo -e "QR Code : http://$(wget -qO- ipv4.icanhazip.com):81/${name}_vmess_qr.png "
		} || echo -e "ERROR AL CREAR QR"
		blanco $barra
		break
	done
}

vmess() {
	echo -ne "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m" && echo	
}


[[ $1 = "" && $2 = "" ]] && {
	exit
} || {
	name="$1"
	tdias="$2"
	add_user
}
