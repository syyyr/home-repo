#!/bin/bash

set -e
shopt -s inherit_errexit
ARG=$2

case $1 in
    timeout)
        echo TIMEOUT="${ARG:-30}" > "$HOME/.config/kbacklight_timeout/config"
        systemctl --quiet --user restart kbacklight_timeout
        STATE='timeout'
        ;;
    manual)
        systemctl --quiet --user stop kbacklight_timeout
        STATE='manual'
        ;;
    toggle)
        if systemctl --quiet --user is-active kbacklight_timeout; then
            systemctl --quiet --user stop kbacklight_timeout
            STATE='manual'
        else
            systemctl --quiet --user start kbacklight_timeout
            STATE='timeout'
        fi
        ;;
    *)
        echo No command specified. >&2
        exit 1
esac

if [[ "$STATE" = "manual" ]]; then
    "$HOME/apps/kbacklight.bash" 0
else
    "$HOME/apps/kbacklight.bash" 2
fi

KEYBOARD_IMG="$HOME/.local/share/icons/blue/keyboard.png"
ARGS=( -t 2000 -h string:x-canonical-private-synchronous:kbacklight )
ARGS+=( -i "$KEYBOARD_IMG" )
notify-send "${ARGS[@]}" 'Keyboard' "$STATE"
