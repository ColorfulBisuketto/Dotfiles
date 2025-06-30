#!/usr/bin/env bash

direction=$1
eww=$2

if [[ $direction == "up" ]]; then
  pactl set-sink-volume 0 +5%
else
  pactl set-sink-volume 0 -5%
fi

$eww poll audio-value
