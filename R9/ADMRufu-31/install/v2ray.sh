#!/bin/bash
restart(){
	title "REINICIANDO V2RAY"
	if [[ "$(v2ray restart|awk '{printf $3}')" = "success" ]]; then
		print_center -verd "v2ray restart success !"
	else
		print_center -verm2 "v2ray restart fail !"
	fi
	msg -bar
	sleep 3
}

ins_v2r(){
	title "ESTA POR INSTALAR V2RAY!"
	print_center -ama "La instalacion puede tener alguna fallas!\npor favor observe atentamente el log de intalacion.\npodria contener informacion sobre algunos errores!\ny deveran corregirse de forma manual antes de\ncontinuar usando el script."
	enter
	source <(curl -sL https://multi.netlify.app/v2ray.sh)
}

v2ray_tls(){
	db="$(ls ${ADM_crt})"
    if [[ ! "$(echo "$db"|grep '.crt')" = "" ]]; then
        cert=$(echo "$db"|grep '.crt')
        key=$(echo "$db"|grep '.key')
        DOMI=$(cat "${ADM_src}/dominio.txt")
        title "CERTIFICADO SSL ENCONTRADO"
        echo -e "$(msg -azu "DOMI:") $(msg -ama "$DOMI")"
        echo -e "$(msg -azu "CERT:") $(msg -ama "$cert")"
        echo -e "$(msg -azu "KEY:")  $(msg -ama "$key")"
        msg -bar
        msg -ne " Continuar, usando este certificado [S/N]: " && read opcion_tls

        if [[ $opcion_tls = @(S|s) ]]; then
            cert=$(jq --arg a "${ADM_crt}/$cert" --arg b "${ADM_crt}/$key" '.inbounds[].streamSettings.tlsSettings += {"certificates":[{"certificateFile":$a,"keyFile":$b}]}' < $config)
            domi=$(echo "$cert"|jq --arg a "$DOMI" '.inbounds[] += {"domain":$a}')
            echo "$domi"|jq --arg a 'tls' '.inbounds[].streamSettings += {"security":$a}' > $temp
            chmod 777 $temp
            mv -f $temp $config
            restart
            return
        fi
    fi

	title "CERTIFICADO TLS V2RAY"
	echo -e "\033[1;37m"
	v2ray tls
	enter
 }

removeV2Ray(){
    #V2ray
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove >/dev/null 2>&1
    rm -rf /etc/v2ray >/dev/null 2>&1
    rm -rf /var/log/v2ray >/dev/null 2>&1

    #Xray
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove -x >/dev/null 2>&1
    rm -rf /etc/xray >/dev/null 2>&1
    rm -rf /var/log/xray >/dev/null 2>&1

    #v2ray iptable
    bash <(curl -L -s https://multi.netlify.app/v2ray_util/global_setting/clean_iptables.sh)

    #multi-v2ray
    pip uninstall v2ray_util -y
    rm -rf /usr/share/bash-completion/completions/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/v2ray >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/xray >/dev/null 2>&1
    rm -rf /etc/bash_completion.d/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/local/bin/v2ray >/dev/null 2>&1
    rm -rf /etc/v2ray_util >/dev/null 2>&1

    #v2ray
    crontab -l|sed '/SHELL=/d;/v2ray/d'|sed '/SHELL=/d;/xray/d' > crontab.txt
    crontab crontab.txt >/dev/null 2>&1
    rm -f crontab.txt >/dev/null 2>&1

    systemctl restart cron >/dev/null 2>&1

    #multi-v2ray
    sed -i '/v2ray/d' ~/.bashrc
    sed -i '/xray/d' ~/.bashrc
    source ~/.bashrc

    clear
    msg -bar
    print_center "V2RAY REMOVIDO!"
    enter
    return 1
}

 v2ray_stream(){
 	title "PROTOCOLOS V2RAY"
 	echo -e "\033[1;37m"
	v2ray stream
	msg -bar
	read foo
 }

 port(){
 	port=$(jq -r '.inbounds[].port' $config)
 	title "CONFING PERTO V2RAY"
	print_center -azu "puerto actual: $(msg -ama "$port")"
	back
	in_opcion "Nuevo puerto"
	opcion=$(echo "$opcion" | tr -d '[[:space:]]')
	tput cuu1 && tput dl1
	if [[ -z "$opcion" ]]; then
		msg -ne " deves ingresar una opcion"
		sleep 2
		return
	elif [[ ! $opcion =~ $numero ]]; then
		msg -ne " solo deves ingresar numeros"
		sleep 2
		return
	elif [[ "$opcion" = "0" ]]; then
		return
	fi
	mv $config $temp
	jq --argjson a "$opcion" '.inbounds[] += {"port":$a}' < $temp >> $config
	chmod 777 $config
	rm $temp
	restart
 }

 alterid(){
 	aid=$(jq -r '.inbounds[].settings.clients[0].alterId' $config)
 	title "CONFING alterId V2RAY"
	print_center -azu "alterid actual: $(msg -ama "$aid")"
	back
	in_opcion "Nuevo alterid"
	opcion=$(echo "$opcion" | tr -d '[[:space:]]')
	tput cuu1 && tput dl1
	if [[ -z "$opcion" ]]; then
		msg -ne " deves ingresar una opcion"
		sleep 2
		return
	elif [[ ! $opcion =~ $numero ]]; then
		msg -ne " solo deves ingresar numeros"
		sleep 2
		return
	elif [[ "$opcion" = "0" ]]; then
		return
	fi
	mv $config $temp
	jq --argjson a "$opcion" '.inbounds[].settings.clients[] += {"alterId":$a}' < $temp >> $config
	chmod 777 $config
	rm $temp
	restart
 }

 n_v2ray(){
 	title "CONFIGRACION NATIVA V2RAY"
 	echo -ne "\033[1;37m"
	v2ray
 }

 address(){
 	add=$(jq -r '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
 	title "CONFING address V2RAY"
	print_center -azu "actual: $(msg -ama "$add")"
	back
	in_opcion "Nuevo address"
	opcion=$(echo "$opcion" | tr -d '[[:space:]]')
	tput cuu1 && tput dl1
	if [[ -z "$opcion" ]]; then
		msg -ne " deves ingresar una opcion"
		sleep 2
		return
	elif [[ "$opcion" = "0" ]]; then
		return
	fi
	mv $config $temp
	jq --arg a "$opcion" '.inbounds[] += {"domain":$a}' < $temp >> $config
	chmod 777 $config
	rm $temp
	restart
 }

 host(){
 	host=$(jq -r '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='sin host'
 	title "CONFING host V2RAY"
	print_center -azu "Actual: $(msg -ama "$host")"
	back
	in_opcion "Nuevo host"
	opcion=$(echo "$opcion" | tr -d '[[:space:]]')
	tput cuu1 && tput dl1
	if [[ -z "$opcion" ]]; then
		msg -ne " deves ingresar una opcion"
		sleep 2
		return
	elif [[ "$opcion" = "0" ]]; then
		return
	fi
	mv $config $temp
	jq --arg a "$opcion" '.inbounds[].streamSettings.wsSettings.headers += {"Host":$a}' < $temp >> $config
	chmod 777 $config
	rm $temp
	restart
 }

 path(){
 	path=$(jq -r '.inbounds[].streamSettings.wsSettings.path' $config) && [[ $path = null ]] && path=''
 	title "CONFING path V2RAY"
	print_center -azu "Actual: $(msg -ama "$path")"
	back
	in_opcion "Nuevo path"
	opcion=$(echo "$opcion" | tr -d '[[:space:]]')
	tput cuu1 && tput dl1
	if [[ -z "$opcion" ]]; then
		msg -ne " deves ingresar una opcion"
		sleep 2
		return
	elif [[ "$opcion" = "0" ]]; then
		return
	fi
	mv $config $temp
	jq --arg a "$opcion" '.inbounds[].streamSettings.wsSettings += {"path":$a}' < $temp >> $config
	chmod 777 $config
	rm $temp
	restart
 }

 reset(){
 	title "RESTAURANDO AJUSTES V2RAY"
 	#resolver imprecion de texto
 	user=$(jq -c '.inbounds[].settings.clients' < $config)

 	v2ray new
 	jq 'del(.inbounds[].streamSettings.kcpSettings[])' < $config > $temp
 	rm $config
    jq '.inbounds[].streamSettings += {"network":"ws","wsSettings":{"path": "/ADMRufu/","headers": {"Host": "ejemplo.com"}}}' < $temp > $config
    chmod 777 $config
    rm $temp
    sleep 2
    if [[ ! -z "$user" ]]; then
    	title "RESATURANDO USUARIOS"
    	mv $config $temp
    	jq --argjson a "$user" '.inbounds[].settings += {"clients":$a}' < $temp > $config
    	chmod 777 $config
    	sleep 2
    	restart
    fi
 }

while :
do
	clear
	msg -bar
	print_center -verd "v2ray manager by @Rufu99"
	msg -bar
	msg -ama "INSTALACION"
	msg -bar3
	menu_func "$(msg -verd "INSTALL/RE-REINSTALL V2RAY")" \
	"$(msg -verm2 "DESINSTALAR V2RAY")\n$(msg -bar3)\n$(msg -ama "CONFIGRACION")\n$(msg -bar3)" \
	"Certif ssl/tls $(msg -ama "(menu nativo)")" \
	"Protocolos $(msg -ama "(menu nativo)")" \
	"puerto" \
	"alterId" \
	"Conf v2ray $(msg -ama "(menu nativo)")\n$(msg -bar3)\n$(msg -ama "CLIENTES")\n$(msg -bar3)" \
	"address" \
	"Host" \
	"Path\n$(msg -bar3)\n$(msg -ama "EXTRAS")\n$(msg -bar3)" \
	"Restablecer ajustes"
	back
	opcion=$(selection_fun 12)
	case $opcion in
		1)ins_v2r;;
		2)removeV2Ray;;
		3)v2ray_tls;;
		4)v2ray_stream;;
		5)port;;
		6)alterid;;
		7)n_v2ray;;
		8)address;;
		9)host;;
		10)path;;
		11)reset;;
		0)break;;
	esac
	[[ "$?" = "1" ]] && break
done
return 1