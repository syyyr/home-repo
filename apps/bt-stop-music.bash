#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ "${BT_HEADPHONES_MAC+x}" != x ]]; then
	echo BT_HEADPHONES_MAC not set.
	exit 1
fi

echo Listening to disconnects on "${BT_HEADPHONES_MAC@Q}".

# There is no 'noop' command for bluetoothctl and there's no way to run it to just get the events. `version` spits out
# one line. Should be stable enough.
bluetoothctl --timeout=99999999 -- version |& stdbuf -i 0 -o 0 -e 0 ansi2txt | stdbuf -i 0 -o 0 -e 0 tr '\r' '\n'| while read -r LINE; do
	echo "bluetoothctl: '${LINE}'"
	if [[ "$LINE" != "[CHG] Device ${BT_HEADPHONES_MAC} Connected: no" ]]; then
		continue
	fi

	echo -n Stopping music...
	playerctl stop
	echo " done."
done
