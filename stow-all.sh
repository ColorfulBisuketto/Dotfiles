#!/usr/bin/env bash

# Simple stow wrapper to install all packages under ./pkg to ~/
# Made by Me (https://github.com/ColorfulBisuketto)

set -e
set -o pipefail
set -o noclobber

# --- # --- # --- #

# The first argument must be the action.
# The default action is to install all the packages.
ACTION=${1:-"-S"}
[[ -n $1 ]] && shift

# --- # --- # --- #

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PACKAGE_DIR="$ROOT_DIR/pkg"
PACKAGES="$(basename -a $PACKAGE_DIR/*)"

# --- # --- # --- #

# Other than the first argument all others are appended at the end, allowing for simulation when using '-S -n'
stow -t ~/ -d $PACKAGE_DIR $ACTION $PACKAGES $@

