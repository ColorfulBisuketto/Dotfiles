#!/usr/bin/env bash

RSSI=$(nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $10}}')
STATE=$(nmcli -g STATE g)

echo "{ \"State\": \"$STATE\", \"RSSI\": \"$RSSI\" }"
