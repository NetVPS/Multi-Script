#!/bin/bash
# Si llegaste hasta aqui, No Reproduscas Copias de este ADM
# ERES ADMIRABLE, al lograr llegar hasta aqui
# Moded creado por @ChumoGH
echo -e "ESPERE UN MOMENTO"
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
sudo bash -c "$(curl -fsSL https://www.dropbox.com/s/6pq9oa8m02mrtgx/cgh.sh)"