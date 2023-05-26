#!/bin/bash -e

on_chroot << EOF

  echo "[Unit]
  Description=Home Assistant
  After=network-online.target
  [Service]
  Type=simple
  Restart=on-failure
  User=%i
  WorkingDirectory=/srv/%i/
  ExecStart=/srv/homeassistant/bin/hass -c "/home/%i/.homeassistant"
  Environment="PATH=/srv/%i/bin"
  [Install]
  WantedBy=multi-user.target
  " | tee /etc/systemd/system/home-assistant@homeassistant.service


  cd /srv/homeassistant

  su homeassistant -c "source bin/activate && pip3 install robonomics-interface~=1.6"

  install -d  /home/homeassistant/.homeassistant/custom_components
  chown homeassistant:homeassistant /home/homeassistant/.homeassistant/custom_components

  install -d  /home/homeassistant/.homeassistant/.storage
  chown homeassistant:homeassistant /home/homeassistant/.homeassistant/.storage

  su homeassistant -c "cd /home/homeassistant/.homeassistant/custom_components &&
  wget https://github.com/airalab/homeassistant-robonomics-integration/archive/refs/tags/1.5.7.zip &&
  unzip 1.5.7.zip &&
  mv homeassistant-robonomics-integration-1.5.7/custom_components/robonomics . &&
  rm -r homeassistant-robonomics-integration-1.5.7 &&
  rm 1.5.7.zip "

  cd /home/${FIRST_USER_NAME}

  su ${FIRST_USER_NAME} -c "rm -r go-ipfs/"

  passwd -e ${FIRST_USER_NAME}
EOF