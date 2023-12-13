#!/bin/bash
"$HOME/apps/check-available.bash" i3lock dunstctl xrandr xset || exit 1

get_muted()
{
    if "$HOME/apps/volume.bash" | grep muted; then
        echo 1
        return 1
    else
        echo 0
        return 0
    fi
}

"$HOME/apps/kbacklight.bash" 0
# TODO: if you take out headphones, the speakers get unumuted
MUTED_BEFORE=$(get_muted)

if [[ $MUTED_BEFORE = 0 ]]; then
    "$HOME/apps/volume.bash" toggle
fi

if [[ "$1" != "no-off" ]]; then
    (sleep 7; xset dpms force off)&
    SCREENOFF_PID="$!"
fi

if xrandr | grep primary | grep -F "1920x1080" > /dev/null; then
    IMAGE_FILE="$HOME/.local/share/win10-lock-1080p.png"
    TIME_SIZE=130
    DATE_SIZE=59
    TIME_POS=80:913
    DATE_POS=80:ty+80
else
    IMAGE_FILE="$HOME/.local/share/win10-lock-4k.png"
    TIME_SIZE=260
    DATE_SIZE=118
    TIME_POS=160:1826
    DATE_POS=160:ty+160
fi

dunstctl set-paused true
i3-msg bar mode invisible
i3lock \
    --nofork \
    --clock \
    --image="$IMAGE_FILE" \
    --color=000000 \
    --time-font=Segoeui \
    --date-font=Segoeui \
    --date-color=FFFFFF \
    --time-color=FFFFFF \
    --date-align=1 \
    --time-align=1 \
    --time-str="%H:%M" \
    --date-str="%A, %d. %B" \
    --time-size="$TIME_SIZE" \
    --date-size="$DATE_SIZE" \
    --time-pos="$TIME_POS" \
    --date-pos="$DATE_POS"

dunstctl set-paused false
i3-msg bar mode dock

if [[ "$1" != "no-off" ]]; then
    kill "$SCREENOFF_PID" 2> /dev/null
fi

MUTED_NOW=$(get_muted)

if [[ "$MUTED_BEFORE" != "$MUTED_NOW" ]]; then
    "$HOME/apps/volume.bash" toggle
fi
