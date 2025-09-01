#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if pgrep -f 'fix_headphones.bash' &> /dev/null; then
	echo -n '[\?color=plum&show Fixing headphones…]'
	exit 0
fi

if ! bluetoothctl devices Connected | grep 'Pixel Buds Pro' &> /dev/null; then
	echo ""
	exit 0
fi

BATTERY_INFO="$(pbpctrl show battery)"

LEFT="$(grep "left bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"
if [[ -n "${LEFT}" ]]; then
	LEFT="[\?color=lightblue&show L: ${LEFT}%]"
fi

CASE="$(grep "case:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"

if [[ -n "${CASE}" ]]; then
	CASE=" [\?color=lightblue&show Case: ${CASE}%] "
else
	CASE=" "
fi

RIGHT="$(grep "right bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"

if [[ -n "${RIGHT}" ]]; then
	RIGHT="[\?color=lightblue&show R: ${RIGHT}%]"
fi

ANC="$(pbpctrl get anc)"

if [[ "$ANC" = active ]]; then
	ANC=" [\?color=lightblue&show ANC]"
else
	ANC=""
fi

if ! pactl list | grep -F 'High Fidelity Playback (A2DP Sink,' &> /dev/null; then
	A2DP=" [\?color=salmon&show A2DP unavailable!]"
else
	A2DP=""
fi

echo -n "${LEFT}${CASE}${RIGHT}${ANC}${A2DP}"

