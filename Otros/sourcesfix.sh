function fixsources19(){
echo -e "Reinstalando fuentes (sources)"
curl -o /etc/apt/sources.list https://raw.githubusercontent.com/powermx/sources/master/Ubuntu19.10/sources.list && apt-get update && apt-get upgrade -y
echo -e "Reinstalacion completada"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
menu
}
function fixsources18(){
echo -e "Reinstalando fuentes (sources)"
curl -o /etc/apt/sources.list https://raw.githubusercontent.com/powermx/sources/master/ubuntu18.04/sources.list && apt-get update && apt-get upgrade -y
echo -e "Reinstalacion completada"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
menu
}
function fixsources16(){
echo -e "Reinstalando fuentes (sources)"
curl -o /etc/apt/sources.list https://raw.githubusercontent.com/powermx/sources/master/ubuntu16.04/sources.list && apt-get update && apt-get upgrade -y
echo -e "Reinstalacion completada"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
menu
}
function fixsources(){
clear
if [[ $1 == "" ]]
then
figlet -p -f slant < /root/name | lolcat
echo -e "\033[1;37m      【     ★ ChumoGH Packet 2020 ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;30m ───────────────── /// ─────────────────\033[1;33m"
echo -e "\033[1;37m       ChumoGH-ADM @ FIX SOURCES \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m ───────────────── /// ─────────────────\033[1;33m"
echo -e "\033[1;37mSeleccione una opcion:    Para Salir Ctrl + C\033[1;33m
[\033[1;32m1\033[1;33m]   › FIX SOURCES UBUNTU 16.04 \033[1;33m
[\033[1;32m2\033[1;33m]   › FIX SOURCES UBUNTU 18.04 \033[1;33m
[\033[1;32m3\033[1;33m]   › FIX SOURCES UBUNTU 19.10 \033[1;33m
[\033[1;32m4\033[1;33m]   › FIX SOURCES UBUNTU 20.04 \033[1;33m
[\033[1;32m0\033[1;33m] < REGRESAR                 \033[1;33m"
read -p ": " opcao
else
opcao=$1
fi
case $opcao in
1)
fixsources16;;
2)
fixsources18;;
3)
fixsources19;;
4)
fixsources20;;
0)
exit;;
esac
}
fixsources
