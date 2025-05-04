#!/usr/bin/env bash

# Run playerctl and capture the output
output="$(playerctl metadata --format='{{title}}' 2>/dev/null)"

# Check if the output is empty or if we get "No players found"
if [[ -z $output ]]; then
    printf -- "Nothing is playing ... yet (owo)"
else
    printf -- "%s\n" "$output"
fi
