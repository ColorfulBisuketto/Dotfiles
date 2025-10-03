#!/usr/bin/env bash

TEMP_FILE_LOCATION="/tmp/prev-hyprland-options"

# Define options to set
declare -A options
options["animations:enabled"]="0"
options["decoration:shadow:enabled"]="0"
options["decoration:blur:enabled"]="0"
options["general:gaps_in"]="0 0 0 0"
options["general:gaps_out"]="0 0 0 0"
options["general:border_size"]="1"
options["decoration:rounding"]="0"

if [ ! -r "$TEMP_FILE_LOCATION" ]; then
  printf '%s\n' "declare -A prev" >"$TEMP_FILE_LOCATION"
  for option in "${!options[@]}"; do
    prev="$(hyprctl getoption $option | awk -F ': ' 'NR==1{print $2}')"
    printf '%s\n' "prev[\"$option\"]=\"$prev\"" >>"$TEMP_FILE_LOCATION"
  done
  gamer_request=""
  for option in "${!options[@]}"; do
    gamer_request+="keyword $option ${options[$option]};"
  done
  hyprctl --batch "$gamer_request" >/dev/null && echo "ok"
  exit
else
  source "$TEMP_FILE_LOCATION"
  prev_request=""
  for option in "${!prev[@]}"; do
    prev_request+="keyword $option ${prev[$option]};"
  done
  hyprctl --batch "$prev_request" >/dev/null && echo "ok"
  rm "$TEMP_FILE_LOCATION"
  exit
fi
