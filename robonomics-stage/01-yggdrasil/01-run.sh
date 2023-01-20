#!/bin/bash -e

on_chroot << EOF
    echo "111111111111111111111"
    install -d /usr/local/apt-keys
    echo "2222222222222222222222222"
    gpg --fetch-keys https://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/key.txt
    echo "333333333333333333333333333333"
    gpg --export 569130E8CA20FBC4CB3FDE555898470A764B32C9 | sudo tee /usr/local/apt-keys/yggdrasil-keyring.gpg > /dev/null
    echo "444444444444444444444444444444444444"
    echo 'deb [signed-by=/usr/local/apt-keys/yggdrasil-keyring.gpg] http://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/ debian yggdrasil' | sudo tee /etc/apt/sources.list.d/yggdrasil.list
    echo "5555555555555555555555555555555555"
    apt-get update
EOF