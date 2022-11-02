#!/bin/bash -e

mkdir /opt/zigbee2mqtt
chown -R ${FIRST_USER_NAME}: /opt/zigbee2mqtt

git clone --depth 1 --branch 1.28.0 https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt

cd /opt/zigbee2mqtt
npm ci