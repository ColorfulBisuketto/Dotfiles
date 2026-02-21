#!/usr/bin/env bash

trap 'sudo -k' EXIT
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SOURCE_DIR="$SCRIPT_DIR/Scripts"
TARGET_DIR=/usr/local/bin

[[ "$EUID" == 0 ]] || exec sudo -s "$0" "$@"

for script_path in "$SOURCE_DIR"/*; do
  if [[ ! -x "$script_path" ]]; then
    echo "'$script_path' is not executable. Skipping." && continue
  fi

  script_name=$(basename "$script_path")
  ln --symbolic "$script_path" "$TARGET_DIR/$script_name"
done

exit 0
