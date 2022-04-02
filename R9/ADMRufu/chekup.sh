#!/bin/bash
key_word=$(wget --no-check-certificate -t3 -T5 -qO- "https://raw.githubusercontent.com/NetVPS/Multi-Script/main/R9/ADMRufu/vercion")
echo "${key_word}" > /etc/ADMRufu/new_vercion && chmod +x /etc/ADMRufu/new_vercion
