#!/usr/bin/env bash

exec gamemoderun gamescope -W 1920 -H 1080 -F nis -f -s 1 --expose-wayland --mangoapp -- "$@"
