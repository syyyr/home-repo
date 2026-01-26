#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if [[ "$(cat '/sys/devices/pci0000:00/0000:00:02.3/0000:03:00.0/ieee80211/phy0/rfkill2/soft')" != 1 ]]; then
    exit 0
fi

echo "[\?color=red&show RFKILL]"
