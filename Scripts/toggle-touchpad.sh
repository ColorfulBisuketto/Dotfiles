#!/bin/sh
HYPRLAND_DEVICE="${1:-asup1205:00-093a:2003-touchpad}"
STATUS_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/touchpad.status"
enable_touchpad() {
  printf "true" >"$STATUS_FILE"
  notify-send -u low "Touchpad Enabled" --transient
  hyprctl eval "hl.device({ name = \"$HYPRLAND_DEVICE\", enabled = true })"
}
disable_touchpad() {
  printf "false" >"$STATUS_FILE"
  notify-send -u low "Touchpad Disabled" --transient
  hyprctl eval "hl.device({ name = \"$HYPRLAND_DEVICE\", enabled = false })"
}
if [ ! -f "$STATUS_FILE" ] || [ "$(cat "$STATUS_FILE")" = "false" ]; then
  enable_touchpad
else
  disable_touchpad
fi
