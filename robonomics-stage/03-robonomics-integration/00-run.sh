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

  systemctl enable home-assistant@homeassistant.service

  cd /srv/homeassistant

  su homeassistant -c "source bin/activate && pip3 install robonomics-interface~=1.3"

  install -d  /home/homeassistant/.homeassistant/custom_components
  chown homeassistant:homeassistant /home/homeassistant/.homeassistant/custom_components

  su homeassistant -c "cd /home/homeassistant/.homeassistant/custom_components && svn checkout https://github.com/airalab/homeassistant-robonomics-integration/trunk/custom_components/robonomics"

  cd /home/${FIRST_USER_NAME}

  su ${FIRST_USER_NAME} -c "rm -r go-ipfs/"

  cloud-init clean

EOF