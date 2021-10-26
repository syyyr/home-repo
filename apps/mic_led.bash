#!/bin/bash

LED_FILE='/sys/class/leds/platform::micmute/brightness'

if pamixer --get-mute --source 1; then
    echo 1 > "$LED_FILE"
else
    echo 0 > "$LED_FILE"
fi
