#!/usr/bin/env bash

CURRENT_BRIGHTNESS=$((($(brightnessctl g) * 100) / $(brightnessctl m)))

# internal display
LOW_PERCENT=20
HIGHT_PERCENT=75

bright() {
  ddcutil setvcp 10 50 12 50
  brightnessctl s "$HIGHT_PERCENT%" >/dev/null
}

dark() {
  ddcutil setvcp 10 0 12 0
  brightnessctl s "$LOW_PERCENT%" >/dev/null
}

toggle() {
  if [[ CURRENT_BRIGHTNESS -eq LOW_PERCENT ]]; then
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
