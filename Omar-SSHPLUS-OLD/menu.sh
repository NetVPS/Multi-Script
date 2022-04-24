#!/bin/bash
 clear
 echo -e "\033[1;35m<<\033[1;31mINSTALANDO PAQUETES\033[1;35m>>\033[1;37m"
 touch /root/usuarios.db
 rm -rf /usr/bin/menu.sh
 ln -s /root/menu /usr/bin
 rm -rf /usr/bin/sftp
 rm -rf /usr/bin/ftp
 rm -rf /usr/bin/pftp
 rm - rf /root/menu.sh
 mkdir /etc/SSHPlus/amor
 clear
 wget https://www.dropbox.com/s/kem6a7pkvhyv169/auto.sh; chmod 777 auto.sh
 wget https://www.dropbox.com/s/ymvtjqfpplvrv7f/desis.sh; chmod 777 desis.sh
 wget https://www.dropbox.com/s/m8muc2akk791swj/d.sh; chmod 777 d.sh
 wget https://www.dropbox.com/s/10bwk86sh0970ue/au.sh; chmod 777 au.sh
 wget https://www.dropbox.com/s/uu99u7ixaz1zln7/dd.sh; chmod 777 dd.sh
 wget https://www.dropbox.com/s/uyccy3b8gpyz4gd/autoiniciossl.sh; chmod 777 autoiniciossl.sh
 wget https://www.dropbox.com/s/trjosx1t0w9slcp/amor2.sh; chmod 777 amor2.sh
 wget https://www.dropbox.com/s/bv8e1f0wznuqwfk/instalarssl.sh; chmod 777 instalarssl.sh
 wget https://www.dropbox.com/s/x0fpzqnjf5pzl75/sl.sh; chmod 777 sl.sh
 wget https://www.dropbox.com/s/mp0sy8poysmdye5/y.sh; chmod 777 y.sh
 wget https://www.dropbox.com/s/ms1tm44qs4h5lbd/ap.sh; chmod 777 ap.sh
 wget https://www.dropbox.com/s/1n1rhr8s9j9meuo/fg.sh; chmod 777 fg.sh
 wget https://www.dropbox.com/s/l07its4u82vq1ie/jls.sh; chmod 777 jls.sh
 wget https://www.dropbox.com/s/qamao34r5s8fezc/w.sh; chmod 777 w.sh
 wget https://www.dropbox.com/s/1z54h0gr73sedbp/jail.sh; chmod 777 jail.sh
 wget https://www.dropbox.com/s/6r8hgoi6k4ed6no/jl.sh; chmod 777 jl.sh
 wget https://www.dropbox.com/s/dylv0pyxq6dhke7/amor.sh; chmod 777 amor.sh
 wget https://www.dropbox.com/s/oz9m2hditqwt8yu/op.sh; chmod 777 op.sh
 wget https://www.dropbox.com/s/o7hb1i2velu4i2y/sdd.sh; chmod 777 sdd.sh
 wget https://www.dropbox.com/s/rqsf4egqjoxrbtj/c.sh; chmod 777 c.sh
 wget https://www.dropbox.com/s/nfd4civvj2lscsp/jrd.sh; chmod 777 jrd.sh
 wget https://www.dropbox.com/s/x5q0f4fc07jmi9t/sd1.sh; chmod 777 sd1.sh
 wget https://www.dropbox.com/s/ndkvxhe9i9lpmcr/x.sh; chmod 777 x.sh
 wget https://www.dropbox.com/s/9j32vc87p8af3qb/jk.sh; chmod 777 jk.sh
 wget https://www.dropbox.com/s/ufiqi04twvltubq/sd.sh; chmod 777 sd.sh
 wget https://www.dropbox.com/s/2rda4vp5u0vydju/listausuarios.sh; chmod 777 listausuarios.sh
 wget https://www.dropbox.com/s/02yorqvxansx9a2/lj.sh; chmod 777 lj.sh
 wget https://www.dropbox.com/s/42hbmx1f6scmf7e/eliminar.sh; chmod 777 eliminar.sh
 wget https://www.dropbox.com/s/g9y1clk9orjj3ct/u.sh; chmod 777 u.sh
 wget https://www.dropbox.com/s/yfj2u0mgi9xmdx2/desbloquear.sh; chmod 777 desbloquear.sh
 wget https://www.dropbox.com/s/kcqt5utoboplplh/v.sh; chmod 777 v.sh
 wget https://www.dropbox.com/s/idfcfnt3rif2rmm/cuss.sh; chmod 777 cuss.sh
 wget https://www.dropbox.com/s/fbrv3byewy7l16h/te.py; chmod 777 te.py
 wget https://www.dropbox.com/s/5ekq30i0u84mudj/bloquear.sh; chmod 777 bloquear.sh
 wget https://www.dropbox.com/s/um8mwvlrbzis6pw/pay.sh; chmod 777 pay.sh
 wget https://www.dropbox.com/s/vbr6b8w2i16zbnf/badvpn-udpgw -o /dev/null
 			mv -f $HOME/badvpn-udpgw /bin/badvpn-udpgw
 			chmod 777 /bin/badvpn-udpgw
 wget https://www.dropbox.com/s/9u7r6spza2i9mkq/proxy.py; chmod 777 proxy.py
 grep -v "^PasswordAuthentication" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
 echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
 service ssh restart
 wget https://www.dropbox.com/s/c7h48b02es80bo6/menu; chmod 777 menu
 rm -rf auto.sh.1 bloquear.sh.1 cuss.sh.1 desbloquear.sh.1 eliminar.sh.1 listausuarios.sh.1 menu.sh.1 menu.1 proxy.py.1
 ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp ; ufw allow 442/tcp
 clear
 touch /etc/xx
 ins_pct () {
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•\033[1;35m>>"
 clear
 apt-get install bc -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••\033[1;35m>>"
 apt-get install screen -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••\033[1;35m>>"
 apt-get install nano -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••\033[1;35m>>"
 apt-get install unzip -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••\033[1;35m>>"
 apt-get install lsof -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••\033[1;35m>>"
 apt-get install netstat -y /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••••\033[1;35m>>"
 apt-get install net-tools -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••\033[1;35m>>"
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••••••\033[1;35m>>"
 apt-get install nload -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••••\033[1;35m>>"
 apt-get install jq -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••••••••\033[1;35m>>"
 apt-get install curl -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••••••\033[1;35m>>"
 apt-get install figlet -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••••••••\033[1;35m>>"
 apt-get install python-pip -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••••••••••••\033[1;35m>>"
 apt-get install python3 -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS•••••••••••••••••\033[1;35m>>"
 apt-get install python3-pip -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••••••••••••\033[1;35m>>"
 apt-get install python-pip -y > /dev/null 2>&1
 clear
 echo -e " \033[1;35m<<\033[1;31mINSTALANDO PAQUETES NECESARIOS••••••••••••••••••••\033[1;35m>>"
 pip install speedtest-cli -y > /dev/null 2>&1
 }
 sleep 3s
 clear
 echo -e "\033[1;37m•\033[0m"
 sleep 1s
 clear
 echo -e "\033[1;37m••\033[0m"
 sleep 1s
 clear
 echo -e "\033[1;37m•••\033[0m"
 sleep 1s
 clear
 echo -e "\033[1;37m••••\033[0m"
 sleep 1s
 clear
 echo -e "\033[1;37m••••••\033[0m"
 sleep 3s
 clear
 echo -e "\033[1;37m•PYTHON\033[0m"
 sleep 2s
 echo -e "\033[1;37m••PYTHON 2\033[0m"
 sleep 2s
 echo -e "\033[1;37m•••PYTHON 3\033[0m"
 sleep 2s
 echo -e "\033[1;37m••••NETLOAD\033[0m"
 apt-get install nload -y > /dev/null 2>&1
 apt-get install python3-pip -y > /dev/null 2>&1
 sleep 1s
 echo -e "\033[1;37m•••••BC\033[0m"
 apt-get install screen -y > /dev/null 2>&1
 apt-get install bc -y > /dev/null 2>&1
 apt-get install net-tools -y > /dev/null 2>&1
 sleep 1s
 echo -e "\033[1;37m••••••JQ\033[0m"
 apt-get install jq -y > /dev/null 2>&1
 sudo apt-get install cron -y > /dev/null 2>&1
 sudo apt-get install wget -y > /dev/null 2>&1
 sleep 1s
 echo -e "\033[1;37m•••••••UNZIP\033[0m"
 apt install unzip -y > /dev/null 2>&1
 apt install less -y > /dev/null 2>&1
 apt install lsof -y > /dev/null 2>&1
 echo -e "\033[1;37m••••••••CURL\033[0m"
 pip install speedtest-cli -y > /dev/null 2>&1
 sudo apt-get install firewalld -y > /dev/null 2>&1
 sleep 2s
 echo -e "\033[1;37m•••••••••PYTHON-PIP\033[0m"
 sleep 2s
 echo -e "\033[1;37m••••••••••PYTHON3-PIP\033[0m"
 sleep 2s
 echo -e "\033[1;37m•••••••••••SPEEDTEST-CLI\033[0m"
 echo ""
 echo -e "\E[44;1;37mINSTALADOS\033[0m"
 sleep  3s
 clear
 echo -e " \E[41;1;37m <<•••ESCRIVE MENU PARA ENTRAR AL PANEL Y OPCIONES•••>> \033[0m"
 echo ""
 echo -ne "\E[41;1;37mESCRIVA:\033[0m""\033[1;37m>>\033[0m"; read
 menu; exit
 echo "/bin/menu" > /bin/m && chmod +x /bin/m > /dev/null 2>&1
 echo "cd /bin && bash ./menu" > /bin/msc && chmod +x /bin/msc
 wget https://www.dropbox.com/s/aef497uvhtvp3mi/usuario.sh -O /root/usuario.sh > /dev/null 2>&1  /root/usuario.sh chmod 777 usuario.sh ./mio.sh
 
 
 
 wget --no-check-certificate -O Instalador-Shadowsocks-libev.sh https://www.dropbox.com/s/1k18df0ccr3vd2l/Instalador-Shadowsocks-libev.sh?dl=0  - O /bin/Instalador-Shadowsocks-libev.sh > /dev/null 2>&1
 chmod +x Instalador-Shadowsocks-libev.sh
 Instalador-Shadowsocks-libev.sh 2>&1 | tee Instalador-Shadowsocks-libev.log; /bin/Instalador-Shadowsocks-libev.sh
 touch /root/usuarios.db
 
  