#!/bin/bash

refresh() {
    if pgrep i3lock; then
        echo "Skipping refresh, because i3lock is running"
        return
    fi
    OUTPUT=$(xrandr | grep -o '^.* connected' | grep -v 'eDP-1' | sed 's/ connected//')
    echo "$OUTPUT"
    if [[ -z "$OUTPUT" ]]; then
        xrandr --output DP-1 --off
        xrandr --output DP-2 --off
        xrandr --output eDP-1 --primary
    else
        xrandr --output "$OUTPUT" --above eDP-1 --auto --primary
        "$HOME/apps/workspace-ball.bash"
    fi
    sleep 2
    nitrogen --restore
    i3-msg restart
}

sleep 3 # Wait a bit. If we just booted, this script wouldn't work right away.
refresh

udevadm monitor -k | while IFS= read -r line; do
    if ! grep -qF '/devices/pci0000:00/0000:00:08.1/0000:05:00.0/drm/card0 (drm)' <<< "$line"; then
        continue
    fi

    if xset q | grep -F 'Monitor is Off'; then
        continue
    fi

    refresh
done
