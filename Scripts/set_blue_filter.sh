#!/usr/bin/env bash
set -e

ACTIVE_TEMP=2000
INACTIVE_TEMP=6000

for ((i = $INACTIVE_TEMP; i >= $ACTIVE_TEMP; i = i - 10)); do
  hyprctl hyprsunset temperature $i 1>/dev/null
  sleep "$((1 / (INACTIVE_TEMP - i + 1)))"
done
