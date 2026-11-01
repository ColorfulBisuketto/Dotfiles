#!/usr/bin/env bash

# Creates symbolic links for the scripts found under ./Scripts to ~/.local/bin

set -e
set -u
set -o pipefail
set -o noclobber

# --- # --- # --- #

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SCRIPTS="$ROOT_DIR/Scripts/*"

no_action=0
install_dir=~/.local/bin

# --- # --- # --- #

HELP_TEXT=$(cat <<EOF
Usage: $0 [OPTION]...
Link scripts from '$ROOT_DIR/Scripts' to '$install_dir'

Options:
  -h       Show this help message.
  -n       Dry run. Don't actually do anything.
  -d <DIR> Set the install directory to <DIR>. 
           Defaults to '$install_dir'.
EOF
)

# --- # --- # --- #

getOptions() {
  while getopts "hnd:" opt; do
    case "$opt" in
      h) echo "$HELP_TEXT"; exit 0 ;;
      n) no_action=1 ;;
      d) install_dir=$(realpath "$OPTARG") ;;
      *) exit 1 ;;
    esac
  done
  
  shift $(( OPTIND - 1 ))
}

# --- # --- # --- #

destinationError() {
  if [[ $no_action -ne 0 ]]; then
    echo "ERROR: cannot install scripts to '$install_dir' ($1)" >&2
    return
  fi
  echo "ERROR: could not install scripts to '$install_dir' ($1)" >&2
  exit 1
}

testWriteExecute() {
  if [[ ! -e "$install_dir" ]]; then
    destinationError "Direcory doesn't exist"
  fi
  if [[ ! -d "$install_dir" ]]; then
    destinationError "Not a directory"
  fi
  if [[ ! -w "$install_dir" || ! -x "$install_dir" ]]; then
    destinationError "Permission denied"
  fi
}

# --- # --- # --- #

linkScripts() {
  if [[ $no_action -ne 0 ]]; then
    echo "Would have linked scripts to '$install_dir'"
    return
  fi
  echo "Linking scripts to '$install_dir'..."
  ln -s $SCRIPTS $install_dir
}

# --- # --- # --- #

main() {
  getOptions "$@"
  testWriteExecute
  linkScripts
}

main "$@"

exit 0
