#!/bin/bash -e

on_chroot << EOF
    cd
    wget https://github.com/yggdrasil-network/yggdrasil-go/releases/download/v0.4.7/yggdrasil-0.4.7-arm64.deb
    dpkg -i yggdrasil-0.4.7-arm64.deb
    systemctl stop yggdrasil
    rm /etc/yggdrasil.conf

EOF