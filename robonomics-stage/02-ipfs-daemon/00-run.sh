#!/bin/bash -e

on_chroot << EOF

  useradd -rm ipfsdaemon -d /var/lib/ipfsdaemon

  cd /var/lib/ipfsdaemon/
  su ipfsdaemon -c "wget https://dist.ipfs.io/go-ipfs/v0.21.0/go-ipfs_v0.21.0_linux-arm64.tar.gz"
  su ipfsdaemon -c "tar -xvzf go-ipfs_v0.21.0_linux-arm64.tar.gz"
  su ipfsdaemon -c "rm go-ipfs_v0.21.0_linux-arm64.tar.gz"
  cd go-ipfs
  bash install.sh
  su ipfsdaemon -c "ipfs init -p local-discovery"
  su ipfsdaemon -c "ipfs bootstrap add /dns4/1.pubsub.aira.life/tcp/443/wss/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
  su ipfsdaemon -c "ipfs bootstrap add /dns4/2.pubsub.aira.life/tcp/443/wss/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9"
  su ipfsdaemon -c "ipfs bootstrap add /dns4/3.pubsub.aira.life/tcp/443/wss/ipfs/QmWZSKTEQQ985mnNzMqhGCrwQ1aTA6sxVsorsycQz9cQrw"


  cd /var/lib/ipfsdaemon/
  su ipfsdaemon -c "curl -O https://raw.githubusercontent.com/airalab/robonomics-hass-utils/main/raspberry_pi/ipfs_first_start.sh"
  chmod a+x ipfs_first_start.sh
  mv ipfs_first_start.sh /usr/local/bin/


  echo "[Unit]
Description=IPFS Daemon Service
After=network.target

[Service]
Type=simple
User=ipfsdaemon
ExecStartPre=/usr/local/bin/ipfs_first_start.sh
ExecStart=/usr/local/bin/ipfs daemon --enable-gc

[Install]
WantedBy=multi-user.target

  " | tee /etc/systemd/system/ipfs-daemon.service

  systemctl enable ipfs-daemon.service

  su ipfsdaemon -c "rm -r go-ipfs/"
EOF