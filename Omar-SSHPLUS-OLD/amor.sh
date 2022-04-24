#!/bin/bash
 grep -v "^menu;" /etc/profile > /tmp/tmpass && mv /tmp/tmpass /etc/profile
 echo "menu;" >> /etc/profile
  