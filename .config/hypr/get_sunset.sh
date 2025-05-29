#!/usr/bin/env bash

# Sunset time in epoch timestamp
SUNSET=$(curl -s 'https://api.sunrisesunset.io/json?lat=49.1625434&lng=8.0349548' | jq '.results.dusk' | xargs date "+%s" -d)

echo $(date -d "@$(($SUNSET - 2700))" "+%H:%M:%S")
