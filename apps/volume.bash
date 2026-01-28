#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if [[ $# -gt 0 ]]; then
    case "$1" in
        increase)
            pamixer --allow-boost --increase "$2"
            echo "Raising volume."
            ;;
        decrease)
            pamixer --allow-boost --decrease "$2"
            echo "Lowering volume."
            ;;
        toggle)
            pamixer --toggle-mute
            echo "Toggling mute."
            ;;
        *)
            ;;
    esac
fi


py3-cmd refresh volume_status

VOLUME_HIGH="$HOME/.local/share/icons/blue/volume-high.png"
VOLUME_MEDIUM="$HOME/.local/share/icons/blue/volume-medium.png"
VOLUME_LOW="$HOME/.local/share/icons/blue/volume-low.png"
VOLUME_MUTE="$HOME/.local/share/icons/blue/volume-mute.png"

VOL="$(pamixer --get-volume)%"

VOLUME_IMG="$VOLUME_LOW"
MUTED=""
if [[ "$(pamixer --get-mute)" != "false" ]]; then
    MUTED=" (muted)"
    VOLUME_IMG="$VOLUME_MUTE"
elif [[ "${VOL//%}" -ge "66" ]];then
    VOLUME_IMG="$VOLUME_HIGH"
elif [[ "${VOL//%}" -ge "33" ]];then
    VOLUME_IMG="$VOLUME_MEDIUM"
fi

echo "Volume: $VOL${MUTED}"
ID_FILE="$HOME/.cache/volume-id"
if [[ -f "$ID_FILE" ]]; then
    ID="$(cat "$ID_FILE" 2> /dev/null || true)"
fi
ARGS=( --expire-time 2000 --icon "$VOLUME_IMG" --print-id --replace-id "${ID:-0}")
ID="$(notify-send "${ARGS[@]}" "Volume" "$VOL")"
echo "$ID" > ~/.cache/volume-id
