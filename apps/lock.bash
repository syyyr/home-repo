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
TOGGLE=no
if ! "$HOME/bin/volume" silent | grep muted; then
    "$HOME/bin/volume" silent toggle
    TOGGLE='yes'
fi

(sleep 7; xset dpms force off)&
SCREENOFF_PID="$!"

echo -n "$ARGS" | xargs i3lock -n

kill "$SCREENOFF_PID" 2> /dev/null

if [ $TOGGLE = "yes" ]; then
    "$HOME/bin/volume" silent toggle
fi
