#!/bin/bash

LED_FILE='/sys/class/leds/platform::micmute/brightness'

if pamixer --get-mute --source 'alsa_input.pci-0000_05_00.6.HiFi__hw_acp__source'; then
    echo 1 > "$LED_FILE"
else
    echo 0 > "$LED_FILE"
fi
