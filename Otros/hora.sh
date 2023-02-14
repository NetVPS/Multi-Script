#!/bin/bash
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;31m NUMERO DE OPCION : " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

act_hora () {
echo "America/Chihuahua"
echo "America/Chihuahua" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Chihuahua /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora1 () {
echo "America/Mexico_City"
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora2 () {
echo "Argentina"
ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora3 () {
echo "CHILE"
timedatectl > /dev/null 2>&1
timedatectl list-timezones  | grep Chile/Continental > /dev/null 2>&1
timedatectl set-timezone Chile/Continental > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora4 () {
echo "America/Los_Angeles"
timedatectl > /dev/null 2>&1
timedatectl list-timezones  | grep Los_Angeles > /dev/null 2>&1
timedatectl set-timezone America/Los_Angeles > /dev/null 2>&1
msg -bar
return 0
}
act_hora5 () {
echo "America/La_Paz"
echo "America/La_Paz" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/La_Paz /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora6 () {
echo "America/Guatemala"
echo "America/Guatemala" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Guatemala /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora7 () {
echo "America/Bogota"
echo "America/Bogota" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Bogota /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
act_hora8 () {
echo "America/Guayaquil"
echo "America/Guayaquil" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Guayaquil /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar
return 0
}
verzm () {
timedatectl
echo -e "\033[1;31m PRESIONE ENTER PARA CONTINUAR \033[0m"
read -p " "
return 0
}
shadowe_fun () {
#source /etc/adm-lite/cabelcaho
while true; do
clear&&clear
_tm=$(timedatectl | grep "Time zone")
unset selection
echo -e " \033[1;36m ZONA HORARIO \033[1;32m[ChumoGH-ADM]"
msg -bar
echo -e "${_tm}"
msg -bar
echo -e "${cor[4]} [1] > ${cor[2]}VER ZONA HORARIA ACTUAL    ${cor[4]} [12] > ${cor[2]} HORARIO VENEZUELA"
echo -e "${cor[4]} [2] > ${cor[5]}HORARIO MEXICO             ${cor[4]} [13] > ${cor[2]} HORARIO BRAZIL"
echo -e "${cor[4]} [3] > ${cor[5]}HORARIO Argentina"
echo -e "${cor[4]} [4] > ${cor[5]}HORARIO CHILE"
echo -e "${cor[4]} [5] > ${cor[5]}HORARIO MEXICO"
echo -e "${cor[4]} [6] > ${cor[5]}HORARIO Bolivia "
echo -e "${cor[4]} [7] > ${cor[5]}HORARIO Guatemala"
echo -e "${cor[4]} [8] > ${cor[5]}HORARIO COLOMBIA"
echo -e "${cor[4]} [9] > ${cor[5]}HORARIO ECUADOR "
echo -e "${cor[4]} [10] > ${cor[5]}HORARIO Los Angeles (USA)"
echo -e "${cor[4]} [11] > ${cor[5]}RESTAURAR ZONA ORIGINAL"
echo -e "${cor[4]} [0] > ${cor[0]}SALIR"
msg -bar
selection=$(selection_fun 13)
case ${selection} in
	0)
	break;;
	1)
	fun_bar
	verzm
	unset selection
	sleep 2s
	;;
	2)
	fun_bar
	act_hora1
	unset selection
	sleep 2s
	;;
	3)
	fun_bar
	act_hora2
	unset selection
	sleep 2s
	;;
   	 4)
	 fun_bar
	act_hora3
	unset selection
	sleep 2s
	;;
	 5)
	act_hora
	unset selection
	sleep 2s
	;;
	 6)
	 fun_bar
	act_hora5
	unset selection
	sleep 2s
	;;
	 7)
	 fun_bar
	act_hora6
	unset selection
	sleep 2s
	;;
	 8)
	 fun_bar
	act_hora7
	unset selection
	sleep 2s
	;;
	 9)
	 fun_bar
	act_hora8
	unset selection
	sleep 2s
	;;
	10)
	fun_bar
	act_hora4
	unset selection
	sleep 2s
  	;;
	11)
	fun_bar
	echo "Etc/UTC" > /etc/timezone
	ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	12)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	13)
	fun_bar
	echo "America/Sao_Paulo" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	14)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	15)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	16)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
	sleep 2s
	;;
	17)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	sleep 2s
	;;
	18)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	;;
	19)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	;;
	20)
	fun_bar
	echo "America/Caracas" > /etc/timezone
	ln -fs /usr/share/zoneinfo/America/Caracas /etc/localtime
	;;
esac
done
}
shadowe_fun
