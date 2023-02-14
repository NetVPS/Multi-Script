#!/bin/bash
#CREADOR Henry Chumo | 06/06/2022
#REFACTORY | 16/10/2022
#Alias : @ChumoGH
# -*- ENCODING: UTF-8 -*-
time=$(date +%s)
export ADM='/etc/adm-lite/userDIR/'
touch /root/user
export database="/root/user"
echo $$ > /tmp/pids
dropb () {
port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
log=/var/log/auth.log
loginsukses='Password auth succeeded'
clear
pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
for pid in $pids
do
pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
i=0
for pidend in $pidlogs
do
let i=i+1
done
if [ $pidend ];then
login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
PID=$pid
user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
while [ ${#waktu} -lt 13 ]; do
waktu=$waktu" "
done
while [ ${#user} -lt 16 ]; do
user=$user" "
done
while [ ${#PID} -lt 8 ]; do
PID=$PID" "
done
echo "$user $PID $waktu"
fi
done
}

fun_net () {
(
log_0="/tmp/tcpdum"
log_1="/tmp/tcpdump"
log_2="/tmp/tcpdumpLOG"
usr_dir="/etc/adm-lite/userDIR/usr_cnx"
[[ -e "$log_1" ]] &&  mv -f $log_1 $log_2
[[ ! -e $usr_dir ]] && touch $usr_dir
#ENCERRA TCP
for pd in `ps x | grep tcpdump | grep -v grep | awk '{print $1}'`; do
kill -9 $pd > /dev/null 2>&1
done
#INICIA TCP
tcpdump -s 50 -n 1> /tmp/tcpdump 2> /dev/null &
[[ ! -e /tmp/tcpdump ]] && touch /tmp/tcpdump
#ANALIZA USER
for user in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9]`; do
touch /tmp/$user
ip_openssh $user > /dev/null 2>&1
ip_drop $user > /dev/null 2>&1
sed -i '/^$/d' /tmp/$user
pacotes=$(paste -sd+ /tmp/$user | bc)
rm /tmp/$user
if [ "$pacotes" != "" ]; then
  if [ "$(cat $usr_dir | grep "$user")" != "" ]; then
  pacotesuser=$(cat $usr_dir | grep "$user" | awk '{print $2}')
  [[ $pacotesuser = "" ]] && pacotesuser=0
  [[ $pacotesuser != +([0-9]) ]] && pacotesuser=0
  ussrvar=$(cat $usr_dir | grep -v "$user")
  echo "$ussrvar" > $usr_dir
  pacotes=$(($pacotes+$pacotesuser))
  echo -e "$user $pacotes" >> $usr_dir
  else
  echo -e "$user $pacotes" >> $usr_dir
  fi
fi
unset pacotes
done
) &
}

ip_openssh () {
user="$1"
for ip in `lsof -u $user -P -n | grep "ESTABLISHED" | awk -F "->" '{print $2}' |awk -F ":" '{print $1}' | grep -v "127.0.0.1"`; do
 local packet=$(cat $log_2 | grep "$ip" | wc -l)
 echo "$packet" >> /tmp/$user
 unset packet
done
}

ip_drop () {
user="$1"
loguser='Password auth succeeded'
touch /tmp/drop
for ip in `cat /var/log/auth.log | tail -100 | grep "$user" | grep "$loguser" | awk -F "from" '{print $2}' | awk -F ":" '{print $1}'`; do
 if [ "$(cat /tmp/drop | grep "$ip")" = "" ]; then
 packet=$(cat $log_2 | grep "$ip" | wc -l)
 echo "$packet" >> /tmp/$user
 echo "$ip" >> /tmp/drop
 fi
done
rm /tmp/drop
}


killing () {
	kill $1
}

_timeUSER () {
local user=$1
[[ -z $user ]] && return
	local tst="$(ps -o etime $(ps -u $user |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')"
	local tst1=$(echo "$tst" | wc -c)
	if [[ "$tst1" == "9" ]]; then 
		local timerr="$(ps -o etime $(ps -u $user |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')"
	else
		local timerr="$(echo "00:$tst")"
	fi
[[ "$tst1" == "0" ]] && return
unset var4 var5 var6 calc2
tmp2="$timerr"
local var4=`echo $tmp2 | cut -c 1-2`
local var5=`echo $tmp2 | cut -c 4-5`
local var6=`echo $tmp2 | cut -c 7-8`
[[ ! -e ${ADM}$user.time ]] && calc2=`echo $var4*3600 + $var5*60 + $var6 | bc` || calc2="$(cat ${ADM}$user.time)"
seg=$(($calc2 + 29))
echo "$seg" > ${ADM}$user.time
}

killerDROP () {
user=$1 && limit=$2
num=$(dropb | grep "$user" | wc -l)
[[ $num -gt $limit ]] && {
pidKILL=$(dropb | grep "$user" | awk '{print $2}')
killing $pidKILL
echo " $user DROPBEAR LIMITADO ${limit}/$num | $(printf '%(%D-%H:%M:%S)T') !" >> $HOME/limiter.log
}
}

killerSSH () {
local user=$1
local limit=$2
local _ps="$(ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts)"
local conex=$(echo -e "$_ps" | wc -l)
[[ $conex -gt $limit ]] && {
		#while read line; do
		#	local tmp="$(echo $line | cut -d' ' -f1)"
		#	killing $tmp
			pkill -u $user
			echo " ( $user ) LIMITADO ${conex}/${limit} | $(printf '%(%D-%H:%M:%S)T') !" >> $HOME/limiter.log
		#done <<< "$(echo -e "$_ps")"
	}
}


for u in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1`
do
[[ -e ${ADM}$u ]] && daaab=$(cat ${ADM}$u | grep "limite:" | awk '{print $2}')
[[ ${daaab} = "HWID" ]] && daaab=1
[[ ${daaab} = "TOKEN" ]] && daaab=1
killerDROP ${u} ${daaab}
killerSSH ${u} ${daaab}
[[ -e /bin/ejecutar/usCONEXT ]] && _timeUSER ${u}
echo "$u $daaab" >> /root/user
if [[ $(chage -l $u |grep 'Account expires' |awk -F ': ' '{print $2}') != never ]]; then
[[ $time -gt $(date '+%s' -d "$(chage -l $u |grep "Account expires" |awk -F ': ' '{print $2}')") ]] && {
	[[ -e /etc/default/dropbear ]] && {
    		pkill -u $u &>/dev/null
    		droplim=`dropb|grep -w "$u"|awk '{print $2}'` 
    		kill -9 $droplim &>/dev/null
    		usermod -L $u &>/dev/null
		}
	}
fi
done

[[ -e /bin/ejecutar/usCONEXC ]] && fun_net
rm -rf /root/user
exit
