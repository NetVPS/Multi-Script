#!/bin/bash
 clear
 echo -e "\E[44;1;37mCOMENZANDO PROCESO\033[0m"
 sleep 1s
 echo -e "\033[1;37m•\033[0m"
 sleep 1s
 echo -e "\033[1;37m••\033[0m"
 sleep 1s
 echo -e "\033[1;37m•••\033[0m"
 sleep 1s
 echo -e "\033[1;37m••••\033[0m"
 sleep 1s
 echo -e "\033[1;37m•••••\033[0m"
 sleep 1s
 echo -e "\033[1;37m••••••\033[0m"
 sleep 1s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m•\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m•••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m•••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m••••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m•••••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m••••••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m•••••••••\033[0m"
 sleep 0.5s
 clear
 echo -e "\E[44;1;37mESPERE POR FAVOR ESTO PUEDE DEMORAR\033[0m"
 sleep 0.5s
 echo -e "\033[1;37m••••••••••\033[0m"
 sudo dd if=/dev/zero of=/swapfile bs=6024 count=1048576
 sudo chmod 600 /swapfile
 sudo mkswap /swapfile
 sudo swapon /swapfile
 sudo sysctl vm.swappiness=70
 echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab
 echo "vm.swappiness=70" >> /etc/sysctl.conf
 clear
 echo -e               "\033[1;33m                ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo -e               "\033[1;33m                ""\E[41;1;37m << MEMORIA SWAP OPTIMIZACION DE RAM Y SPEED >> \033[0m"
 echo -e               "\033[1;33m                ""\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
 echo ""
 echo -e "\E[44;1;37mREDUCCION DE MEMORIA RAM Y DESCANZO APLICADO CON ÉXITO SPEEDVPS\033[0m"
 echo ""
 echo -e "\E[41;1;37m[15]-AUTO-MENU\033[0m"   "\E[41;1;37m[00]-EXIT\033[0m"
 echo ""
 echo -ne "\E[41;1;37mOPCION:\033[0m""\033[1;37m>>\033[0m "; read opcion
 case $opcion in
 15)/root/menu
 ;;
 esac
 exit
  