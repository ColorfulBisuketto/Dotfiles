#!/usr/bin/env bash

direction=$1
eww=$2

brightness=$(brightnessctl g)

if [[ $direction == "up" ]]; then
  if (($brightness >= 96000)); then
    exit
  fi
  brightnessctl s "+5%" >/dev/null
else
  if (($brightness < 5000)); then
    exit
  fi
  brightnessctl s "5%-" >/dev/null
fi

$eww poll brightness-value
