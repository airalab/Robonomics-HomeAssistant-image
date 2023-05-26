#!/bin/bash -e

on_chroot << EOF

  install -d /opt/zigbee2mqtt
  chown -R homeassistant: /opt/zigbee2mqtt

  su homeassistant -c "git clone --depth 1 --branch 1.30.4 https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt"

  cd /opt/zigbee2mqtt
  su homeassistant -c "npm ci"

  echo "[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
ExecStart=/usr/bin/npm start
WorkingDirectory=/opt/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
RestartSec=15
Restart=always
User=homeassistant

[Install]
WantedBy=multi-user.target
  " | tee /etc/systemd/system/zigbee2mqtt.service

  systemctl enable zigbee2mqtt.service

EOF