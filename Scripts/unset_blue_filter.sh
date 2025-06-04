#!/usr/bin/env bash
set -e

ACTIVE_TEMP=2000
INACTIVE_TEMP=6000

for ((i = $ACTIVE_TEMP; i <= $INACTIVE_TEMP; i = i + 10)); do
  hyprctl hyprsunset temperature $i 1>/dev/null
  sleep "$((1 / i))"
done
