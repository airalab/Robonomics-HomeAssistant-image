#!/bin/bash -e

cd /srv/homeassistant

sudo -u homeassistant -H -s bash -c "source bin/activate &&
        pip3 install robonomics-interface~=1.3"

sudo -u homeassistant -H -s bash -c "cd /home/homeassistant/.homeassistant &&
                                     mkdir custom_components &&
                                     cd custom_components &&
                                     svn checkout https://github.com/airalab/homeassistant-robonomics-integration/trunk/custom_components/robonomics"

systemctl restart home-assistant@homeassistant.service
systemctl restart home-assistant@homeassistant.service