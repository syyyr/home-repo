#!/bin/bash
"$HOME/apps/check-available.bash" light python || exit 1

case "$1" in
    # The rates at which changes happen aren't the same, the increasing is slower. I don't mind however, as increasing is
    # potentially more irritating to the eye.
    increase)
        light -T 1.5
        echo "Raising brightness."
        ;;
    decrease)
        light -T 0.7
        echo "Lowering brightness."
        ;;
    max)
        light -S 100
        ;;
    min)
        light -S 1 # using 1, otherwise T440s just turns off the screen completely
        ;;
    *)
        ;;
esac

BRIGHT="$(light | python -c "print(round(float(input())))")" # Python rounds the output

echo "Brightness: $BRIGHT"%

BRIGHTNESS_IMG="$HOME/.local/share/icons/blue/brightness.png"
ARGS=( -t 2000 -h string:x-canonical-private-synchronous:brightness -i "$BRIGHTNESS_IMG" )
notify-send "${ARGS[@]}" 'Brightness' "$BRIGHT"%
