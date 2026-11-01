#!/usr/bin/env bash

# Simple stow wrapper to install all packages under ./pkg to ~/

set -e
set -u
set -o pipefail
set -o noclobber

# --- # --- # --- #

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PACKAGE_DIR="$ROOT_DIR/pkg"
PACKAGES="$(basename -a $PACKAGE_DIR/*)"

# --- # --- # --- #

stow -t ~/ -d $PACKAGE_DIR -S $PACKAGES $@

