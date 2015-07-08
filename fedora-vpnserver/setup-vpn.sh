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
installpath='/root/easy-rsa'

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
    cp -ai /usr/share/easy-rsa/2.0 $installpath 2>> log.txt
}

setup() {
    vi $installpath/vars
    source $installpath/vars
    sh $installpath/clean-all
    sh $installpath/build-ca
    sh $installpath/build-key-server $( hostname | cut -d. -f1 )
    sh $installpath/build-dh
    mkdir /etc/openvpn/keys
    cp -ai $installpath/keys/$( hostname | cut -d. -f1 ).{crt,key} keys/ca.crt keys/dh*.pem /etc/openvpn/keys/
}

echo -e "$txtblu""Installing required software""$txtrst"
install && success "Installing" || failure "Installing"
