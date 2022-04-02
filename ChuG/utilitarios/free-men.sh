#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH

echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
killall kswapd0 > /dev/null 2>&1
echo $(free -h | grep Mem | sed 's/\s\+/,/g' | cut -d , -f4) > /bin/ejecutar/raml
