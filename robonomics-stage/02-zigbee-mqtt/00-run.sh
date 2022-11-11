#!/bin/bash -e

on_chroot << EOF

  su ${FIRST_USER_NAME} -c "curl -fsSL https://deb.nodesource.com/setup_16.x | bash -"

EOF