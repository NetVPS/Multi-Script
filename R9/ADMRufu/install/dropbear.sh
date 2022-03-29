#!/bin/bash
#19/12/2019

fun_dropbear(){
  clear
  [[ -e /etc/default/dropbear ]] && {
    msg -bar
    print_center -ama "REMOVIENDO DROPBEAR"
    msg -bar
    service dropbear stop & >/dev/null 2>&1
    fun_bar "apt-get remove dropbear -y"
    fun_bar "apt-get purge dropbear -y"
    fun_bar "apt-get autoremove -y"
    msg -bar
    print_center -verd "Dropbear Removido"
    msg -bar
    [[ -e /etc/default/dropbear ]] && rm /etc/default/dropbear &>/dev/null
    sleep 2
    return 1
  }
  msg -bar
  print_center -ama "INSTALADOR DROPBEAR"
  msg -bar
  echo -e " $(msg -verm2 "Ingrese Sus Puertos:") $(msg -verd "80 90 109 110 143 443")"
  msg -bar
  msg -ne " Digite Puertos: " && read DPORT
  tput cuu1 && tput dl1
  TTOTAL=($DPORT)
  for((i=0; i<${#TTOTAL[@]}; i++)); do
    [[ $(mportas|grep "${TTOTAL[$i]}") = "" ]] && {
      echo -e "\033[1;33m Puerto Elegido:\033[1;32m ${TTOTAL[$i]} OK"
      PORT="$PORT ${TTOTAL[$i]}"
    } || {
      echo -e "\033[1;33m Puerto Elegido:\033[1;31m ${TTOTAL[$i]} FAIL"
    }
  done
  [[  -z $PORT ]] && {
    echo -e "\033[1;31m Ningun Puerto Valida Fue Elegido\033[0m"
    return 1
  }

  [[ ! $(cat /etc/shells|grep "/bin/false") ]] && echo -e "/bin/false" >> /etc/shells
  msg -bar
  print_center -ama "Instalando dropbear"
  msg -bar
  fun_bar "apt-get install dropbear -y"
  msg -bar
  chk=$(cat /etc/ssh/sshd_config | grep Banner)
  if [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
    local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
  else
    local="/etc/bannerssh"
  fi
  touch $local
  print_center -ama "Configurando dropbear"

cat <<EOF > /etc/default/dropbear
NO_START=0
DROPBEAR_PORT=VAR1
DROPBEAR_EXTRA_ARGS="VAR"
DROPBEAR_BANNER="$local"
DROPBEAR_RECEIVE_WINDOW=65536
EOF

  n=0
  for i in $(echo $PORT); do
  	p[$n]=$i
  	let n++
  done

  sed -i "s/VAR1/${p[0]}/g" /etc/default/dropbear

  if [[ ! -z ${p[1]} ]]; then

  	for (( i = 0; i < ${#p[@]}; i++ )); do
  		[[ "$i" = "0" ]] && continue
  		sed -i "s/VAR/-p ${p[$i]} VAR/g" /etc/default/dropbear
  	done
  fi
  sed -i "s/VAR//g" /etc/default/dropbear

  fun_eth
  service ssh restart > /dev/null 2>&1
  service dropbear restart > /dev/null 2>&1
  sleep 1
  msg -bar3
  print_center -verd "dropbear configurado con EXITO"
  msg -bar
  #UFW
  for ufww in $(mportas|awk '{print $2}'); do
    ufw allow $ufww > /dev/null 2>&1
  done
  sleep 2
  return 1
}

fun_dropbear