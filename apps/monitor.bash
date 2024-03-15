#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

refresh_done() {
    sleep 2
    nitrogen --restore 2> /dev/null
    echo All set up.
}

refresh() {
    OUTPUT="$(xrandr |
        # https://github.com/kellyjonbrazil/jc/issues/549
        grep -v "h:" |
        grep -v "v:" |
        jc --xrandr |
        jq '.screens[].devices | map(select(.device_name != "eDP-1" and .is_connected))[] | del(.resolution_modes)')"
    LAPTOP_OUTPUT="$(xrandr |
        grep -v "h:" |
        grep -v "v:" |
        jc --xrandr |
        jq '.screens[].devices | map(select(.device_name == "eDP-1"))[] | del(.resolution_modes)')"
    OUTPUT_PRETTY="$(jq --compact-output '{is_connected, is_primary, device_name}' <<< "$OUTPUT")"
    LAPTOP_OUTPUT_PRETTY="$(jq --compact-output '{is_connected, is_primary, device_name}' <<< "$LAPTOP_OUTPUT")"
    # Need to output separately, because systemd can't figure to the `jq` is a part of this service.
    # FIXME: This will MAYBE be fixed in systemd v256
    echo "$OUTPUT_PRETTY"
    echo "$LAPTOP_OUTPUT_PRETTY"
    DEVICE_NAME="$(jq -r .device_name <<< "$OUTPUT")"
    if [[ -n "$OUTPUT" ]] && [[ "$(jq '.is_primary' <<< "$OUTPUT")" = true ]]; then
        echo "$DEVICE_NAME" is already set up correctly.
        return
    fi
    if [[ -n "$OUTPUT" ]] && [[ "$(jq '.is_primary' <<< "$OUTPUT")" = false ]]; then
        echo Setting up "$DEVICE_NAME"...
        xrandr --output "$DEVICE_NAME" --above eDP-1 --auto --primary
        "$HOME/apps/workspace-ball.bash" &> /dev/null
        refresh_done
        return
    fi
    if [[ -z "$OUTPUT" && "$(jq '.is_primary' <<< "$LAPTOP_OUTPUT")" = true ]]; then
        echo eDP-1 is already set up correctly.
        return
    fi
    if [[ -z "$OUTPUT" && "$(jq '.is_primary' <<< "$LAPTOP_OUTPUT")" = false ]]; then
        echo Setting up "eDP-1"...
        xrandr --output DP-1 --off
        xrandr --output DP-2 --off
        xrandr --output eDP-1 --primary
        refresh_done
    fi
}

sleep 3 # Wait a bit. If we just booted, this script wouldn't work right away.
refresh

udevadm monitor -k | while IFS= read -r line; do
    if ! grep -qF '/devices/pci0000:00/0000:00:08.1/0000:05:00.0/drm/card1 (drm)' <<< "$line"; then
        continue
    fi

    if xset q | grep -F 'Monitor is Off'; then
        continue
    fi

    echo "Caught event = '$line'"
    refresh
done
