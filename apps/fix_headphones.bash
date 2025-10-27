#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

pbpctrl set multipoint false
bluetoothctl disconnect
pbpctrl show battery
pbpctrl set multipoint true
