#!/bin/bash
export DISPLAY=:'0.0'

refresh() {
    OUTPUT=$(xrandr | grep -o '^.* connected' | grep -v 'eDP-1' | sed 's/ connected//')
    echo "$OUTPUT"
    if [ -z "$OUTPUT" ]; then
        xrandr --output DP-1 --off
        xrandr --output DP-2 --off
        xrandr --output eDP-1 --primary
    else
        xrandr --output "$OUTPUT" --right-of eDP-1 --auto --primary
        "$HOME/apps/workspace_ball.bash"
        nitrogen --restore
    fi
}

sleep 3 # Wait a bit. If we just booted, this script wouldn't work right away.
refresh

udevadm monitor -k | while IFS= read -r line;
do

    if [ -z "$(grep -F '/devices/pci0000:00/0000:00:02.0/drm/card0 (drm)' <<< $line)" ]; then
        continue
    fi

    refresh
done
