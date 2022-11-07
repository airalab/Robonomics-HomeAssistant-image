#!/bin/bash -e

whoami

on_chroot << EOF
    whoami

    sudo useradd -rm homeassistant
    sudo mkdir /srv/homeassistant
    sudo chown homeassistant:homeassistant /srv/homeassistant

    cd /srv/homeassistant
    sudo -u homeassistant -H -s python3 -m venv .
    sudo -u homeassistant -H -s bash -c "source bin/activate &&
            pip3 install wheel~=0.37"

    sudo -u homeassistant -H -s bash -c "source bin/activate &&
                 pip3 install sqlalchemy~=1.4 fnvhash~=0.1 aiodiscover==1.4.11"

    sudo -u homeassistant -H -s bash -c "source bin/activate &&
                 pip3 install homeassistant==2022.10.3 psutil-home-assistant~=0.0 &&
                       timeout 60s hass"
EOF