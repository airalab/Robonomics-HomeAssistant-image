#!/bin/bash -e

cd /home/$USER
wget https://dist.ipfs.io/go-ipfs/v0.14.0/go-ipfs_v0.14.0_linux-arm64.tar.gz
tar -xvzf go-ipfs_v0.14.0_linux-arm64.tar.gz
rm go-ipfs_v0.14.0_linux-arm64.tar.gz
cd go-ipfs
sudo bash install.sh
ipfs init -p local-discovery
ipfs bootstrap add /dns4/1.pubsub.aira.life/tcp/443/wss/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8
ipfs bootstrap add /dns4/2.pubsub.aira.life/tcp/443/wss/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9
ipfs bootstrap add /dns4/3.pubsub.aira.life/tcp/443/wss/ipfs/QmWZSKTEQQ985mnNzMqhGCrwQ1aTA6sxVsorsycQz9cQrw


cd /home/$USER
curl -O https://raw.githubusercontent.com/LoSk-p/robonomics-hass-utils/main/raspberry_pi/ipfs_check.sh
sudo chmod a+x ipfs_check.sh
sudo mv ipfs_check.sh /usr/local/bin/


echo "[Unit]
Description=IPFS Daemon Service

[Service]
Type=simple
ExecStartPre=/usr/local/bin/ipfs_check.sh
ExecStart=/usr/local/bin/ipfs daemon
User=ubuntu

[Install]
WantedBy=multi-user.target

" | sudo tee /etc/systemd/system/ipfs-daemon.service

sudo systemctl enable ipfs-daemon.service
sudo systemctl start ipfs-daemon.service