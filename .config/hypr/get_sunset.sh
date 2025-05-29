#!/usr/bin/env bash

# Import location
source ~/.config/hypr/sunset_location

# Sunset time in epoch timestamp
SUNSET=$(curl -s "https://api.sunrisesunset.io/json?lat=$lat&lng=$lng" | jq ".results.dusk" | xargs date "+%s" -d)

# 45 minutes before sunset.
echo $(date -d "@$(($SUNSET - 2700))" "+%H:%M:%S")
