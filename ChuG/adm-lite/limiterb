#!/bin/bash
while true
do
clear
killing () {
for pid in `(head -n $1 /tmp/pid)`
do
kill $pid
done
}
cat /etc/passwd |grep -v ovpn > /tmp/ussh
usr22=$(printf '%-18s' "LOGUINS")
usr11=$(printf ' %-21s' "USUARIO")
echo -e "\033[42;30m $usr11 $usr22\033[0m"
echo -e "\033[1;32m______________________________________"
for user in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9] |sort`
do
num=$(dropb | grep "$user" | wc -l)
limit=$(cat /etc/adm-lite/userDIR/$user | grep "limite" | awk '{print $2}')
if [ "$num" -gt "$limit" ]; then
kill=$(( $nun - $limit))
dropb | grep "$user" | awk '{print $2}' > /tmp/pid
killing $kill
echo -e "\033[1;31m$kill Usuarios Desconectados"
rm -rf /tmp/pid
fi
usr2=$(printf '%-18s' "$num")
usr1=$(printf ' %-21s' "$user")
echo -e "\033[1;33m$usr1     $usr2 \033[1;32m"
echo -e "______________________________________ "
done
echo -e "\033[42;30m $usr11 $usr22\033[0m"
rm -rf /tmp/ussh
sleep 2s
done
