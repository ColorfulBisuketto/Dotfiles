#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

configured_packages=("cava" "fastfetch" "hypr" "nvim" "uwsm" "yazi")

for pack in ${configured_packages[@]}; do
  rm -rf "$SCRIPT_DIR/.config/$pack/"
  cp -r "$XDG_CONFIG_HOME/$pack" "$SCRIPT_DIR/.config/"
done
