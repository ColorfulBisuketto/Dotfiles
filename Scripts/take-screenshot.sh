#!/usr/bin/env bash

DATE=$(date +'%Y%m%d-%H:%M:%S.png')
IMAGE="$HOME/Pictures/Screenshots/$DATE"

case "$1" in
"area")
  grim -c -l 3 -g "$(slurp -w 0)" "$IMAGE"
  ;;
"screen")
  grim -c -l 3 -o "$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')" "$IMAGE"
  ;;
*)
  print "Error wrong arguments. Use 'area' or 'screen'"
  exit
  ;;
esac

# Handle actions for the notification
handle_action() {
  case "$1" in
  "view")
    uwsm app -- xdg-open "$IMAGE"
    ;;
  "folder")
    uwsm app -- xdg-open "$HOME/Pictures/Screenshots/"
    ;;
  "delete")
    gio trash "$IMAGE"
    ;;
  *) ;;
  esac
}

# Take a screenshot of the currently active screen

wl-copy <"$IMAGE"

ACTION=$(notify-send -i "$IMAGE" \
  -t 3000 \
  "Screenshot taken" \
  "$DATE" \
  --wait \
  --action "view=View" \
  --action "folder=Open Folder" \
  --action "delete=Delete")

handle_action "$ACTION"
