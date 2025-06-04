#!/usr/bin/env bash

SUNTIMES=$(get_sunset.sh)

SUNRISE=$(echo $SUNTIMES | jq '.["results"].["sunrise"]' | xargs date "+%H:%M:%S" -d)
SUNSET=$(echo $SUNTIMES | jq '.["results"].["golden_hour"]' | xargs date "+%H:%M:%S" -d)

SUNRISE_EPOCH=$(date --date "$SUNRISE" "+%s")
SUNSET_EPOCH=$(date --date "$SUNSET" "+%s")
CURRENT_EPOCH=$(date "+%s")

if [[ $CURRENT_EPOCH -le $SUNRISE_EPOCH || $CURRENT_EPOCH -ge $SUNSET_EPOCH ]]; then
  set_blue_filter.sh
fi

systemd-run --user \
  --on-calendar="*-*-* ${SUNSET}" \
  --unit "set_blue_filter" \
  --description "Schedule the blue light filter to activate." \
  /usr/local/bin/set_blue_filter.sh

systemd-run --user \
  --on-calendar="*-*-* ${SUNRISE}" \
  --unit "unset_blue_filter" \
  --description "Schedule the blue light filter to de-activate." \
  /usr/local/bin/unset_blue_filter.sh
