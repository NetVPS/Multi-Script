#!/bin/bash
#19/12/2019

drop_port(){
    local portasVAR=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
    local NOREPEAT
    local reQ
    local Port

    while read port; do
        reQ=$(echo ${port}|awk '{print $1}')
        Port=$(echo {$port} | awk '{print $9}' | awk -F ":" '{print $2}')
        [[ $(echo -e $NOREPEAT|grep -w "$Port") ]] && continue
        NOREPEAT+="$Port\n"

        case ${reQ} in
            cupsd)continue;;
            systemd-r)continue;;
            stunnel4|stunnel)continue;;
            *)DPB+=" $reQ:$Port";;
        esac
    done <<< "${portasVAR}"
 }

ssl_stunel(){
    [[ $(mportas|grep stunnel4|head -1) ]] && {
        clear
        msg -bar
        print_center -ama "Parando Stunnel"
        msg -bar
        service stunnel4 stop & >/dev/null 2>&1
        fun_bar 'apt-get purge stunnel4 -y' 'UNINSTALL STUNNEL4 '
        msg -bar
        print_center -verd "Stunnel detenido con Exito!"
        msg -bar
        sleep 2
        return 1
    }
    title "INSTALADOR SSL By @Rufu99"
    print_center -azu "Seleccione puerto de redireccion de trafico"
    msg -bar
    drop_port
    n=1
    for i in $DPB; do
        proto=$(echo $i|awk -F ":" '{print $1}')
        proto2=$(printf '%-12s' "$proto")
        port=$(echo $i|awk -F ":" '{print $2}')
        echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -ama "$proto2")$(msg -azu "$port")"
        drop[$n]=$port
        num_opc="$n"
        let n++ 
    done
    msg -bar

    while [[ -z $opc ]]; do
        msg -ne " opcion: "
        read opc
        tput cuu1 && tput dl1

        if [[ -z $opc ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ ! $opc =~ $numero ]]; then
            msg -verm2 " selecciona solo numeros entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ "$opc" -gt "$num_opc" ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            sleep 2
            tput cuu1 && tput dl1
            unset opc
            continue
        fi
    done

    title "INSTALADOR SSL By @Rufu99"
    echo -e "\033[1;33m Puerto de redireccion de trafico: \033[1;32m${drop[$opc]}"
    msg -bar
    while [[ -z $opc2 ]]; do
        echo -ne "\033[1;37m Ingrese un puerto para SSL: " && read opc2
        tput cuu1 && tput dl1

        [[ $(mportas|grep -w "${opc2}") = "" ]] && {
            echo -e "\033[1;33m $(fun_trans  "Puerto de ssl:")\033[1;32m ${opc2} OK"
        } || {
            echo -e "\033[1;33m $(fun_trans  "Puerto de ssl:")\033[1;31m ${opc2} FAIL" && sleep 2
            tput cuu1 && tput dl1
            unset opc2
        }
    done

    # openssl x509 -in 2.crt -text -noout |grep -w 'Issuer'|awk -F 'O = ' '{print $2}'|cut -d ',' -f1

    msg -bar
    fun_bar 'apt-get install stunnel4 -y' 'INSTALL STUNNEL4 '
    echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${opc2}\nconnect = 127.0.0.1:${drop[$opc]}" > /etc/stunnel/stunnel.conf

    db="$(ls ${ADM_crt})"
    opcion="n"
    if [[ ! "$(echo "$db"|grep ".crt")" = "" ]]; then
        cert=$(echo "$db"|grep ".crt")
        key=$(echo "$db"|grep ".key")
        msg -bar
        print_center -azu "CERTIFICADO SSL ENCONTRADO"
        msg -bar
        echo -e "$(msg -azu "CERT:") $(msg -ama "$cert")"
        echo -e "$(msg -azu "KEY:")  $(msg -ama "$key")"
        msg -bar
        msg -ne "Continuar, usando estre certificado [S/N]: "
        read opcion
        if [[ $opcion != @(n|N) ]]; then
            cp ${ADM_crt}/$cert ${ADM_tmp}/stunnel.crt
            cp ${ADM_crt}/$key ${ADM_tmp}/stunnel.key
        fi
    fi

    if [[ $opcion != @(s|S) ]]; then
        openssl genrsa -out ${ADM_tmp}/stunnel.key 2048 > /dev/null 2>&1
        (echo "" ; echo "" ; echo "" ; echo "" ; echo "" ; echo "" ; echo "@cloudflare" )|openssl req -new -key ${ADM_tmp}/stunnel.key -x509 -days 1000 -out ${ADM_tmp}/stunnel.crt > /dev/null 2>&1
    fi
    cat ${ADM_tmp}/stunnel.key ${ADM_tmp}/stunnel.crt > /etc/stunnel/stunnel.pem
    sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
    service stunnel4 restart > /dev/null 2>&1
    msg -bar
    print_center -verd "INSTALADO CON EXITO"
    msg -bar
    rm -rf ${ADM_tmp}/stunnel.crt > /dev/null 2>&1
    rm -rf ${ADM_tmp}/stunnel.key > /dev/null 2>&1
    sleep 3
    return 1
}

add_port(){
    title "INSTALADOR SSL By @Rufu99"
    print_center -azu "Seleccione puerto de redireccion de trafico"
    msg -bar
    drop_port
    n=1
    for i in $DPB; do
        proto=$(echo $i|awk -F ":" '{print $1}')
        proto2=$(printf '%-12s' "$proto")
        port=$(echo $i|awk -F ":" '{print $2}')
        echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -ama "$proto2")$(msg -azu "$port")"
        drop[$n]=$port
        num_opc="$n"
        let n++ 
    done
    msg -bar

    while [[ -z $opc ]]; do
        msg -ne " opcion: "
        read opc
        tput cuu1 && tput dl1

        if [[ -z $opc ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ ! $opc =~ $numero ]]; then
            msg -verm2 " selecciona solo numeros entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ "$opc" -gt "$num_opc" ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            sleep 2
            tput cuu1 && tput dl1
            unset opc
            continue
        fi
    done

    title "INSTALADOR SSL By @Rufu99"
    echo -e "\033[1;33m Puerto de redireccion de trafico: \033[1;32m${drop[$opc]}"
    msg -bar
    while [[ -z $opc2 ]]; do
        echo -ne "\033[1;37m Ingrese un puerto para SSL: " && read opc2
        tput cuu1 && tput dl1

        [[ $(mportas|grep -w "${opc2}") = "" ]] && {
            echo -e "\033[1;33m $(fun_trans  "Puerto de ssl:")\033[1;32m ${opc2} OK"
        } || {
            echo -e "\033[1;33m $(fun_trans  "Puerto de ssl:")\033[1;31m ${opc2} FAIL" && sleep 2
            tput cuu1 && tput dl1
            unset opc2
        }
    done
    echo -e "client = no\n[SSL+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${opc2}\nconnect = 127.0.0.1:${drop[$opc]}" >> /etc/stunnel/stunnel.conf
    service stunnel4 restart > /dev/null 2>&1
    msg -bar
    print_center -verd "PUERTO AGREGADO CON EXITO"
    msg -bar
    sleep 3
    return 1
}

title "INSTALADOR SSL By @Rufu99"
menu_func "ININICIAR O PARAR SSL" "AGREGAR PUERTOS SSL"
msg -bar
echo -ne "$(msg -verd " [0]") $(msg -verm2 ">") " && msg -bra "\033[1;41mVOLVER"
msg -bar
msg -ne " Opcion: "
read opcao
case $opcao in
    1)ssl_stunel;;
    2)add_port;;
    0) return 1;;
esac