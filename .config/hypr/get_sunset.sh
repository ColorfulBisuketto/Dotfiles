#!/usr/bin/env bash

SUNSET=$(curl -s 'https://api.sunrisesunset.io/json?lat=49.1625434&lng=8.0349548' | jq '.results.dusk' | xargs date "+%H:%M:%S" -d)

echo "*-*-* $SUNSET"
