#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
clear
config="/usr/local/etc/trojan/config.json"
temp="/etc/trojan/temp.json"
trojdir="/etc/trojan" && [[ ! -d $trojdir ]] && mkdir $trojdir
user_conf="/etc/trojan/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/trojan/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $trojdir/conf ]] && echo "autBackup 0" > $trojdir/conf
if [[ $(cat $trojdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $trojdir/conf
fi
unset barra
barra="\033[0;34m•••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')


trojan() 
{
wget -q https://www.dropbox.com/s/vogt0tyaqg0gee1/trojango.sh; chmod +x trojango.sh; ./trojango.sh
rm -f trojango.sh
}


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

 
enon(){
echo "source <(curl -sSL https://www.dropbox.com/s/0g49zme77giypns/mod-v2ray.sh)" > /bin/troj.sh
chmod +x /bin/troj.sh
		clear
		echo -e $barra
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		echo -e $barra
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * troj.sh * !!!"
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
}
enoff(){
rm -f /bin/v2r.sh
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de troj.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	echo -e $barra
	blanco "	  Ajustes e Entrasda Rapida de Menu TROJAN"
	echo -e $barra
	col "1)" "Habilitar troj.sh, Como entrada Rapida"
	col "2)" "Eliminar troj.sh, Como entrada Rapida"
	echo -e $barra
	col "0)" "Volver"
	echo -e $barra
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 0.3;;
	esac
    done

}


 
on_off_res(){
	if [[ $(cat $trojdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
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

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m ➣   \033[1;37m${2}")
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
trojanports=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/adm-lite/trojanports.txt && cat /etc/adm-lite/trojanports.txt` > /dev/null 2>&1 
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	echo -e "\033[7;49;35m  =====>>►► 🐲 Menu TROJAN ChumoGH💥VPS 🐲 ◄◄<<=====    \033[0m"
	echo -e $barra
	[[ $v1 = $v2 ]] && echo -e "        \e[97m\033[1;41mProyecto Trojan by @ChumoGH  [$v1]  \033[0m" || echo -e "   \e[97m\033[1;41mProyecto Trojan by @ChumoGH [$v1] >> \033[1;92m[$v2]  \033[0m"
	[[ $trojanports > 0 ]] && echo -e "          \e[97m\033[1;41mPuerta Activa en menu : \033[0m \033[3;32m $trojanports\033[3;32m" ||  echo -e "        \e[97m\033[1;41mERROR A INICIAR TROJAN : \033[0m \033[3;32m FAIL\033[3;32m"
}

title(){
	echo -e $barra
	echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "$1"
	echo -e $barra
}

userDat(){
	#echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "	N°    Usuarios 		  fech exp   dias"
	echo -e $barra
}

log_traff () {

tail -f /usr/local/etc/trojan/config.json


}


add_user(){
autoDel
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat < ${user_conf}adm) $(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
	title "		CREAR USUARIO Trojan"
	userDat
	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = "chumoghscript" ]] && {
			n=0
			i="ADM-SCRIPT"
			a='◈'
			DateExp="【 I N D E F I N I D O 】"
			col "$a)" "$i" "$DateExp"
			
		} || {
		[[ $i = "$(cat < ${user_conf}adm)" ]] && {
		    n=0
			i="$(cat < ${user_conf}adm)"
			a='◈'
			DateExp="【 I N D E F I N I D O 】"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
			}
		}
		let n++
	done
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "Ingresa Nombre de USUARIO :" 0
	read usser
	[[ -z $usser ]] && vacio && sleep 0.3 && continue
	[[ $usser = 0 ]] && break
	[[ -z $(echo "$users" | grep $usser) ]] && {
	opcion=$usser 
	echo -e $barra
	blanco "DURACION EN DIAS" 0
	read dias
	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios
	mv $config $temp
	movetm=$(echo -e "$opcion" | sed 's/^/,"/;s/$/"/')
	sed "10i\        $movetm" $temp > $config
	#echo -e "$opcion" | sed 's/^/,"/;s/$/"/'
	sed -i "/usser/d" $user_conf
	echo "$opcion | $usser | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "	Usuario $usser creado con exito"
	echo -e $barra
	autoDel
	killall trojan > /dev/null
	screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json
	sleep 0.3
	} || echo " USUARIO YA EXISTE " && sleep 1
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d " " -f1 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$i
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		echo -e $barra
		col "0)" "VOLVER"
		echo -e $barra
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.3
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.3
		} || {
			blanco "DURACION EN DIAS" 0
			read dias
			mv $config $temp
			movetm=$(echo -e "${user[$opcion]}" | sed 's/^/,"/;s/$/"/')
			sed "10i\        $movetm" $temp > $config
			sed -i "/${user[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${user[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm -f $temp
			clear
			echo -e $barra
			blanco "	Usuario > ${user[$opcion]} renovado hasta $(date '+%y-%m-%d' -d " +$dias days")"
			sleep 5s
		  }
		}
	done
killall trojan > /dev/null
screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json
continuar
read foo
}

autoDel(){
source <(curl -sSL https://www.dropbox.com/s/6mbvvyzxppecqqp/autodel-trojan.sh)
	}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat < ${user_conf}adm) $(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
	title "	ELIMINAR USUARIO TROJAN"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = "chumoghscript" ]] && {
			i="ADM-SCRIPT"
			a='◈'
			DateExp="【 I N D E F I N I D O 】"
			col "$a)" "$i" "$DateExp"
		} || {
				
		[[ $i = "$(cat < ${user_conf}adm)" ]] && {
		    i="$(cat < ${user_conf}adm)"
			a='◈'
			DateExp="【 I N D E F I N I D O 】"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
			}
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d " " -f 1 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
		}
		let n++
	done
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion
	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.3
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.3
		} || {
			
			[[ $opcion>=${p} ]] && {
			sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			mv $config $temp 
			sed -i "/${expUser[$opcion]}/d" $user_conf
			sed "/${userd[$opcion]}/ d" $temp > $config
			chmod 777 $config
			rm $temp
			clear
			echo -e $barra
			blanco "	Usuario ${userd[$opcion]}${expUser[$opcion]} eliminado"
			echo -e $barra
			sleep 0.5s
			}
		}
	
	}
	done
	killall trojan > /dev/null
	screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json
}

bakc() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		echo -e $barra
		col "1)" "\033[1;33mRestaurar Copia"
		echo -e $barra
		col "2)" "\033[1;33mCrear Copia"
		echo -e $barra
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		echo -e $barra
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)[[ -e config.json ]] && cp config.json /usr/local/etc/trojan/config.json || echo "No existe Copia";;
			2)[[ -e /usr/local/etc/trojan/config.json ]] && cp /usr/local/etc/trojan/config.json config.json || echo "No existe Copia";;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done


}

reintro() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		echo -e $barra
		col "1)" "\033[1;33mReinstalar Servicio"
		echo -e $barra
		col "2)" "\033[1;33mReiniciar Servicio"
		echo -e $barra
		col "3)" "\033[1;33mEditar Manual ( nano )"
		echo -e $barra
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		echo -e $barra
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			trojan
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			killall trojan > /dev/null
			screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json && blanco "Reinicio Completado Exitosamente " || blanco "Error al Aplicar Reinicio "
			} || echo -e  "Servicio No instalado Aun"
			;;
			3)
			nano /usr/local/etc/trojan/config.json
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 3" && sleep 0.3;;
		esac
	done


continuar
read foo
}

cattro () {

clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		echo -e $barra
		col "1)" "\033[1;33mMostrar fichero de CONFIG "
		echo -e $barra
		col "2)" "\033[1;33mEditar Config Manual ( Comando nano )"
		echo -e $barra
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		echo -e $barra
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			title "Fichero Interno Configurado"
			cat /usr/local/etc/trojan/config.json
			blanco "Fin Fichero "
			continuar
			read foo
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			nano /usr/local/etc/trojan/config.json
			killall trojan > /dev/null
			screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json && blanco "Reinicio Completado Exitosamente " || blanco "Error al Aplicar Reinicio "
			} || echo -e  "Servicio No instalado Aun"
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done
continuar
}

view_user(){
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/adm-lite/trojanports.txt && cat /etc/adm-lite/trojanports.txt`;
trojanport=$(cat /etc/adm-lite/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
	nick="$(cat $config | grep ',"')"
	users="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
		title "	VER USUARIO TROJAN"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp
		[[ $i = "$(cat < ${user_conf}adm)" ]] && {
			i="$(cat < ${user_conf}adm)"
			DateExp="【 I N D E F I N I D O 】"
			} || {
		[[ $i = "chumoghscript" ]] && {
			i="ADM-SCRIPT"
			DateExp="【 I N D E F I N I D O 】"
		} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done
		echo -e $barra
		col "0)" "VOLVER"
		echo -e $barra
		blanco "VER DATOS DEL USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break
		n=1
		unset i
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			#col "$n)" "$i" "$DateExp" "$exp"
		[[ $n = $opcion ]] && trojanpass=$i && dataEX=$DateExp && dEX=$exp
				let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		echo -e "  PARA FINALIZAR AGREGA TU HOST SNI / HOST:Port" 
		read -p " Host / SNI : " host
		[[ -z $host ]] && host="coloca-tu-SNI"
			clear&&clear
		blanco $barra
		blanco "              TROJAN LINK CONFIG"
		blanco $barra
		col "$opcion)" "$trojanpass" "$dataEX" "$dEX"
		trojan_conf
		blanco $barra
		continuar
		read foo
	done
}

trojan_conf (){
		echo -e $barra
		col2 "Remarks:" "$trojanpass"
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$trojanport"
		col2 "password:" "$trojanpass"
		[[ ! -z $host ]] && col2 "Host/SNI:" "$host"
		echo -ne "$(msg -verd "") $(msg -verm2 " ") "&& msg -bra "\033[1;41mEn APPS como HTTP Inyector,CUSTOM,Trojan,etc"
		echo -e "\033[3;32m trojan://$(echo $trojanpass@$addip:$trojanport?sni=$host#$trojanpass )\033[3;32m"

}

main(){
	[[ ! -e $config ]] && {
		clear
		echo -e $barra
		blanco " No se encontro ningun archovo de configracion Trojan"
		echo -e $barra
		blanco "	  No instalo Trojan o esta usando\n	     una vercion diferente!!!"
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion Trojan diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
	}
	while :
	do
		_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
		_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
		[[ -e /bin/troj.sh ]] && enrap="\033[1;92m[Encendido]" || enrap="\033[0;31m[Apagado]"
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU Trojan \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR USUARIO "
		col "2)" "\033[0;92mRENOVAR USUARIO "
		col "3)" "\033[0;31mREMOVER USUARIO <->"
		col "4)" "VER DATOS DE USUARIOS "
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		echo -e $barra
	col "6)" "\033[1;33mEntrada Rapida $enrap"
		echo -e $barra
		col "7)" "\033[1;33mMostrar/Editar Fichero interno"
		col "8)" "\033[1;33mMenu Avanzado Trojan"
		col "9)" "\033[1;33mCrear Copia de Config Trojan"	
		echo -e $barra
		col "10)" "\033[1;33mMostrar Log del Trafico"
		echo -e $barra
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		echo -e $barra
		blanco "opcion" 0
		read opcion

		case $opcion in
			1)add_user;;
			2)renew;;
			3)dell_user;;
			4)view_user;;
			5)settings;;
			6)enttrada;;
			7)cattro;;
			8)reintro;;
			9)bakc;;
			10)log_traff;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 10" && sleep 0.3;;
		esac
	done
}

[[ $1 = "autoDel" ]] && {
	autoDel
} || {
	autoDel
	main
}
