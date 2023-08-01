#!/bin/bash
"$HOME/apps/check-available.bash" brightnessctl python || exit 1

case "$1" in
    increase)
        brightnessctl --exponent set +10%
        echo "Raising brightness."
        ;;
    decrease)
        brightnessctl --exponent set 10%-
        echo "Lowering brightness."
        ;;
    max)
        brightnessctl --exponent set 255
        ;;
    min)
        brightnessctl --exponent set 0
        ;;
    *)
        ;;
esac

BRIGHT="$(brightnessctl --exponent --machine-readable info | cut -d',' -f 4)"

echo "Brightness: $BRIGHT"

BRIGHTNESS_IMG="$HOME/.local/share/icons/blue/brightness.png"
ARGS=( -t 2000 -h string:x-canonical-private-synchronous:brightness -i "$BRIGHTNESS_IMG" )
notify-send "${ARGS[@]}" 'Brightness' "$BRIGHT"
