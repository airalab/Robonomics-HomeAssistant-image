#!/bin/bash -e

whoami

on_chroot << EOF
    whoami
    pwd
    HA=homeassistant

    adduser --disabled-password --gecos "" ${HA}
    install -d  /srv/homeassistant
    chown ${HA}:${HA} /srv/homeassistant

    cd /srv/homeassistant

    pwd
    whoami

    su ${HA} -p -c python3 -m venv .
    su ${HA} -p -c bash -c "source bin/activate &&
            pip3 install wheel~=0.37"

    su ${HA} -p -c bash -c "source bin/activate &&
                 pip3 install sqlalchemy~=1.4 fnvhash~=0.1 aiodiscover==1.4.11"

    su ${HA} -p -c bash -c "source bin/activate &&
                 pip3 install homeassistant==2022.10.3 psutil-home-assistant~=0.0 &&
                       timeout 60s hass"
EOF