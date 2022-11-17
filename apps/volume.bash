#!/bin/bash
"$HOME/apps/check-available.bash" pamixer || exit 1

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

py3-cmd refresh volume_status

VOLUME_HIGH="$HOME/.local/share/icons/blue/volume-high.png"
VOLUME_MEDIUM="$HOME/.local/share/icons/blue/volume-medium.png"
VOLUME_LOW="$HOME/.local/share/icons/blue/volume-low.png"
VOLUME_MUTE="$HOME/.local/share/icons/blue/volume-mute.png"

VOL="$(pamixer --get-volume)%"

VOLUME_IMG="$VOLUME_LOW"
if [[ "$(pamixer --get-mute)" != "false" ]]; then
    MUTED="(muted)"
    VOLUME_IMG="$VOLUME_MUTE"
elif [[ "${VOL//%}" -ge "66" ]];then
    VOLUME_IMG="$VOLUME_HIGH"
elif [[ "${VOL//%}" -ge "33" ]];then
    VOLUME_IMG="$VOLUME_MEDIUM"
fi

echo "Volume: $VOL $MUTED"
ARGS=( -t 2000 -h string:x-canonical-private-synchronous:volume -i "$VOLUME_IMG" )
notify-send "${ARGS[@]}" "Volume" "$VOL"
