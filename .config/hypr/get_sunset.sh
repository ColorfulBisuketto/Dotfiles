#!/usr/bin/env bash

# Import location
if [[ ! -f ~/.config/hypr/sunset_location ]]; then
  echo "lat=" >~/.config/hypr/sunset_location
  echo "lng=" >>~/.config/hypr/sunset_location
fi
source ~/.config/hypr/sunset_location
if [[ -z $lat || -z $lng ]]; then
  echo "Location is not set."
  echo "please set the latitude and longitude for your location."
  exit 1
fi

# Sunset time in epoch timestamp
SUNSET=$(curl -s "https://api.sunrisesunset.io/json?lat=$lat&lng=$lng" | jq ".results.dusk" | xargs date "+%s" -d)

# 45 minutes before sunset.
echo $(date -d "@$(($SUNSET - 2700))" "+%H:%M:%S")
