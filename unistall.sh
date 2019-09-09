#!/bin/bash
if [ $(id -u) -eq 0 ]; then
    read -p "Hadoop Administrator Username" username;
    usedel $username;
    rm -rf /home/$username/
    hversion="$(hadoop version)";
    rm /tmp/$hversion;
else

fi