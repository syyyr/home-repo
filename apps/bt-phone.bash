#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if bluetoothctl info | grep -o 'Connected: yes'; then
    bluetoothctl disconnect
else
    if [[ -z "$PHONE_BT_MAC" ]]; then
        echo '$PHONE_BT_MAC is not set, unable to connect to phone'.  >&2
        return 1
    fi
    bluetoothctl connect "$PHONE_BT_MAC"
fi

py3-cmd refresh bluetooth
