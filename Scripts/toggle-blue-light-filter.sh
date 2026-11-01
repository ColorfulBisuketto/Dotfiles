#!/usr/bin/env bash

IDENTITY=6000 # see hyprsunset wiki
CURRENT="$(hyprctl hyprsunset temperature)"

if [[ $CURRENT != $IDENTITY ]]; then
  hyprctl hyprsunset temperature $IDENTITY
else
  hyprctl hyprsunset temperature 2500
fi
