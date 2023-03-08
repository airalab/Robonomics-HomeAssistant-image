#!/bin/bash -e

on_chroot << EOF
    cd
    wget https://github.com/yggdrasil-network/yggdrasil-go/releases/download/v0.4.7/yggdrasil-0.4.7-arm64.deb
    dpkg -i yggdrasil-0.4.7-arm64.deb
    rm /etc/yggdrasil.conf

    cd /home/${FIRST_USER_NAME}
    curl -O https://raw.githubusercontent.com/airalab/robonomics-hass-utils/main/raspberry_pi/input.json

EOF