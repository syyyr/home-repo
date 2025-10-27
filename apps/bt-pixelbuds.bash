#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if bluetoothctl devices Connected | grep 'Pixel Buds Pro' &> /dev/null; then
    bluetoothctl disconnect
else
    pbpctrl show battery
fi

py3-cmd refresh bluetooth
py3-cmd refresh 'external_script pixel-buds'
