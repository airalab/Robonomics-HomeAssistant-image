#!/bin/bash -e

on_chroot << EOF

  cd /home/${FIRST_USER_NAME}
  su ${FIRST_USER_NAME} -c "wget https://dist.ipfs.io/go-ipfs/v0.14.0/go-ipfs_v0.14.0_linux-arm64.tar.gz"
  su ${FIRST_USER_NAME} -c "tar -xvzf go-ipfs_v0.14.0_linux-arm64.tar.gz"
  su ${FIRST_USER_NAME} -c "rm go-ipfs_v0.14.0_linux-arm64.tar.gz"
  cd go-ipfs
  su ${FIRST_USER_NAME} -c "bash install.sh"
  su ${FIRST_USER_NAME} -c "ipfs init -p local-discovery"
  su ${FIRST_USER_NAME} -c "ipfs bootstrap add /dns4/1.pubsub.aira.life/tcp/443/wss/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
  su ${FIRST_USER_NAME} -c "ipfs bootstrap add /dns4/2.pubsub.aira.life/tcp/443/wss/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9"
  su ${FIRST_USER_NAME} -c "ipfs bootstrap add /dns4/3.pubsub.aira.life/tcp/443/wss/ipfs/QmWZSKTEQQ985mnNzMqhGCrwQ1aTA6sxVsorsycQz9cQrw"


  cd /home/${FIRST_USER_NAME}
  su ${FIRST_USER_NAME} -c "curl -O https://raw.githubusercontent.com/LoSk-p/robonomics-hass-utils/main/raspberry_pi/ipfs_check.sh"
  chmod a+x ipfs_check.sh
  mv ipfs_check.sh /usr/local/bin/


  echo "[Unit]
  Description=IPFS Daemon Service

  [Service]
  Type=simple
  ExecStartPre=/usr/local/bin/ipfs_check.sh
  ExecStart=/usr/local/bin/ipfs daemon
  User=ubuntu

  [Install]
  WantedBy=multi-user.target

  " | tee /etc/systemd/system/ipfs-daemon.service

  systemctl enable ipfs-daemon.service
EOF