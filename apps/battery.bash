#!/bin/bash
THRESHOLD=10
export DISPLAY=":0"
"$HOME/apps/check_available.bash" ffplay || exit 1

if ! (acpi -a | grep "off-line" > /dev/null); then
    echo 'Battery is being charged.'
    exit 0
fi
BATTERY_LEVEL=$(acpi | grep -oE "[0-9]+%" | sed 's/%//')
# This makes in line with i3bar
VISIBLE_BATTERY_LEVEL=$((BATTERY_LEVEL + 1))
if [[ "$BATTERY_LEVEL" -le "$THRESHOLD" ]]; then
    echo 'Battery is low.'
    KEYBOARD_IMG="$HOME/.local/share/icons/blue/battery-low.png"
    ARGS='-u critical -t 5000 -h string:x-canonical-private-synchronous:kbacklight'
    ARGS+=" -i $KEYBOARD_IMG"
    notify-send $ARGS 'Battery low' "$BATTERY_LEVEL%"
    ffplay ~/.local/share/notification.mp3 -nodisp -autoexit
fi

