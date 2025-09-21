#!/usr/bin/env bash

# File: idle-inhibit.sh
# Description: Manages an idle inhibition session using systemd-inhibit

INHIBIT_PID_FILE="/tmp/idle-inhibit.pid"

start_inhibit() {
  if [ -f "$INHIBIT_PID_FILE" ] && kill -0 "$(cat "$INHIBIT_PID_FILE")" 2>/dev/null; then
    echo "Inhibit already active (PID: $(cat "$INHIBIT_PID_FILE"))"
    exit 1
  fi

  systemd-inhibit --what=idle --who="IdleInhibitor" --why="Prevent idle during app usage" \
    bash -c 'while true; do sleep 60; done' &

  echo $! >"$INHIBIT_PID_FILE"
  echo "Inhibition started (PID: $!)"
}

stop_inhibit() {
  if [ -f "$INHIBIT_PID_FILE" ]; then
    PID=$(cat "$INHIBIT_PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
      kill "$PID"
      echo "Inhibition stopped (PID: $PID)"
    else
      echo "No running process found for PID $PID"
    fi
    rm -f "$INHIBIT_PID_FILE"
  else
    echo "No active inhibition found."
  fi
}

toggle_inhibit() {
  if [ -f "$INHIBIT_PID_FILE" ] && kill -0 "$(cat "$INHIBIT_PID_FILE")" 2>/dev/null; then
    stop_inhibit
  else
    start_inhibit
  fi
  eww poll my-bar-idle-value
}

status_inhibit() {
  if [ -f "$INHIBIT_PID_FILE" ] && kill -0 "$(cat "$INHIBIT_PID_FILE")" 2>/dev/null; then
    echo "active"
  else
    echo "inactive"
  fi
}

case "$1" in
start)
  start_inhibit
  ;;
stop)
  stop_inhibit
  ;;
toggle)
  toggle_inhibit
  ;;
status)
  status_inhibit
  ;;
*)
  echo "Usage: $0 {start|stop|toggle|status}"
  ;;
esac
