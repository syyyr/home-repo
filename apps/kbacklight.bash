#!/bin/bash
set -eu

BRIGHTNESS_FILE='/sys/class/leds/tpacpi::kbd_backlight/brightness'

print_usage() {
    echo 'Usage: kbacklight 0|1|2'
}

if [[ $# != 1 ]]; then
    print_usage
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

