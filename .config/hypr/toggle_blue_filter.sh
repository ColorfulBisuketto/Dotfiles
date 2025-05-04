#!/usr/bin/env bash

temp_file="$XDG_CONFIG_HOME/hypr/blue_filter_state"

if [ ! -f "$temp_file" ]; then
    echo "off" > "$temp_file"
fi

read -r state < "$temp_file"
case $state in
    on)
	hyprctl hyprsunset temperature 6000
	echo "off" > "$temp_file"
	;;
    off)
	hyprctl hyprsunset temperature 2500
	echo "on" > "$temp_file"
	;;
    *)
	echo "An unexpected error has occurred."
	exit 1
	;;
esac
