#!/usr/bin/env bash

CURRENT_BRIGHTNESS_PERCENT=$((($(brightnessctl g) * 100) / $(brightnessctl m)))

# internal display
LOW_PERCENT_INTERNAL=25
HIGH_PERCENT_INTERNAL=75

# vcp options for readability
BRIGHTNESS=10
CONTRAST=12

bright() {
  ddcutil setvcp $BRIGHTNESS 50 $CONTRAST 50
  brightnessctl s "$HIGH_PERCENT_INTERNAL%" >/dev/null
}

dark() {
  ddcutil setvcp $BRIGHTNESS 0 $CONTRAST 0
  brightnessctl s "$LOW_PERCENT_INTERNAL%" >/dev/null
}

toggle() {
  if [[ CURRENT_BRIGHTNESS_PERCENT -eq LOW_PERCENT_INTERNAL ]]; then
    bright
  else
    dark
  fi
}

case "$1" in
"toggle" | "")
  toggle
  ;;
"bright")
  bright
  ;;
"dark")
  dark
  ;;
"--help" | *)
  echo "Usage: [ toggle | bright | dark ] Default: toggle"
  ;;
esac
