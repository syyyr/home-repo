#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if ! [[ -v BT_HEADPHONES_MAC ]]; then
    echo BT_HEADPHONES_MAC not set.
    exit 1
fi

echo Listening to disconnects on "${BT_HEADPHONES_MAC@Q}".

# There is no 'noop' command for bluetoothctl and there's no way to run it to just get the events. `version` spits out
# one line. Should be stable enough.
bluetoothctl --timeout=99999999 -- version |& stdbuf -i 0 -o 0 -e 0 ansi2txt | stdbuf -i 0 -o 0 -e 0 tr '\r' '\n'| while read -r LINE; do
    echo "bluetoothctl: '${LINE}'"
    if [[ "$LINE" =~ \[CHG\]\ Device\ ${BT_HEADPHONES_MAC}\ Connected:\ (yes|no) ]]; then
        CONNECTION_STATUS="${BASH_REMATCH[1]}"
        echo "New connection status: ${CONNECTION_STATUS}"
        if [[ "${CONNECTION_STATUS}" = no ]]; then
            echo -n Stopping music...
            playerctl stop &> /dev/null || true
            echo " done."
        fi
        sleep 2
        py3-cmd refresh 'external_script pixel-buds'
        py3-cmd refresh bluetooth
    fi
done
