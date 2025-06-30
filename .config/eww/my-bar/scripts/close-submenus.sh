#!/usr/bin/env bash
set -e

eww active-windows | awk '/^(my-bar-[a-zA-Z\-]+).*/ {printf "\"%s\" ", $2}' | xargs eww close

exit 0
