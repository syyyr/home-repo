#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

pbpctrl set multipoint false
bluetoothctl disconnect
pbpctrl show battery
pbpctrl set multipoint true
