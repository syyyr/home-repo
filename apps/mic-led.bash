#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

LED_FILE='/sys/class/leds/platform::micmute/brightness'

if [[ "$(pamixer --get-mute --default-source)" = "true" ]]; then
    echo 1 > "$LED_FILE"
else
    echo 0 > "$LED_FILE"
fi
