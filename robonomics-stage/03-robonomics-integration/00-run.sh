#!/bin/bash -e

on_chroot << EOF

  cd /srv/homeassistant

  su homeassistant -c "source bin/activate && pip3 install robonomics-interface~=1.3"

  su homeassistant -c "cd /home/homeassistant/.homeassistant && mkdir custom_components && cd custom_components && svn checkout https://github.com/airalab/homeassistant-robonomics-integration/trunk/custom_components/robonomics"

EOF