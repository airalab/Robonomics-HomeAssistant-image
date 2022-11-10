#!/bin/bash -e

whoami

on_chroot << EOF
    whoami
    pwd

    adduser --disabled-password --gecos "" homeassistant
    install -d  /srv/homeassistant
    chown homeassistant:homeassistant /srv/homeassistant

    cd /srv/homeassistant

    su homeassistant -p -c "python3 -m venv ."

    su homeassistant -p -c bash -c "source bin/activate && pip3 install wheel~=0.37"

    su homeassistant -p -c bash -c "source bin/activate && pip3 install sqlalchemy~=1.4 fnvhash~=0.1 aiodiscover==1.4.11"

    su homeassistant -p -c bash -c "source bin/activate && pip3 install homeassistant==2022.10.3 psutil-home-assistant~=0.0"

    cd /home/homeassistant
    pwd

    su homeassistant -p -c bash -c "timeout 60s hass"
EOF