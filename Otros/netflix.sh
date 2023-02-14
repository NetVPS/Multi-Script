#!/bin/bash
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m✦✧"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m EXITO -\033[1;32m 100 %\033[1;37m"
}

fun_bar 'apt install cmake -y'
#fun_bar 'apt-get install screen wget gcc build-essential g++ make -y'
rm -f badvpn-1.999.128.tar.*
cd /etc/adm-lite/
rm -f badvpn-1.999.128.tar.*
rm -rf badvpn-1.999.128/
wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
tar xf badvpn-1.999.128.tar.bz2
cd /etc/adm-lite/badvpn-1.999.128
cmake /etc/adm-lite/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen -dmS badudp72 badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 75 > /dev/nul &
echo 'badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 75 > /dev/nul &' > /etc/rc.local
cd /etc/adm-lite/
[[ -d badvpn-1.999.128/ ]] && rm -rf badvpn*
rm -f badvpn-1.999.128.tar.*
rm -f install > /dev/nul
echo "Finalizado"
echo "Modulo BadUDP - ChumoGH"
return
