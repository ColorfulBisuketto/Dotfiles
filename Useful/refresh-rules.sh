#!/usr/bin/env bash

# Refreshed the udev rules. Requires root permissions.
# Made by Me (https://github.com/ColorfulBisuketto)

udevadm control --reload
udevadm trigger
