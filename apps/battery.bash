#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

THRESHOLD=10

if systemd-ac-power; then
    echo 'Battery is being charged.'
    exit 0
fi
BATTERY_LEVEL=$(acpi | grep -oE "[0-9]+%" | sed 's/%//')
if [[ "$BATTERY_LEVEL" -le "$THRESHOLD" ]]; then
    echo 'Battery is low.'
    KEYBOARD_IMG="$HOME/.local/share/icons/blue/battery-low.png"
    ARGS=( -u critical -t 5000 -h string:x-canonical-private-synchronous:kbacklight )
    ARGS+=( -i "$KEYBOARD_IMG" )
    notify-send "${ARGS[@]}" 'Battery low' "$BATTERY_LEVEL%"
    "$HOME/apps/play-not-sound.bash"
fi

