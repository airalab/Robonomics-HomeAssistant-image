#!/bin/bash -e

on_chroot << EOF

  install -d /opt/zigbee2mqtt
  chown -R ${FIRST_USER_NAME}: /opt/zigbee2mqtt

  su ${FIRST_USER_NAME} -c "git clone --depth 1 --branch 1.28.0 https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt"

  cd /opt/zigbee2mqtt
  su ${FIRST_USER_NAME} -c "npm ci"
EOF