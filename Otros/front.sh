#!/bin/bash
#PUTO EL QUE LO DESENCRIPTA
#colores
lor1='\033[1;31m';lor2='\033[1;32m';lor3='\033[1;33m';lor4='\033[1;34m';lor5='\033[1;35m';lor6='\033[1;36m';lor7='\033[1;37m'

fun_bar () {
          comando[0]="$1"
          comando[1]="$2"
          (
          [[ -e $HOME/fim ]] && rm $HOME/fim
          ${comando[0]} > /dev/null 2>&1
          ${comando[1]} > /dev/null 2>&1
          touch $HOME/fim
          ) > /dev/null 2>&1 &
          tput civis
		  echo -e "${lor7}---------------------------------------------------${lor7}"
          echo -ne "${lor7}    ESPERE.${lor1}["
          while true; do
          for((i=0; i<18; i++)); do
          echo -ne "${lor5}#"
          sleep 0.1s
          done
         [[ -e $HOME/fim ]] && rm $HOME/fim && break
         echo -e "${col5}"
         sleep 0.3s
         tput cuu1
         tput dl1
         echo -ne "${lor7}    WAIT..${lor1}["
         done
         echo -e "${lor1}]${lor7} -${lor7} FINISHED ${lor7}"
         tput cnorm
		 echo -e "${lor7}---------------------------------------------------${lor7}"
        }
		
banner="      ___           _              _ _ _ 
     / _ \_ __ ___ | |_ ___   /\ /(_) | |
    / /_)/ '__/ _ \| __/ _ \ / //_/ | | |
   / ___/| | | (_) | || (_) / __ \| | | |
   \/    |_|  \___/ \__\___/\/  \/|_|_|_| "

espe () {   
echo -e "${lor7}"
read -p " Enter to Continue.. 0 to return" 
}  

clear&&clear
echo -e "${lor4}***************************************************${lor7}"
echo -e "${lor2}                 SSL STUNNEL MANAGER "
echo -e "${lor1}===================================================${lor7} "
echo -e "${lor4}$banner ${lor7}"
echo -e "${lor7}      Mini Script Panel created by @KillShito "
echo -e "${lor1}[-]——————————————————————————————————————————————[-]${lor7}"
[[ $(netstat -nplt |grep 'stunnel4') ]] && sessl="STOP SERVICE ${lor2}ON" || sessl="START SERVICE ${lor1}OFF"
echo -e "${lor7}[${lor2}1${lor7}] ${lor3}==>${lor7} INSTALL SSL STUNNEL"
echo -e "${lor7}[${lor2}2${lor7}] ${lor3}==>${lor7} UNINSTALL SSL STUNNEL "
echo -e "${lor7}[${lor2}3${lor7}] ${lor3}==>${lor7} ADD NEW PORT "
echo -e "${lor7}[${lor2}4${lor7}] ${lor3}==>${lor7} $sessl "
echo -e "${lor7}[${lor2}5${lor7}] ${lor3}==>${lor7} CERTIFICATE "
echo -e "${lor1}[-]——————————————————————————————————————————————[-]${lor7}"
echo -e "${lor7}[${lor2}0${lor7}] ${lor3}==>${lor7} SALIR "
echo -e "${lor1}[-]——————————————————————————————————————————————[-]${lor7}"
read -p "SELECT OPTION :" opci
if [ "$opci" = "1" ];then
if [ -f /etc/stunnel/stunnel.conf ]; then
echo;echo -e "${lor1}  ALREADY INSTALLED" 
else
echo;echo -e "${lor7} Local port  ${lor6}"
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
read -p " PORTA :" -e -i $pt PT
echo;echo -e "${lor7} Listen-SSL  ${lor6}"
read -p " PORTA :" sslpt
if [ -z $sslpt ]; then
echo;echo -e "${lor1}  INVALID PORT"  
else 
if (echo $sslpt | egrep '[^0-9]' &> /dev/null);then
echo;echo -e "${lor1}  YOU MUST ENTER A NUMBER" 
else
if lsof -Pi :$sslpt -sTCP:LISTEN -t >/dev/null ; then
echo;echo -e "${lor1}  THE PORT IS ALREADY IN USE"  
else
inst_ssl () {
apt-get purge stunnel4 -y 
apt-get purge stunnel -y
apt-get install stunnel -y
apt-get install stunnel4 -y
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${PT}\naccept = ${sslpt}" > /etc/stunnel/stunnel.conf
openssl genrsa -out key.pem 2048 > /dev/null 2>&1
(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')" ; echo "" ; echo "$(wget -qO- ifconfig.me):81" ; echo "" ; echo "" ; echo "" ; echo "@ChumoGH")|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
rm -rf key.pem;rm -rf cert.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart
service stunnel restart
service stunnel4 start
}
fun_bar 'inst_ssl'
echo;echo -e "${lor2}  SSL STUNNEL INSTALLED " 
fi;fi;fi;fi
fi
if [ "$opci" = "2" ];then
del_ssl () {
service stunnel4 stop
apt-get remove stunnel4 -y
apt-get purge stunnel4 -y
apt-get purge stunnel -y
rm -rf /etc/stunnel
rm -rf /etc/stunnel/stunnel.conf
rm -rf /etc/default/stunnel4
rm -rf /etc/stunnel/stunnel.pem
}
fun_bar 'del_ssl'
echo;echo -e "${lor2}  SSL STUNNEL WAS REMOVED " 
fi
if [ "$opci" = "3" ];then
if [ -f /etc/stunnel/stunnel.conf ]; then 
echo;echo -e "${lor7}Enter a name for the SSL Redirector${lor6}"
read -p " :" -e -i stunnel namessl
echo;echo -e "${lor7}Enter the port of the Service to bind${lor6}"
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
read -p " :" -e -i $pt PT
echo;echo -e "${lor7}Enter the New SSL Port${lor6}"
read -p " :" sslpt
if [ -z $sslpt ]; then
echo;echo -e "${lor1}  INVALID PORT"  
else 
if (echo $sslpt | egrep '[^0-9]' &> /dev/null);then
echo;echo -e "${lor1}  YOU MUST ENTER A NUMBER" 
else
if lsof -Pi :$sslpt -sTCP:LISTEN -t >/dev/null ; then
echo;echo -e "${lor1}  THE PORT IS ALREADY IN USE"  
else
addgf () {		
echo -e "\n[$namessl] " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:$PT" >> /etc/stunnel/stunnel.conf 
echo "accept = $sslpt " >> /etc/stunnel/stunnel.conf 
service stunnel4 restart 1> /dev/null 2> /dev/null
service stunnel restart 1> /dev/null 2> /dev/null
sleep 2
}
fun_bar 'addgf'
echo;echo -e "${lor2} NEW PORT ADDED  $sslpt !${lor7}"
fi;fi;fi
else
echo;echo -e "${lor1} SSL STUNEEL NOT INSTALLED !${lor7}"
fi
fi
if [ "$opci" = "4" ];then
if [ -f /etc/stunnel/stunnel.conf ];then
if netstat -nltp|grep 'stunnel4' > /dev/null; then
service stunnel stop 1> /dev/null 2> /dev/null
service stunnel4 stop 1> /dev/null 2> /dev/null
echo;echo -e "${lor1} SERVICE STOPPED "
else
service stunnel start 1> /dev/null 2> /dev/null
service stunnel4 start 1> /dev/null 2> /dev/null
echo;echo -e "${lor2} SERVICE STARTED "
fi
else
echo;echo -e "${lor1} SSL STUNNEL IS NOT INSTALLED "
fi
fi

if [ "$opci" = "5" ];then
if [ -f /etc/stunnel/stunnel.conf ]; then
insapa2(){
for pid in $(pgrep python);do
kill $pid
done
for pid in $(pgrep apache2);do
kill $pid
done
service dropbear stop
apt install apache2 -y
echo "Listen 80

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule> " > /etc/apache2/ports.conf
service apache2 restart
}
fun_bar 'insapa2'
echo;echo -e "${lor7} Verify Domain ${lor6}"
read -p " KEY:" keyy
echo
read -p " DATA:" dat2w
mkdir -p /var/www/html/.well-known/pki-validation/
datfr1=$(echo "$dat2w"|awk '{print $1}')
datfr2=$(echo "$dat2w"|awk '{print $2}')
datfr3=$(echo "$dat2w"|awk '{print $3}')
echo -ne "${datfr1}\n${datfr2}\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt
echo;echo -e "${lor3} CHECK ON THE ZEROSSL PAGE ${lor7}"
read -p " ENTER TO CONTINUE"
echo;echo -e "${lor7} CERTIFICATE LINK ${lor6}"
echo -e "${lor6} LINK ${lor1}> ${lor7}\c"
read linksd
inscerts(){
wget $linksd -O /etc/stunnel/certificado.zip
cd /etc/stunnel/
unzip certificado.zip 
cat private.key certificate.crt ca_bundle.crt > stunnel.pem
service stunnel restart
service stunnel4 restart
}
fun_bar 'inscerts'
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 
echo;echo -e "${lor2} CERTIFICATE INSTALLED ${lor7}" 
else
echo;echo -e "${lor1} SSL STUNNEL IS NOT INSTALLED "
fi
fi
[[ $opci = "0" ]] && {
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart
 exit && menu
 }
espe
source <(curl -sSL https://www.dropbox.com/s/ooe74y69nm89da9/front.sh)
