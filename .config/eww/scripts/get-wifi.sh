#!/usr/bin/env bash

result=$(iwctl station wlan0 show | awk '/ +(State|RSSI)/ {printf "\"%s\": \"%s\", ", $1, $2}')

if [[ -z $result ]]; then
  echo '{"State": "disconnected", "RSSI": "-99"}'
else
  echo "{${result::-2}}"
fi
