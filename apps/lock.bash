#!/bin/bash
"$HOME/apps/check_available.bash" i3lock || exit 1

if [[ "$(i3lock -v 2>&1)" =~ [0-9]+\.[0-9]+\.c\.[0-9]+ ]]; then
    ARGS='
    -k
    -i '$HOME'/.local/share/win10lock-template.png
    --time-font=Segoeui
    --date-font=Segoeui
    --timesize=130
    --datesize=59
    --timestr="%H:%M"
    --datestr="%A, %d. %B"
    --datecolor=FFFFFF
    --timecolor=FFFFFF
    --timepos=200:893
    --datepos="240:ty+80"'
fi

"$HOME/apps/kbacklight.bash" 0
# TODO: if you take out headphones, the speakers get unumuted
TOGGLE=no
if ! "$HOME/apps/volume.bash" | grep muted; then
    "$HOME/apps/volume.bash" toggle
    TOGGLE='yes'
fi

if [[ "$1" != "no-off" ]]; then
    (sleep 7; xset dpms force off)&
    SCREENOFF_PID="$!"
fi


echo -n "$ARGS" | xargs i3lock -n

if [[ "$1" != "no-off" ]]; then
    kill "$SCREENOFF_PID" 2> /dev/null
fi

if [ $TOGGLE = "yes" ]; then
    "$HOME/apps/volume.bash" toggle
fi
