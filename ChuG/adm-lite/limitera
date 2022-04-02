#!/bin/bash
while true
do
clear
touch /root/user
cat /etc/passwd |grep -v ovpn > /tmp/ussh
for u in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9] |sort`
do
daaab=$(cat /etc/adm-lite/userDIR/$u | grep "limite:" | awk '{print $2}')
echo "$u $daaab" >> /root/user
done

database="/root/user"
echo $$ > /tmp/pids
if [ ! -f "$database" ]
then
	echo "não ha usuarios"
	exit 1
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%28s%s%-18s\n' "SSH Limiter"
tput setaf 7 ; tput setab 4 ; printf '  %-30s%s\n' "Usuário" "Conexão/Limite " ; echo "" ; tput sgr0
	while read usline
	do
		user="$(echo $usline | cut -d' ' -f1)"
		s2ssh="$(echo $usline | cut -d' ' -f2)"
		if [ -z "$user" ] ; then
			echo "" > /dev/null
		else
			ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts > /tmp/tmp2
			s1ssh="$(cat /tmp/tmp2 | wc -l)"
			tput setaf 3 ; tput bold ; printf '  %-35s%s\n' $user $s1ssh/$s2ssh; tput sgr0
			if [ "$s1ssh" -gt "$s2ssh" ]; then
				tput setaf 7 ; tput setab 1 ; tput bold ; echo " Usuário desconectado por ultrapassar o limite!" ; tput sgr0
				while read line
				do
					tmp="$(echo $line | cut -d' ' -f1)"
					kill $tmp
				done < /tmp/tmp2
				rm /tmp/tmp2
			fi
		fi
	done < "$database"
rm -rf /root/user
sleep 5s
done
