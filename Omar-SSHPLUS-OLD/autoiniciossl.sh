#!/bin/bash
 apt-get install stunnel4 -y
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel4 restart
 service stunnel4 start
 
  