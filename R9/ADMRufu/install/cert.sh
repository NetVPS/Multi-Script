#!/bin/bash
#====FUNCIONES==========

cert_install(){
    #apt install socat netcat -y
    if [[ ! -e $HOME/.acme.sh/acme.sh ]];then
    	msg -bar3
    	msg -ama " Instalando script acme.sh"
    	curl -s "https://get.acme.sh" | sh &>/dev/null
    fi
    if [[ ! -z "${mail}" ]]; then
    	title "LOGEANDO EN Zerossl"
    	sleep 3
    	$HOME/.acme.sh/acme.sh --register-account  -m ${mail} --server zerossl
    	$HOME/.acme.sh/acme.sh --set-default-ca --server zerossl
    	enter
    else
    	title "APLICANDO SERVIDOR letsencrypt"
    	sleep 3
    	$HOME/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    	enter
    fi
    title "GENERANDO CERTIFICADO SSL"
    sleep 3
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
    	"$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath ${ADM_crt}/${domain}.crt --keypath ${ADM_crt}/${domain}.key --ecc --force &>/dev/null
    	rm -rf $HOME/.acme.sh/${domain}_ecc
    	msg -bar
    	print_center -verd "Certificado SSL se genero con éxito"
    	enter
    	return 1
    else
    	rm -rf "$HOME/.acme.sh/${domain}_ecc"
    	msg -bar
    	print_center -verm2 "Error al generar el certificado SSL"
    	msg -bar
    	msg -ama " verifique los posibles error"
    	msg -ama " e intente de nuevo"
    	enter
    	return 1
    fi
 }

ext_cert(){
	unset cert
	declare -A cert
	title "INTALADOR DE CERTIFICADO EXTERNO"
	print_center -azu "Requiere tener a mano su certificado ssl"
	print_center -azu "junto a su correspondiente clave privada"
	msg -bar
	msg -ne " Continuar...[S/N]: "
	read opcion
	[[ $opcion != @(S|s|Y|y) ]] && return 1


	title "INGRESE EL CONTENIDO DE SU CERTIFICADO SSL"
	msg -ama ' a continuacion se abrira el editor de texto nano 
 ingrese el contenido de su certificado
 guardar precionando "CTRL+x"
 luego "S o Y" segun el idioma
 y por ultimo "enter"'
 	msg -bar
 	msg -ne " Continuar...[S/N]: "
	read opcion
	[[ $opcion != @(S|s|Y|y) ]] && return 1
	rm -rf ${ADM_tmp}/tmp.crt
	clear
	nano ${ADM_tmp}/tmp.crt

	title "INGRESE EL CONTENIDO DE CLAVE PRIVADA"
	msg -ama ' a continuacion se abrira el editor de texto nano 
 ingrese el contenido de su clave privada.
 guardar precionando "CTRL+x"
 luego "S o Y" segun el idioma
 y por ultimo "enter"'
 	msg -bar
 	msg -ne " Continuar...[S/N]: "
	read opcion
	[[ $opcion != @(S|s|Y|y) ]] && return 1
	${ADM_tmp}/tmp.key
	clear
	nano ${ADM_tmp}/tmp.key

	if openssl x509 -in ${ADM_tmp}/tmp.crt -text -noout &>/dev/null ; then
		DNS=$(openssl x509 -in ${ADM_tmp}/tmp.crt -text -noout | grep 'DNS:'|sed 's/, /\n/g'|sed 's/DNS:\| //g')
		rm -rf ${ADM_crt}/*
		if [[ $(echo "$DNS"|wc -l) -gt "1" ]]; then
			DNS="multi-domain"
		fi
		mv ${ADM_tmp}/tmp.crt ${ADM_crt}/$DNS.crt
		mv ${ADM_tmp}/tmp.key ${ADM_crt}/$DNS.key

		title "INSTALACION COMPLETA"
		echo -e "$(msg -verm2 "Domi: ")$(msg -ama "$DNS")"
		echo -e "$(msg -verm2 "Emit: ")$(msg -ama "$(openssl x509 -noout -in ${ADM_crt}/$DNS.crt -startdate|sed 's/notBefore=//g')")"
		echo -e "$(msg -verm2 "Expi: ")$(msg -ama "$(openssl x509 -noout -in ${ADM_crt}/$DNS.crt -enddate|sed 's/notAfter=//g')")"
		echo -e "$(msg -verm2 "Cert: ")$(msg -ama "$(openssl x509 -noout -in ${ADM_crt}/$DNS.crt -issuer|sed 's/issuer=//g'|sed 's/ = /=/g'|sed 's/, /\n      /g')")"
		msg -bar
		echo "$DNS" > ${ADM_src}/dominio.txt
		read foo
	else
		rm -rf ${ADM_tmp}/tmp.crt
		rm -rf ${ADM_tmp}/tmp.key
		clear
		msg -bar
		print_center -verm2 "ERROR DE DATOS"
		msg -bar
		msg -ama " Los datos ingresados no son validos.\n por favor verifique.\n e intente de nuevo!!"
		msg -bar
		read foo
	fi
	return 1
}

stop_port(){
	msg -bar3
	msg -ama " Comprovando puertos..."
	ports=('80' '443')

	for i in ${ports[@]}; do
		if [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]]; then
			msg -bar3
			echo -ne "$(msg -ama " Liberando puerto: $i")"
			lsof -i:$i | awk '{print $2}' | grep -v "PID" | xargs kill -9
			sleep 2s
			if [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]];then
				tput cuu1 && tput dl1
				print_center -verm2 "ERROR AL LIBERAR PURTO $i"
				msg -bar3
				msg -ama " Puerto $i en uso."
				msg -ama " auto-liberacion fallida"
				msg -ama " detenga el puerto $i manualmente"
				msg -ama " e intentar nuevamente..."
				msg -bar
				read foo
				return 1			
			fi
		fi
	done
 }

ger_cert(){
	clear
	case $1 in
		1)title "Generador De Certificado Let's Encrypt";;
		2)title "Generador De Certificado Zerossl";;
	esac
	print_center -ama "Requiere ingresar un dominio."
	print_center -ama "el mismo solo deve resolver DNS, y apuntar"
	print_center -ama "a la direccion ip de este servidor."
	msg -bar3
	print_center -ama "Temporalmente requiere tener"
	print_center -ama "los puertos 80 y 443 libres."
	if [[ $1 = 2 ]]; then
		msg -bar3
		print_center -ama "Requiere tener una cuenta Zerossl."
	fi
	msg -bar
 	msg -ne " Continuar [S/N]: "
	read opcion
	[[ $opcion != @(s|S|y|Y) ]] && return 1

	if [[ $1 = 2 ]]; then
     while [[ -z $mail ]]; do
     	clear
		msg -bar
		print_center -ama "ingresa tu correo usado en zerossl"
		msg -bar3
		msg -ne " >>> "
		read mail
	 done
	fi

	if [[ -e ${ADM_src}/dominio.txt ]]; then
		domain=$(cat ${ADM_src}/dominio.txt)
		[[ $domain = "multi-domain" ]] && unset domain
		if [[ ! -z $domain ]]; then
			clear
			msg -bar
			print_center -azu "Dominio asociado a esta ip"
			msg -bar3
			echo -e "$(msg -verm2 " >>> ") $(msg -ama "$domain")"
			msg -ne "Continuar, usando este dominio? [S/N]: "
			read opcion
			tput cuu1 && tput dl1
			[[ $opcion != @(S|s|Y|y) ]] && unset domain
		fi
	fi

	while [[ -z $domain ]]; do
		clear
		msg -bar
		print_center -ama "ingresa tu dominio"
		msg -bar3
		msg -ne " >>> "
		read domain
	done
	msg -bar3
	msg -ama " Comprovando direccion IP ..."
	local_ip=$(wget -qO- ipv4.icanhazip.com)
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
    sleep 3
    [[ -z "${domain_ip}" ]] && domain_ip="ip no encontrada"
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -ne $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
    	clear
    	msg -bar
    	print_center -verm2 "ERROR DE DIRECCION IP"
    	msg -bar
    	msg -ama " La direccion ip de su dominio\n no coincide con la de su servidor."
    	msg -bar3
    	echo -e " $(msg -azu "IP dominio:  ")$(msg -verm2 "${domain_ip}")"
    	echo -e " $(msg -azu "IP servidor: ")$(msg -verm2 "${local_ip}")"
    	msg -bar3
    	msg -ama " Verifique su dominio, e intente de nuevo."
    	msg -bar
    	read foo
    	return 1
    fi

    
    stop_port
    cert_install
    echo "$domain" > ${ADM_src}/dominio.txt
    return 1
}

gen_domi(){
	title "GENERADOR DE SUB-DOMINIOS"
	msg -ama " Verificando direccion ip..."
	sleep 2

	ls_dom=$(curl -s -X GET "$url/$_dns/dns_records?per_page=100" \
     -H "X-Auth-Email: $correo" \
     -H "X-Auth-Key: $apikey" \
     -H "Content-Type: application/json" | jq '.')

    num_line=$(echo $ls_dom | jq '.result | length')
    ls_domi=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')
    my_ip=$(wget -qO- ipv4.icanhazip.com)

	if [[ $(echo "$ls_ip"|grep -w "$my_ip") = "$my_ip" ]];then
		for (( i = 0; i < $num_line; i++ )); do
			if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$my_ip") = "$my_ip" ]]; then
				domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
				echo "$domain" > ${ADM_src}/dominio.txt
				break
			fi
		done
		tput cuu1 && tput dl1
		print_center -azu "ya existe un sub-dominio asociado a esta IP"
		msg -bar
		echo -e " $(msg -verm2 "sub-dominio:") $(msg -ama "$domain")"
		msg -bar
		read foo
		return 1
    fi

    if [[ -z $name ]]; then
    	tput cuu1 && tput dl1
		echo -e " $(msg -azu "El dominio principal es:") $(msg -ama "$_domain")\n $(msg -azu "El sub-dominio sera:") $(msg -ama "ejemplo.$_domain")"
		msg -bar
    	while [[ -z "$name" ]]; do
    		msg -ne " Nombre (ej: vpsfull) >>> "
    		read name
    		tput cuu1 && tput dl1

    		name=$(echo "$name" | tr -d '[[:space:]]')

    		if [[ -z $name ]]; then
    			msg -verm2 " ingresar un nombre...!"
    			unset name
    			sleep 2
    			tput cuu1 && tput dl1
    			continue
    		elif [[ ! $name =~ $tx_num ]]; then
    			msg -verm2 " ingresa solo letras y numeros...!"
    			unset name
    			sleep 2
    			tput cuu1 && tput dl1
    			continue
    		elif [[ "${#name}" -lt "4" ]]; then
    			msg -verm2 " nombre demaciado corto!"
    			sleep 2
    			tput cuu1 && tput dl1
    			unset name
    			continue
    		else
    			domain="$name.$_domain"
    			msg -ama " Verificando disponibiliad..."
    			sleep 2
    			tput cuu1 && tput dl1
    			if [[ $(echo "$ls_domi" | grep "$domain") = "" ]]; then
    				echo -e " $(msg -verd "[ok]") $(msg -azu "sub-dominio disponible")"
    				sleep 2
    			else
    				echo -e " $(msg -verm2 "[fail]") $(msg -azu "sub-dominio NO disponible")"
    				unset name
    				sleep 2
    				tput cuu1 && tput dl1
    				continue
    			fi
    		fi
    	done
    fi
    tput cuu1 && tput dl1
    echo -e " $(msg -azu "El sub-dominio sera:") $(msg -verd "$domain")"
    msg -bar
    msg -ne " Continuar...[S/N]: "
    read opcion
    [[ $opcion = @(n|N) ]] && return 1
    tput cuu1 && tput dl1
    print_center -azu "Creando sub-dominio"
    sleep 1

    var=$(cat <<EOF
{
  "type": "A",
  "name": "$name",
  "content": "$my_ip",
  "ttl": 1,
  "priority": 10,
  "proxied": false
}
EOF
)
    chek_domain=$(curl -s -X POST "$url/$_dns/dns_records" \
    -H "X-Auth-Email: $correo" \
    -H "X-Auth-Key: $apikey" \
    -H "Content-Type: application/json" \
    -d $(echo $var|jq -c '.')|jq '.')

    tput cuu1 && tput dl1
    if [[ "$(echo $chek_domain|jq -r '.success')" = "true" ]]; then
    	echo "$(echo $chek_domain|jq -r '.result.name')" > ${ADM_src}/dominio.txt
    	print_center -verd "Sub-dominio creado con exito!"
    else
    	echo "" > ${ADM_src}/dominio.txt
    	print_center -ama "Falla al crear Sub-dominio!" 	
    fi
    enter
    return 1
}

ger_cert_z(){
	echo ""

}

#======MENU======
menu_cert(){
title "SUB-DOMINIO Y CERTIFICADO SSL"
menu_func "GENERAR CERT SSL (Let's Encrypt)" "GENERAR CERT SSL (Zerossl)" "INGRESAR CERT SSL EXTERNO" "GENERAR SUB-DOMINIO"
back
in_opcion "Opcion"

case $opcion in
	1)ger_cert 1;;
	2)ger_cert 2;;
	3)ext_cert;;
	4)gen_domi;;
	0)return 1;;
esac
}

menu_cert
