#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

configured_packages=("cava" "fastfetch" "hypr" "kitty" "nvim" "qt5ct" "qt6ct" "rofi" "starship.toml" "swaync" "uwsm" "waybar" "yazi" "custom-scripts")

# set location interactively
while true; do
  printf "\nPlease enter the coordinates for your location. (as a float, eg. 49.000)\n"
  read -rp "Longitude: " lng
  read -rp "Latitude: " lat
  printf "coordinates are: lng=$lng, lat=$lat."
  read -s -n 1 -p "is this correct? [Y/n]" confirm
  if [[ -z $confirm || $confirm =~ "[yY]" ]]; then
    printf "\n\nsuccess"
    break
  fi
done

[ ! -d "$XDG_CONFIG_HOME.bak/" ] && mkdir "$XDG_CONFIG_HOME.bak/"

# install configs
for pack in ${configured_packages[@]}; do
  mv -fiv "$XDG_CONFIG_HOME/$pack/" "$XDG_CONFIG_HOME.bak/$pack/"
  cp -r "$SCRIPT_DIR/.config/$pack/" "$XDG_CONFIG_HOME/"
done
echo "lat=$lat" >"$XDG_CONFIG_HOME/custom-scripts/sunset_location"
echo "lng=$lng" >>"$XDG_CONFIG_HOME/custom-scripts/sunset_location"

# install scripts
cp -fi "$SCRIPT_DIR/Scripts/*" /usr/local/bin/

# install themes
cp -r "$SCRIPT_DIR/.local/share/*" "$XDG_DATA_HOME/"
