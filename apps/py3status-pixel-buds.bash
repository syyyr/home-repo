#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if ! bluetoothctl devices Connected | grep 'Pixel Buds Pro' &> /dev/null; then
	echo ""
	exit 0
fi

BATTERY_INFO="$(pbpctrl show battery)"

LEFT="$(grep "left bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"
if [[ -n "${LEFT}" ]]; then
	LEFT="[\?color=lightblue&show L: ${LEFT}%]"
fi

RIGHT="$(grep "right bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"

if [[ -n "${RIGHT}" ]]; then
	RIGHT="[\?color=lightblue&show R: ${RIGHT}%]"
fi

ANC="$(pbpctrl get anc)"

if [[ "$ANC" = active ]]; then
	ANC="[\?color=lightblue&show ANC]"
else
	ANC=""
fi

echo -n "$LEFT $RIGHT $ANC"

