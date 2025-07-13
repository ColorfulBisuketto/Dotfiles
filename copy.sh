#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

configured_packages=("cava" "fastfetch" "hypr" "kitty" "nvim" "qt5ct" "qt6ct" "rofi" "starship.toml" "swaync" "uwsm" "yazi" "custom-scripts" "eww" "btop" "qBittorrent" "starship.toml")

for pack in ${configured_packages[@]}; do
  rm -rf "$SCRIPT_DIR/.config/$pack/"
  cp -r "$XDG_CONFIG_HOME/$pack" "$SCRIPT_DIR/.config/"
done
