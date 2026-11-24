#!/usr/bin/env bash

# Refreshed the udev rules. Requires root permissions.

udevadm control --reload
udevadm trigger
