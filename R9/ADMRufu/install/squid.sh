#!/bin/bash
lshost(){
  n=1
    for i in `cat $payload|awk -F "/" '{print $1,$2,$3,$4}'`; do
      echo -e " $(msg -verd "$n)") $(msg -verm2 ">") $(msg -teal "$i")"
      pay[$n]=$i
      let n++
    done
}

lsexpre(){
    n=1
    while read line; do
    	echo -e " $(msg -verd "$n)") $(msg -verm2 ">") $(msg -teal "$line")"
    	pay[$n]=$line
    	let n++
    done <<< $(cat $payload2)
}

fun_squid(){
  if [[ -e /etc/squid/squid.conf ]]; then
    var_squid="/etc/squid/squid.conf"
    mipatch="/etc/squid"
  elif [[ -e /etc/squid3/squid.conf ]]; then
    var_squid="/etc/squid3/squid.conf"
    mipatch="/etc/squid3"
  fi

  [[ -e $var_squid ]] && {
    clear
    msg -bar
    print_center -ama "$(fun_trans "REMOVIENDO SQUID")"
    print_center -ama "Aguarde un momento!!!"
    msg -bar

    [[ -d "/etc/squid" ]] && {
      service squid stop > /dev/null 2>&1
      apt-get remove squid -y >/dev/null 2>&1
      apt-get purge squid -y >/dev/null 2>&1
      rm -rf /etc/squid >/dev/null 2>&1
    }

    [[ -d "/etc/squid3" ]] && {
      service squid3 stop > /dev/null 2>&1
      apt-get remove squid3 -y >/dev/null 2>&1
      apt-get purge squid3 -y >/dev/null 2>&1
      rm -rf /etc/squid3 >/dev/null 2>&1
    }
    clear
    msg -bar
    print_center -verd "$(fun_trans "Squid removido")"
    [[ -e $var_squid ]] && rm -rf $var_squid
    [[ -e /etc/dominio-denie ]] && rm -rf /etc/dominio-denie
    enter
    return 1
  }

  clear
  msg -bar
  print_center -ama "$(fun_trans "INSTALADOR SQUID ADMRufu")"
  msg -bar
  print_center -ama " $(fun_trans "Seleccione los puertos en orden secuencial")"
  print_center -ama "      Ejemplo: \e[32m80 8080 8799 3128"
  msg -bar
  while [[ -z $PORT ]]; do
        msg -ne " $(fun_trans "Digite los Puertos:") "; read PORT
        tput cuu1 && tput dl1

        [[ $(mportas|grep -w "${PORT}") = "" ]] && {
            echo -e "\033[1;33m $(fun_trans  "Puerto de squid:")\033[1;32m ${PORT} OK"
        } || {
            echo -e "\033[1;33m $(fun_trans  "Puerto de squid:")\033[1;31m ${PORT} FAIL" && sleep 2
            tput cuu1 && tput dl1
            unset PORT
        }
  done

  msg -bar
  print_center -ama " $(fun_trans  "INSTALANDO SQUID")"
  msg -bar
  fun_bar "apt-get install squid3 -y"
  msg -bar
  print_center -ama " $(fun_trans "INICIANDO CONFIGURACION")"
 
cat <<-EOF > /etc/dominio-denie
.ejemplo.com/  
EOF

cat <<-EOF > /etc/exprecion-denie
torrent  
EOF

  unset var_squid
  if [[ -d /etc/squid ]]; then
    var_squid="/etc/squid/squid.conf"
  elif [[ -d /etc/squid3 ]]; then
    var_squid="/etc/squid3/squid.conf"
  fi

  ip=$(fun_ip)

cat <<-EOF > $var_squid
#Configuracion SquiD
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst $ip-$ip/255.255.255.255
acl exprecion-denie url_regex '/etc/exprecion-denie'
acl dominio-denie dstdomain '/etc/dominio-denie'
http_access deny exprecion-denie
http_access deny dominio-denie
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost

#puertos
EOF

for pts in $(echo -e $PORT); do
  echo -e "http_port $pts" >> $var_squid
  [[ -f "/usr/sbin/ufw" ]] && ufw allow $pts/tcp &>/dev/null 2>&1
done

cat <<-EOF >> $var_squid
http_access allow all
coredump_dir /var/spool/squid
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320

#Nombre Squid
visible_hostname ADMRufu
EOF

print_center -ama "$(fun_trans "REINICIANDO SERVICIOS")"

[[ -d "/etc/squid/" ]] && {
  service ssh restart > /dev/null 2>&1
  /etc/init.d/squid start > /dev/null 2>&1
  service squid restart > /dev/null 2>&1
}

[[ -d "/etc/squid3/" ]] && {
  service ssh restart > /dev/null 2>&1
  /etc/init.d/squid3 start > /dev/null 2>&1
  service squid3 restart > /dev/null 2>&1
}

sleep 2s
tput cuu1 && tput dl1
print_center -verd "$(fun_trans "SQUID CONFIGURADO")"
enter
}

add_host(){
  clear
  msg -bar
  print_center -ama "$(fun_trans "Hosts Actuales Dentro del Squid")"
  msg -bar
  lshost
  back

  while [[ $hos != \.* ]]; do
      msg -nazu " $(fun_trans "Digita un nuevo host"): " && read hos
      [[ $hos = 0 ]] && return 1
      tput cuu1 && tput dl1
      [[ $hos = \.* ]] && continue
      print_center -ama "$(fun_trans "El host deve comensar con") .punto.com"
      sleep 3s
      tput cuu1 && tput dl1
  done

  host="$hos/"
  [[ -z $host ]] && return 1

  if [[ `grep -c "^$host" $payload` -eq 1 ]]; then
      print_center -ama " $(fun_trans "El host ya exciste")"
      enter
      return 1
  fi

  echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
  clear
  msg -bar
  print_center -ama "$(fun_trans "Host Agregado con Exito")"
  msg -bar
  lshost
  msg -bar
  print_center -ama "Reiniciando servicios"

  if [[ ! -f "/etc/init.d/squid" ]]; then
      service squid3 reload &>/dev/null
      service squid3 restart &>/dev/null
   else
      /etc/init.d/squid reload &>/dev/null
      service squid restart &>/dev/null
  fi

  tput cuu1 && tput dl1
  tput cuu1 && tput dl1
  enter
  return 1
}

add_expre(){
  clear
  msg -bar
  print_center -ama "$(fun_trans "Expreciones regulares Dentro de Squid")"
  msg -bar
  lsexpre
  back

  while [[ -z $hos ]]; do
      msg -nazu " $(fun_trans "Digita una palabla"): " && read hos
      [[ $hos = 0 ]] && return 1
      tput cuu1 && tput dl1
      [[ $hos != "" ]] && continue
      print_center -ama "$(fun_trans "Escriba una palabla regular") Ej: torrent"
      sleep 3s
      tput cuu1 && tput dl1
  done

  host="$hos"
  [[ -z $host ]] && return 1

  if [[ `grep -c "^$host" $payload2` -eq 1 ]]; then
      print_center -ama " $(fun_trans "Exprecion regular ya exciste")"
      enter
      return 1
  fi

  echo "$host" >> $payload2 && grep -v "^$" $payload2 > /tmp/a && mv -f /tmp/a $payload2
  clear
  msg -bar
  print_center -ama "$(fun_trans "Exprecion regular Agregada con Exito")"
  msg -bar
  lsexpre
  msg -bar
  print_center -ama "Reiniciando servicios"

  if [[ ! -f "/etc/init.d/squid" ]]; then
      service squid3 reload &>/dev/null
      service squid3 restart &>/dev/null
   else
      /etc/init.d/squid reload &>/dev/null
      service squid restart &>/dev/null
  fi

  tput cuu1 && tput dl1
  tput cuu1 && tput dl1
  enter
  return 1
}

del_host(){
  unset opcion
  clear
  msg -bar
  print_center -ama "$(fun_trans "Hosts Actuales Dentro del Squid")"
  msg -bar
  lshost
  back
  while [[ -z $opcion ]]; do
      msg -ne " Eliminar el host numero: "
      read opcion
      if [[ ! $opcion =~ $numero ]]; then
        tput cuu1 && tput dl1
        print_center -verm2 "ingresa solo numeros"
        sleep 2s
        tput cuu1 && tput dl1
        unset opcion
      elif [[ $opcion -gt ${#pay[@]} ]]; then
        tput cuu1 && tput dl1
        print_center -ama "solo numeros entre 0 y ${#pay[@]}"
        sleep 2s
        tput cuu1 && tput dl1
        unset opcion
      fi
  done
  [[ $opcion = 0 ]] && return 1
  host="${pay[$opcion]}/"
  [[ -z $host ]] && return 1
  [[ `grep -c "^$host" $payload` -ne 1 ]] && print_center -ama "$(fun_trans  "Host No Encontrado")" && return 1
  grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
  clear
  msg -bar
  print_center -ama "$(fun_trans "Host Removido Con Exito")"
  msg -bar
  lshost
  msg -bar
  print_center -ama "Reiniciando servicios"

  if [[ ! -f "/etc/init.d/squid" ]]; then
      service squid3 reload &>/dev/null
      service squid3 restart &>/dev/null
  else
      /etc/init.d/squid reload &>/dev/null
      service squid restart &>/dev/null
  fi

  tput cuu1 && tput dl1
  tput cuu1 && tput dl1
  enter
  return 1
}

del_expre(){
  unset opcion
  clear
  msg -bar
  print_center -ama "$(fun_trans "Exprecion regular Dentro del Squid")"
  msg -bar
  lsexpre
  back
  while [[ -z $opcion ]]; do
      msg -ne " Eliminar la palabra numero: " && read opcion
      if [[ ! $opcion =~ $numero ]]; then
        tput cuu1 && tput dl1
        print_center -verm2 "ingresa solo numeros"
        sleep 2s
        tput cuu1 && tput dl1
        unset opcion
      elif [[ $opcion -gt ${#pay[@]} ]]; then
        tput cuu1 && tput dl1
        print_center -ama "solo numeros entre 0 y ${#pay[@]}"
        sleep 2s
        tput cuu1 && tput dl1
        unset opcion
      fi
  done
  [[ $opcion = 0 ]] && return 1
  host="${pay[$opcion]}"
  [[ -z $host ]] && return 1
  [[ `grep -c "^$host" $payload2` -ne 1 ]] && print_center -ama "$(fun_trans  "Palabra No Encontrado")" && return 1
  grep -v "^$host" $payload2 > /tmp/a && mv -f /tmp/a $payload2
  clear
  msg -bar
  print_center -ama "$(fun_trans "Palabra Removida Con Exito")"
  msg -bar
  lsexpre
  msg -bar
  print_center -ama "Reiniciando servicios"
  if [[ ! -f "/etc/init.d/squid" ]]; then
      service squid3 reload &>/dev/null
      service squid3 restart &>/dev/null
  else
      /etc/init.d/squid reload &>/dev/null
      service squid restart &>/dev/null
  fi
  tput cuu1 && tput dl1
  tput cuu1 && tput dl1
  enter
  return 1
}

add_port(){
	if [[ -e /etc/squid/squid.conf ]]; then
    	local CONF="/etc/squid/squid.conf"
  	elif [[ -e /etc/squid3/squid.conf ]]; then
    	local CONF="/etc/squid3/squid.conf"
  	fi
  	local miport=$(cat ${CONF}|grep -w 'http_port'|awk -F ' ' '{print $2}'|tr '\n' ' ')
  	local line="$(cat ${CONF}|sed -n '/http_port/='|head -1)"
  	local NEWCONF="$(cat ${CONF}|sed "$line c ADMR_port"|sed '/http_port/d')"
  	title -ama "$(fun_trans "AGREGAR UN PUERTOS SQUID")"
 	echo -e " $(msg -verm2 "Ingrese Sus Puertos:") $(msg -verd "80 8080 8799 3128")"
  	msg -bar
  	msg -ne " $(fun_trans " Digite Puertos"): " && read DPORT
  	tput cuu1 && tput dl1
  	TTOTAL=($DPORT)
  	for((i=0; i<${#TTOTAL[@]}; i++)); do
  		[[ $(mportas|grep -v squid|grep -v '>'|grep -w "${TTOTAL[$i]}") = "" ]] && {
      		echo -e "\033[1;33m Puerto Elegido:\033[1;32m ${TTOTAL[$i]} OK"
      		PORT="$PORT ${TTOTAL[$i]}"
    	} || {
      		echo -e "\033[1;33m Puerto Elegido:\033[1;31m ${TTOTAL[$i]} FAIL"
    	}
  	done
  	[[  -z $PORT ]] && {
    	msg -bar
    	print_center -verm2 "Ningun Puerto Valido"
    	return 1
  	}
  	PORT="$miport $PORT"
  	rm ${CONF}
  	while read varline; do
  		if [[ ! -z "$(echo "$varline"|grep 'ADMR_port')" ]]; then
      		for i in `echo $PORT`; do
        	echo -e "http_port ${i}" >> ${CONF}
        	ufw allow $i/tcp &>/dev/null 2>&1
      		done
      		continue
    	fi
    	echo -e "${varline}" >> ${CONF}
  	done <<< "${NEWCONF}"
  	msg -bar
  	print_center -azu "$(fun_trans "AGUARDE REINICIANDO SERVICIOS")"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	print_center -verd "$(fun_trans "PUERTOS AGREGADOS")"
  	enter
  	return 1
}

del_port(){
	squidport=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN"|grep -E 'squid|squid3')

	if [[ $(echo "$squidport"|wc -l) -lt '2' ]];then
		clear
		msg -bar
		print_center -ama "Un solo puerto para eliminar\ndesea detener el servicio?	"
		msg -bar
		msg -ne " opcion [S/N]: " && read a

		if [[ "$a" = @(S|s) ]]; then
			title -ama "AGUARDE DETENIEDO SERVICIOS"
			[[ -d "/etc/squid/" ]] && {
				if service squid stop &> /dev/null ; then
					print_center -verd "Servicio squid detenido"
				else
					print_center -verm2 "Falla al detener Servicio squid"
				fi
			}
			[[ -d "/etc/squid3/" ]] && {
				if service squid3 stop &> /dev/null ; then
					print_center -verd "Servicio squid3 detenido"
				else
					print_center -verm2 "Falla al detener Servicio squid3"
				fi
			}		
		fi
		enter
		return 1
	fi

	if [[ -e /etc/squid/squid.conf ]]; then
    	local CONF="/etc/squid/squid.conf"
  	elif [[ -e /etc/squid3/squid.conf ]]; then
    	local CONF="/etc/squid3/squid.conf"
  	fi
	title -ama "Quitar un puertos squid"
    n=1
    while read i; do
        port=$(echo $i|awk -F ' ' '{print $9}'|cut -d ':' -f2)
        echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -azu "$port")"
        drop[$n]=$port
        num_opc="$n"
        let n++ 
    done <<< $(echo "$squidport")
    back
    while [[ -z $opc ]]; do
        msg -ne " opcion: "
        read opc
        tput cuu1 && tput dl1
        if [[ -z $opc ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ ! $opc =~ $numero ]]; then
            msg -verm2 " selecciona solo numeros entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ "$opc" -gt "$num_opc" ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            sleep 2
            tput cuu1 && tput dl1
            unset opc
            continue
        fi
    done
    sed -i "/http_port ${drop[$opc]}/d" $CONF
  	print_center -azu "$(fun_trans "AGUARDE REINICIANDO SERVICIOS")"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	print_center -verd "$(fun_trans "PUERTO REMOVIDO")"
  	enter
  	return 1	
}

restart_squid(){
	title -ama "AGUARDE REINICIANDO SERVICIOS"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	print_center -verd "$(fun_trans "SERVICIO REINICIANDO")"
  	enter
  	return 1
}


online_squid(){
  payload="/etc/dominio-denie"
  payload2="/etc/exprecion-denie"
  clear
  msg -bar
  print_center -ama "$(fun_trans "CONFIGURACION DE SQUID")"
  msg -bar
  menu_func "Bloquear un host" \
  "-bar3 Desbloquear un host" \
  "Bloquear exprecion regular" \
  "-bar3 Desbloquear exprecion regular" \
  "Agregar puerto" \
  "-bar Quitar puerto" \
  "\e[31mDesinstalar Squid" \
  "\e[33mReiniciar squid"
  back
  opcion=$(selection_fun 8)

  case $opcion in
    1)add_host;;
    2)del_host;;
    3)add_expre;;
    4)del_expre;;
    5)add_port;;
    6)del_port;;
    7)fun_squid;;
    8)restart_squid;;
    0)return 1;;
  esac
}

if [[ -e /etc/squid/squid.conf ]]; then
  online_squid
elif [[ -e /etc/squid3/squid.conf ]]; then
  online_squid
else
  fun_squid
  return 1
fi