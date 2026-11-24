#!/usr/bin/env bash
# vim: ts=2 sw=2 et

# Creates a udev rule that links the unredable driver path to a more readable one.
#
# Stolen pertially from 'https://wiki.hypr.land/configuring/extra/multi-gpu/#creating-consistent-device-paths-for-specific-cards'.
# Then turned into a script with some AI usage.

set -e
set -u
set -o pipefail
set -o noclobber

# --- # Check for permissions # --- #

UDEV_DIR="/etc/udev/rules.d"
if [ ! -w "$UDEV_DIR" ]; then
  echo "`tput setaf 1`$0: cannot create rule in '$UDEV_DIR': Permission denied`tput sgr0`" >&2
  exit 1
fi

# --- # Display controllers # --- #

mapfile -t CONTROLLERS < <(lspci -D -d ::03xx)

if ((${#CONTROLLERS[@]} == 0)); then
    echo "`tput setaf 1`No display controllers found.`tput sgr0`" >&2
    exit 1
fi

echo
for i in "${!CONTROLLERS[@]}"; do
    PCI=${CONTROLLERS[$i]%% *}
    DESC=${CONTROLLERS[$i]#* }

    echo "[$i]: $DESC ($PCI)"
done

# --- # Controller selection # --- #

read -r -p "Please select a controller: " SELECTION

if [[ $SELECTION =~ ^[0-9]+$ ]]; then
    SELECTION=$((10#$SELECTION))

    if ((SELECTION < ${#CONTROLLERS[@]})); then
        SELECTED_CONTROLLER=${CONTROLLERS[$SELECTION]}
        echo -e "\nSelected: ${SELECTED_CONTROLLER#* }"
    else
        echo -e "`tput setaf 1`\nInvalid selection.`tput sgr0`" >&2
        exit 1
    fi
else
    echo -e "`tput setaf 1`\nInvalid selection.`tput sgr0`" >&2
    exit 1
fi

# --- # Read driver name # --- #

while true; do
    read -r -p "Enter a readable driver name: " DRIVER_NAME

    if [[ $DRIVER_NAME =~ ^[a-zA-Z0-9_-]+$ ]] &&
       [[ $DRIVER_NAME != "." && $DRIVER_NAME != ".." ]] &&
       ((${#DRIVER_NAME} <= 20)); then
        break
    fi

    echo "`tput setaf 1`Invalid driver name. Use 1-20 letters, numbers, '_' and '-'.`tput sgr0`"
done

# --- # Generate rule # --- #

PCI="${SELECTED_CONTROLLER%% *}"
RULE_PATH="$UDEV_DIR/$DRIVER_NAME-dri-link.rules"
UDEV_RULE="KERNEL==\"card*\", KERNELS==\"$PCI\", SUBSYSTEM==\"drm\", SUBSYSTEMS==\"pci\", SYMLINK+=\"dri/$DRIVER_NAME\""

# --- # Confirmation # --- #

cat << EOF

About to write udev rule that will link the selected card to /dri/$DRIVER_NAME"
Rule content:
  $UDEV_RULE
Rule location:
  $RULE_PATH
EOF
read -r -n 1 -p "`tput setaf 3`Continue? [y/N]: `tput sgr0`" confirm

if [[ $confirm != [yY] ]]; then
    exit 0
fi
echo -e "\n"

# --- # Write rule # --- #

echo -e "$UDEV_RULE\n" > "$RULE_PATH"

echo "`tput setaf 2`Created udev rule: $RULE_PATH ✓ `tput sgr0`"

