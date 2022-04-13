#!/bin/bash
#19/12/2019
clear
msg -bar

BadVPN () {
if [[ -z $(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep "badvpn-ud"|awk '{print $1}') ]]; then
    print_center -ama "INICIADO BADVPN"
    msg -bar

echo -e "[Unit]
Description=BadVPN UDPGW Service
After=network.target\n
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
Restart=always
RestartSec=3s\n
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/badvpn.service

    systemctl enable badvpn &>/dev/null
    systemctl start badvpn &>/dev/null
    sleep 2
    [[ -z $(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep "badvpn-ud"|awk '{print $1}') ]] && print_center -verm2 "FALLA AL INICIAR" || print_center -verd "BADVPN INICIADO" 
    sleep 1
else
    print_center -ama "DETENIENDO BADVPN"
    msg -bar
    systemctl stop badvpn &>/dev/null
    systemctl disable badvpn &>/dev/null
    rm /etc/systemd/system/badvpn.service
    sleep 2
    [[ -z $(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep "badvpn-ud"|awk '{print $1}') ]] && print_center -ama "BADVPN DETENIDO" || print_center -verm2 "FALLA AL DETENER"
    sleep 1  
fi
unset st_badvpn
enter
return 1
}

install(){
	title "INSTALADO BADVPN"
	if [[ ! -e /usr/bin/badvpn-udpgw ]]; then
		echo -ne "$(msg -azu " INSTALADO DEPENDECIAS...") "
		if apt install cmake -y &>/dev/null; then
			msg -verd "[OK]"
		else
            msg -verm2 "[fail]"
            slee 3
            return 1
        fi
        cd ${ADM_src}
        echo -ne "$(msg -azu " DESCARGANDO BADVPN......") "
        if wget https://github.com/rudi9999/ADMRufu/raw/main/Utils/badvpn/badvpn-master.zip &>/dev/null; then
            msg -verd "[OK]"
        else
            msg -verm2 "[fail]"
            slee 3
            return 1
        fi

        echo -ne "$(msg -azu " DESCOMPRIMIENDO.........") "
        if unzip badvpn-master.zip &>/dev/null; then
            msg -verd "[OK]"
        else
            msg -verm2 "[fail]"
            slee 3
            return 1
        fi
        cd badvpn-master
        mkdir build
        cd build

        echo -ne "$(msg -azu " COMPILANDO BADVPN.......") "
        if cmake .. -DCMAKE_INSTALL_PREFIX="/" -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 &>/dev/null && make install &>/dev/null; then
            msg -verd "[OK]"
        else
            msg -verm2 "[fail]"
            slee 3
            return 1
        fi
        msg -bar
        cd $HOME
        rm ${ADM_src}/badvpn-master.zip &>/dev/null
    fi
    BadVPN
}
install

