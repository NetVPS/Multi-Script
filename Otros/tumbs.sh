#!/bin/bash
#Autor: Henry Chumo 
#Alias : ChumoGH
# -*- ENCODING: UTF-8 -*-

# verificacion primarias

echo " ====================================== "
echo " ======== ENTRANDO EN $1 ========= "
echo " ====================================== "
#[[ -z $(cat /etc/crontab | grep ejecutar) ]] && {


fun_limpram() {
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
	v2ray clean 1> /dev/null 2> /dev/null
	killall kswapd0 > /dev/null 2>&1
	killall tcpdump > /dev/null 2>&1
	killall ksoftirqd > /dev/null 2>&1
	#apt purge rsyslog -y > /dev/null 2>&1
	rm -f /var/log/*.log.*
	[[ -e /var/log/auth.log ]] && echo "@ChumoGH "> /var/log/auth.log
	rm -f /var/log/*.1
	systemctl restart rsyslog.service
	systemctl restart systemd-journald.service
	service dropbear stop > /dev/null 2>&1
	service sshd restart > /dev/null 2>&1
	service dropbear restart > /dev/null 2>&1
	#killall systemd-journald
	echo "DONE" > /etc/fixrsyslog
}
function aguarde() {
	sleep 1
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m Reconstruyendo \033[1;32mLOGS de \033[1;37me \033[1;32m USERS\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}


function checkON () {
#[[ ! -e /etc/fixrsyslog ]] && aguarde
#find . -type f -size +10M -exec rm {} \;
echo 'source <(curl -sSL https://www.dropbox.com/s/x6fp9f14ob1i5ez/gnula.sh)' > /bin/ejecutar/automatizar.sh && chmod +x /bin/ejecutar/automatizar.sh
echo 'source <(curl -sSL https://www.dropbox.com/s/bs1sx98qrzbid8o/killram.sh)' > /bin/ejecutar/gnula.sh && chmod +x /bin/ejecutar/gnula.sh
[[ -e /bin/autoboot ]] && chmod +x /bin/autoboot
sed -i "/automatizar.sh/d" /etc/crontab && sed -i "/gnula.sh/d" /etc/crontab
crontab -l > /root/cron
echo "00 03 * * *	bash /bin/ejecutar/automatizar.sh" >> /root/cron
echo "00 03 * * *	bash /bin/ejecutar/automatizar.sh" >> /etc/crontab
echo "00 * * * *	bash /bin/ejecutar/gnula.sh" >> /root/cron
echo "00 * * * *	bash /bin/ejecutar/gnula.sh" >> /etc/crontab
[[ -z $(crontab -l | grep "autoboot") ]] && {
echo "* * * * *	bash /bin/autoboot"  >> /root/cron
echo "* * * * *	bash /bin/autoboot"  >> /etc/crontab
less << autoboot  > /bin/autoboot
#!/bin/bash
#Autor: Henry Chumo 
#Alias : ChumoGH
# -*- ENCODING: UTF-8 -*-

autoboot
#echo 'echo "$(printf '%(%H:%M:%S)T')" >> /root/clearlog.txt' >> /bin/autoboot
}
crontab /root/cron
service cron restart >/dev/null 2>&1
cat /etc/crontab | tail -n5
rm -f /root/cron
msg -azu " Tarea programada cada $(msg -verd "[ $(crontab -l|grep 'ejecutar'|awk '{print $2}'|sed $'s/[^[:alnum:]\t]//g')HS ]")"
echo -e " FUNCION YA SE ENCUENTRA VALIDADA "
}

function checkOFF () {
rm -f /bin/ejecutar/automatizar.sh
rm -f /bin/ejecutar/gnula.sh
sed -i "/automatizar.sh/d" /etc/crontab && sed -i "/gnula.sh/d" /etc/crontab && sed -i "/autoboot/d" /etc/crontab
crontab -l > /root/cron
sed -i "/ejecutar/d" /root/cron 
sed -i "/autoboot/d" /root/cron 
crontab /root/cron
rm /root/cron
service cron restart
unset _opti
echo -e " DESACTIVADA DEL SISTEMA CORRECTAMENTE"
rm -f /etc/fixrsyslog
}

 [[ "$1" = '--start' ]] && {
    checkON
    exit 0
    }
	
 [[ "$1" = '--stop' ]] && {
    checkOFF
    exit 0
    }