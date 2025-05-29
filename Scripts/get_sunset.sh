#!/usr/bin/env bash

# Config File
CONFIG="$XDG_CONFIG_HOME/custom-scripts/sunset_location"

# Import location
if [[ ! -f $CONFIG ]]; then
  echo "lat=" >$CONFIG
  echo "lng=" >>$CONFIG
fi
source $CONFIG
if [[ -z $lat || -z $lng ]]; then
  echo "Location is not set."
  echo "please set the latitude and longitude for your location."
  exit 1
fi

# Sunset time in epoch timestamp
SUNSET=$(curl -s "https://api.sunrisesunset.io/json?lat=$lat&lng=$lng" | jq ".results.dusk" | xargs date "+%s" -d)

# 45 minutes before sunset.
echo $(date -d "@$(($SUNSET - 2700))" "+%H:%M:%S")
