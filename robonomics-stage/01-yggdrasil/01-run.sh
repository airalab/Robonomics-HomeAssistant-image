#!/bin/bash -e

on_chroot << EOF
    cd
    wget https://github.com/yggdrasil-network/yggdrasil-go/releases/download/v0.4.7/yggdrasil-0.4.7-arm64.deb
    dpkg -i yggdrasil-0.4.7-arm64.deb
    rm yggdrasil-0.4.7-arm64.deb
    rm /etc/yggdrasil.conf

    curl -O https://raw.githubusercontent.com/nakata5321/robonomics-hass-utils/main/raspberry_pi/configuration_first_start.sh
    curl -O https://raw.githubusercontent.com/airalab/robonomics-hass-utils/main/raspberry_pi/input.json
    chmod a+x configuration_first_start.sh
    mv configuration_first_start.sh /usr/local/bin/

    echo "[Unit]
Description=IPFS Daemon Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/configuration_first_start.sh

[Install]
WantedBy=multi-user.target

  " | tee /etc/systemd/system/configuration.service

  systemctl enable configuration.service
EOF