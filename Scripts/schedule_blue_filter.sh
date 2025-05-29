#!/usr/bin/env bash

SUNSET=$(get_sunset.sh)

systemd-run --user \
  --on-calendar="*-*-* ${SUNSET}" \
  --unit "blue_filter" \
  --description "Schedule the blue light filter to activate." \
  /usr/local/bin/set_blue_filter.sh
