#!/bin/bash
"$HOME/apps/check-available.bash" i3lock || exit 1

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

if [[ "$(i3lock -v 2>&1)" =~ [0-9]+\.[0-9]+\.c\.[0-9]+ ]]; then
    ARGS='
    -k
    -i '$HOME'/.local/share/win10-lock-4k.png
    -c 000000
    --time-font=Segoeui
    --date-font=Segoeui
    --time-size=260
    --date-size=118
    --time-str="%H:%M"
    --date-str="%A, %d. %B"
    --date-color=FFFFFF
    --time-color=FFFFFF
    --time-pos=160:1826
    --date-align=1
    --time-align=1
    --date-pos="160:ty+160"'
fi

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


echo -n "$ARGS" | xargs i3lock -n

if [[ "$1" != "no-off" ]]; then
    kill "$SCREENOFF_PID" 2> /dev/null
fi

MUTED_NOW=$(get_muted)

if [[ $MUTED_BEFORE != $MUTED_NOW ]]; then
    "$HOME/apps/volume.bash" toggle
fi
