#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if xrandr | grep primary | grep -F "1920x1080" > /dev/null; then
    TIME_SIZE=130
    DATE_SIZE=59
    TIME_POS=80:913
    DATE_POS=80:ty+80
else
    TIME_SIZE=260
    DATE_SIZE=118
    TIME_POS=160:1826
    DATE_POS=160:ty+160
fi

IMAGE_FILE="$HOME/.local/share/win10-lock-4k.png"
i3lock \
    --nofork \
    --fill \
    --clock \
    --pass-media-keys \
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
    --date-pos="$DATE_POS" &
I3LOCK_PID="$!"

i3-msg bar mode invisible

"$HOME/apps/kbacklight.bash" 0

if [[ "$(playerctl status)" = "Playing" ]]; then
    playerctl pause
fi

VOLUME_BEFORE="$("$HOME/apps/volume.bash")"

if [[ "${1:-}" != "no-off" ]]; then
    (sleep 7; xset dpms force off)&
    SCREENOFF_PID="$!"
fi

dunstctl set-paused true
wait "$I3LOCK_PID"
dunstctl set-paused false
i3-msg bar mode dock

if [[ "${1:-}" != "no-off" ]]; then
    kill "$SCREENOFF_PID" 2> /dev/null
fi

VOLUME_NOW="$("$HOME/apps/volume.bash")"

py3-cmd refresh --all

if [[ "$VOLUME_NOW" != "$VOLUME_BEFORE" ]]; then
    # The volume changed from outside, let's not do anything. If VOLUME_NOW is muted, we definitely don't want to unmute
    # it, and if VOLUME_NOW is unmuted, it's too late to mute it now.
    # Note: this detection fails if only the muted state changes, for example, if I disconnect my headphones, and the
    # speaker and headphone volume is the same.
    exit 0
fi
