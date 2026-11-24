#!/usr/bin/env bash
# Made by Me (https://github.com/ColorfulBisuketto)

IDENTITY=6000 # see hyprsunset wiki
CURRENT="$(hyprctl hyprsunset temperature)"

if [[ $CURRENT != $IDENTITY ]]; then
  hyprctl hyprsunset temperature $IDENTITY
else
  hyprctl hyprsunset temperature 2500
fi
