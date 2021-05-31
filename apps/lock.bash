#!/bin/bash
"$HOME/apps/check_available.bash" i3lock || exit 1

get_muted()
{
    if "$HOME/apps/volume.bash" | grep muted; then
        echo 0
        return 0
    else
        echo 1
        return 1
    fi
}

if [[ "$(i3lock -v 2>&1)" =~ [0-9]+\.[0-9]+\.c\.[0-9]+ ]]; then
    ARGS='
    -k
    -i '$HOME'/.local/share/win10lock-template.png
    --time-font=Segoeui
    --date-font=Segoeui
    --time-size=130
    --date-size=59
    --time-str="%H:%M"
    --date-str="%A, %d. %B"
    --date-color=FFFFFF
    --time-color=FFFFFF
    --time-pos=80:913
    --date-align=1
    --time-align=1
    --date-pos="80:ty+80"'
fi

"$HOME/apps/kbacklight.bash" 0
# TODO: if you take out headphones, the speakers get unumuted
MUTED_BEFORE=$(get_muted)

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
