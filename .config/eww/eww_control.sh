#!/usr/bin/env bash

CONFIG_DIR="$XDG_CONFIG_HOME/eww"

args=("$@")
COMMAND="${args[0]}"
EWW_CONFIG="${args[1]}"
EWW_WINDOWS="${args[@]:2}"

#echo "Command: $COMMAND"
#echo "Config: $EWW_CONFIG"
#echo "Windows: $EWW_WINDOWS"
#exit

missing() {
  echo "Missing arguments please see 'eww_control help'"
  exit
}

if [[ ! $(pidof eww) ]]; then
  eww daemon
  sleep 1
fi

if [[ -z "$EWW_WINDOWS" ]]; then
  EWW_WINDOWS="$EWW_CONFIG"
fi

case "$COMMAND" in
"help")
  echo "Usage:  eww_control <command> <config_folder> [<windows>...]"
  echo "Commands:"
  echo ""
  echo "    help      : Show this message"
  echo "    kill      : kill the daemon for a given config"
  echo "    close     : close windows"
  echo "    close-all : close all windows"
  echo "    open      : open windows"
  echo "    logs      : show logs"
  exit
  ;;
"kill")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" kill
  ;;
"reload")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" reload
  ;;

"close")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" close $EWW_WINDOWS
  ;;
"close-all")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" close-all
  ;;
"open")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" open-many $EWW_WINDOWS
  ;;
"logs")
  if [[ -z "$EWW_CONFIG" ]]; then
    missing
  fi
  eww --config "$CONFIG_DIR/$EWW_CONFIG/" logs
  ;;

*)
  echo "Unknown command please use 'eww_control help'"
  exit
  ;;
esac
