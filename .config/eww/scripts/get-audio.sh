#!/usr/bin/env bash

vol=$(pactl -f json get-sink-volume @DEFAULT_SINK@ | sed -n -r 's/.*?( [0-9]+%).*/\1/p')

mute=$(pactl -f json get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [[ $mute == "yes" ]]; then
  mute_bool=true
else
  mute_bool=false
fi

echo "{\"Volume\": \"${vol:1:-1}\", \"Mute\": $mute_bool }"
