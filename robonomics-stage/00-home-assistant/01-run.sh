#!/bin/bash -e

on_chroot << EOF

    adduser --disabled-password --gecos "" homeassistant
    usermod -a -G tty homeassistant
    usermod -a -G dialout homeassistant

    install -d  /srv/homeassistant
    chown homeassistant:homeassistant /srv/homeassistant

    cd /srv/homeassistant

    su homeassistant -c "python3 -m venv ."

    su homeassistant -c bash -c "source bin/activate && pip3 install wheel~=0.37"

    su homeassistant -c bash -c "source bin/activate && pip3 install sqlalchemy~=1.4 fnvhash~=0.1 aiodiscover==1.4.11"

    su homeassistant -c bash -c "source bin/activate && pip3 install homeassistant==2023.1.7 psutil-home-assistant~=0.0"

    install -d  /home/homeassistant/.homeassistant/
    chown homeassistant:homeassistant /home/homeassistant/.homeassistant/

    install -d  /home/homeassistant/.homeassistant/media/
    chown homeassistant:homeassistant /home/homeassistant/.homeassistant/media/

EOF