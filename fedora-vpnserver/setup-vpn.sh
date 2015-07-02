#!/bin/bash

# Bash colors
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
txtrst='\e[0m'    # Text Reset

# Variables
logdir='./log.txt'

success() {
    echo -e "$txtgrn""Success performing operation: $1""$txtrst"
}

failure() {
    echo -e "$txtred""Failure performing operation: $1""$txtrst"
    echo -e "$txtylw""See log.txt for details""$txtrst"
    #exit
}

install() {
    dnf install openvpn easy-rsa 2>> log.txt
    cp -ai /usr/share/easy-rsa/2.0 /root/easy-rsa 2>> log.txt
}

echo -e "$txtblu""Installing required software""$txtrst"
install && success "Installing" || failure "Installing"
