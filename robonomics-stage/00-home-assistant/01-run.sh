#!/bin/bash -e

on_chroot << EOF

    useradd -rm homeassistant -d /srv/homeassistant -G dialout,tty

    cd /srv/homeassistant

    su homeassistant -c "python3 -m venv ."

    su homeassistant -c bash -c "source bin/activate && pip3 install wheel~=0.41.0"

    su homeassistant -c bash -c "source bin/activate && pip3 install sqlalchemy~=2.0.15 fnvhash~=0.1.0 aiodiscover~=1.4.16"

    su homeassistant -c bash -c "source bin/activate && pip3 install homeassistant==2023.5.4 psutil-home-assistant~=0.0.1"

    install -d  /srv/homeassistant/.homeassistant/
    chown homeassistant:homeassistant /srv/homeassistant/.homeassistant/

    install -d  /srv/homeassistant/.homeassistant/media/
    chown homeassistant:homeassistant /srv/homeassistant/.homeassistant/media/

EOF