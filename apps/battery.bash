#!/bin/bash
THRESHOLD=10

if ! (acpi -a | grep "off-line" > /dev/null); then
    exit 0
fi
BATTERY_LEVEL=$(acpi | grep -oE "[0-9]+%" | sed 's/%//')
if [[ "$BATTERY_LEVEL" -le "$THRESHOLD" ]]; then
    echo 'Battery is low.'
    KEYBOARD_IMG="$HOME/.local/share/icons/blue/battery-low.png"
    ARGS='-t 5000 -h string:x-canonical-private-synchronous:kbacklight'
    ARGS+=" -i $KEYBOARD_IMG"
    notify-send $ARGS 'Battery low' "$BATTERY_LEVEL%"
fi

