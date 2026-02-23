#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

pbpctrl set multipoint false
bluetoothctl disconnect
pbpctrl show battery
pbpctrl set multipoint true
sleep 1
py3-cmd refresh 'external_script pixel-buds'
