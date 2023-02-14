#!/bin/bash
clear
BARRA="\033[0;49;31m============================================================\033[0m"
echo -e $BARRA
echo -e "\033[7;107;31mEsto le ayudara a crear un archivo swap para su sistema\033[0m"
echo -e $BARRA
echo "Enter para continuar..."
read foo
stsl=$(ps x | grep "limiter"|grep -v grep > /dev/null && echo -e "\033[1;32m◉ " || echo -e "\033[1;31m○ ")
swap=/swapfile
fstab=/etc/fstab
sysctl=/etc/sysctl.conf

funcion_crear () {
clear
echo -e $BARRA
echo "se recomienda que la memoria swap"
echo "sea de almenos el doble de su memoria ram"
echo -e $BARRA
echo "Seleccione una opcion"
echo ""
echo "1) 2GB"
echo "2) 4GB"
echo "3) 8GB"
echo ""
echo "0) Regresar al inicio"
echo -e $BARRA
echo -n "Opcion:"
read opcion
case $opcion in
1)
clear
echo -e $BARRA
echo "Creando archivo swapfile"
echo -e $BARRA
dd if=/dev/zero of=$swap bs=1MB count=2048
echo -e $BARRA
echo "Archivo creado"
echo "comprueve detalles en la opcion 2";;
2)
clear
echo -e $BARRA
echo "Creando archivo swapfile"
echo -e $BARRA
dd if=/dev/zero of=$swap bs=1MB count=4096
echo -e $BARRA
echo "Archivo creado"
echo "comprueve detalles en la opcion 2";;
3)
clear
echo -e $BARRA
echo "Creando archivo swapfile"
echo -e $BARRA
dd if=/dev/zero of=$swap bs=1MB count=8192
echo -e $BARRA
echo "Archivo creado"
echo "comprueve detalles en la opcion 2";;
0)
echo "";;
*)
echo ""
echo "Solo opciones del 0 al 3"
sleep 2
funcion_crear;;
esac
}

funcion_enter () {
echo ""
echo "Enter para continuar"
read foo
}


funcion_remove () {
clear
echo -e $BARRA
echo "Se encontro un archivo swap pre-existente"
echo -e $BARRA
echo "desea remover el archivo"
echo ""
echo "1) si"
echo "2) no"
echo -e $BARRA
echo -n "Opcion:"
read opcion
case $opcion in
1)
rm $swap
echo ""
echo "archivo removido"
echo ""
echo "Enter para continuar"
read foo
funcion_crear;;
2)
echo "";;
*)
echo ""
echo "Solo opciones del 1 al 2"
sleep 2
funcion_remove;;
esac
}


funcion_check () {
clear
echo -e $BARRA
echo "Comprobando detalles del archivo"
echo -e $BARRA
sleep 3
ls -lh $swap
echo -e $BARRA
}


funcion_error () {
clear
echo -e $BARRA
echo "No se encontro ningun archivo"
echo "para crear usa la opcion 1"
echo -e $BARRA
}


funcion_assign () {
clear
echo -e $BARRA
echo "Asignando permisos y formato"
echo -e $BARRA
sleep 2
chmod 600 $swap
mkswap $swap
echo -e $BARRA
echo "listo"
}


funcion_activar () {
clear
echo -e $BARRA
echo "Como desea activar la memoria swap"
echo -e $BARRA
echo "1) permanente"
echo "2) temporal (asta el proximo reinicio)"
echo ""
echo "0) Regresar al inicio"
echo -e $BARRA
echo -n "Opcion:"
read opcion
case $opcion in
1)
sed -i '/swap/d' $fstab
echo "/swapfile none swap sw 0 0" >> $fstab
swapon $swap
clear
echo -e $BARRA
echo "memoria swap activada"
echo "de forma permanente"
echo -e $BARRA;;
2)
swapon $swap
clear
echo -e $BARRA
echo "memoria swap activada"
echo "asta el proximo reinicio"
echo -e $BARRA;;
0)
echo "";;
*)
echo ""
echo "Solo opciones del 0 al 2"
sleep 2
funcion_activar
esac
}


funcion_prio () {
clear
echo -e $BARRA
echo "Asigne la prioridad swap"
echo -e $BARRA
echo "1) 10"
echo "2) 20 (recomendado)"
echo "3) 30"
echo "4) 40"
echo "5) 50"
echo "6) 60"
echo "7) 70"
echo "8) 80"
echo "9) 90"
echo "10) 100"
echo ""
echo "0) Regresar al inicio"
echo -e $BARRA
echo -n "Opcion:"
read opcion
case $opcion in
1)
clear
echo "vm.swappiness=10" >> $sysctl
echo "swappines asignado en 10"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
2)
clear
echo "vm.swappiness=20" >> $sysctl
echo "swappines asignado en 20"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
3)
clear
echo "vm.swappiness=30" >> $sysctl
echo "swappines asignado en 30"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
4)
clear
echo "vm.swappiness=40" >> $sysctl
echo "swappines asignado en 40"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
5)
clear
echo "vm.swappiness=50" >> $sysctl
echo "swappines asignado en 50"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
6)
clear
echo "vm.swappiness=60" >> $sysctl
echo "swappines asignado en 60"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
7)
clear
echo "vm.swappiness=70" >> $sysctl
echo "swappines asignado en 70"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
8)
clear
echo "vm.swappiness=80" >> $sysctl
echo "swappines asignado en 80"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
9)
clear
echo "vm.swappiness=90" >> $sysctl
echo "swappines asignado en 90"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
10)
clear
echo "vm.swappiness=100" >> $sysctl
echo "swappines asignado en 100"
echo "los cambios se aplicaran"
echo "despues del reinicio";;
0)
echo "";;
*)
echo ""
echo "Solo opciones del 0 al 10"
sleep 2
funcion_prio;;
esac
}


while :
do
clear
echo -e $BARRA
echo "Seleccione una opcion"
echo -e $BARRA
echo "1) Crear/Eliminar archivo"
echo "2) Comprovar archivo"
echo "3) Dar formato y permisos al archivo"
echo "4) Activar/Desactvar swap"
echo "5) Prioridad swap"
echo ""
echo "0) Salir"
echo -e $BARRA
echo -n "Opcion:"
read opcion
case $opcion in
1)
if [ -f $swap ]; then
funcion_remove
else
funcion_crear
fi
funcion_enter;;
2)
if [ -f $swap ]; then
funcion_check
else
funcion_error
fi
funcion_enter;;
3)
if [ -f $swap ]; then
funcion_assign
else
funcion_error
fi
funcion_enter;;
4)
if [ -f $swap ]; then
funcion_activar
else
funcion_error
fi
funcion_enter;;
5)
if [ -f $swap ]; then
funcion_prio
else
funcion_error
fi
funcion_enter;;
0)
clear
echo -e $BARRA
echo "script finalizado"
echo -e $BARRA
echo "Enter para continuar"
read foo
clear
 exit;;
*)
echo ""
 echo "solo opciones del 0 al 5"
 sleep 1;;
esac
done
