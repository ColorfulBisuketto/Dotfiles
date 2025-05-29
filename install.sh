#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

configured_packages=("cava" "fastfetch" "hypr" "kitty" "nvim" "qt5ct" "qt6ct" "rofi" "starship.toml" "swaync" "uwsm" "waybar" "yazi")

[ ! -d "$XDG_CONFIG_HOME.bak/" ] && mkdir "$XDG_CONFIG_HOME.bak/"

for pack in ${configured_packages[@]}; do
  mv -iv "$XDG_CONFIG_HOME/$pack/" "$XDG_CONFIG_HOME.bak/$pack/"
  cp -r "$SCRIPT_DIR/.config/$pack/" "$XDG_CONFIG_HOME/"
done

#TODO: set location interactively.
