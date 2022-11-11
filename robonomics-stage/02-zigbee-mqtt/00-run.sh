#!/bin/bash -e

on_chroot << EOF

  curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

EOF