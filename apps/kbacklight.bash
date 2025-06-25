#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

BRIGHTNESS_FILE='/sys/class/leds/tpacpi::kbd_backlight/brightness'

print_usage() {
    echo 'Usage: kbacklight 0|1|2'
}

if [[ $# != 1 ]]; then
    print_usage
    exit 1
fi

if [[ ! -f "$BRIGHTNESS_FILE" ]]; then
    echo "Brightness file doesn't exist! ($BRIGHTNESS_FILE)" >&2
    echo "Reload the acpi module." >&2
    notify-send "Kbacklight" "Brightness file doesn't exist! Reload the acpi module."
    exit 1
fi

case "$1" in
    0|1|2)
        echo -n "$1" > "$BRIGHTNESS_FILE"
        ;;
    *)
        print_usage
        exit 1
esac

