#!/bin/bash -e

on_chroot << EOF

  echo "[Unit]
Description=Home Assistant
After=network-online.target

[Service]
Type=simple
Restart=on-failure
User=homeassistant
WorkingDirectory=/srv/homeassistant/
ExecStart=/srv/homeassistant/bin/hass -c "/srv/homeassistant/.homeassistant"
Environment="PATH=/srv/homeassistant/bin"

[Install]
WantedBy=multi-user.target
  " | tee /etc/systemd/system/home-assistant.service


  cd /srv/homeassistant

  su homeassistant -c "source bin/activate && pip3 install robonomics-interface~=1.6"

  install -d  /srv/homeassistant/.homeassistant/custom_components
  chown homeassistant:homeassistant /srv/homeassistant/.homeassistant/custom_components

  install -d  /srv/homeassistant/.homeassistant/.storage
  chown homeassistant:homeassistant /srv/homeassistant/.homeassistant/.storage

  su homeassistant -c "cd /srv/homeassistant/.homeassistant/custom_components &&
  wget https://github.com/airalab/homeassistant-robonomics-integration/archive/refs/tags/1.5.9.zip &&
  unzip 1.5.9.zip &&
  mv homeassistant-robonomics-integration-1.5.9/custom_components/robonomics . &&
  rm -r homeassistant-robonomics-integration-1.5.9 &&
  rm 1.5.9.zip "

  passwd -e ${FIRST_USER_NAME}
EOF