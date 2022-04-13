#!/bin/bash
lshost(){
  n=1
    for i in `cat $payload|awk -F "/" '{print $1,$2,$3,$4}'`; do
      echo -e " $(msg -verd "$n)") $(msg -verm2 ">") $(msg -teal "$i")"
      pay[$n]=$i
      let n++
    done
}

fun_squid(){
  if [[ -e /etc/squid/squid.conf ]]; then
    var_squid="/etc/squid/squid.conf"
  elif [[ -e /etc/squid3/squid.conf ]]; then
    var_squid="/etc/squid3/squid.conf"
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
    [[ -e /etc/payloads ]] && rm -rf /etc/payloads
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
 
cat <<-EOF > /etc/payloads
.bookclaro.com.br/
.claro.com.ar/
.claro.com.br/
.claro.com.co/
.claro.com.ec/
.claro.com.gt/
.cloudfront.net/
.claro.com.ni/
.claro.com.pe/
.claro.com.sv/
.claro.cr/
.clarocurtas.com.br/
.claroideas.com/
.claroideias.com.br/
.claromusica.com/
.clarosomdechamada.com.br/
.clarovideo.com/
.facebook.net/
.facebook.com/
.netclaro.com.br/
.oi.com.br/
.oimusica.com.br/
.speedtest.net/
.tim.com.br/
.timanamaria.com.br/
.vivo.com.br/
.rdio.com/
.compute-1.amazonaws.com/
.portalrecarga.vivo.com.br/
.vivo.ddivulga.com/  
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
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 dstdomain -i localhost
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access deny all

#puertos
EOF

for pts in $(echo -e $PORT); do
  echo -e "http_port $pts" >> $var_squid
  [[ -f "/usr/sbin/ufw" ]] && ufw allow $pts/tcp &>/dev/null 2>&1
done

cat <<-EOF >> $var_squid
#Nombre Squid
visible_hostname ADMRufu

via off
forwarded_for off
pipeline_prefetch off
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

online_squid(){
  payload="/etc/payloads"
  clear
  msg -bar
  print_center -ama "$(fun_trans "CONFIGURACION DE SQUID")"
  msg -bar
  menu_func "$(fun_trans "Colocar Host en Squid")" "$(fun_trans "Remover Host de Squid")" "$(fun_trans "Desinstalar Squid")"
  back
  opcion=$(selection_fun 3)

  case $opcion in
    1)add_host;;
    2)del_host;;
    3)fun_squid;;
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