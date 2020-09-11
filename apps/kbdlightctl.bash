#!/bin/bash

set -e
ARG=$2

case $1 in
    pulse)
        echo INTERVAL=${ARG:-3000} > "$HOME/.config/kbdpulse.conf"
        systemctl --quiet --user stop kbdlighttimeout
        systemctl --quiet --user restart kbdpulse
        STATE='pulsing'
        ;;
    timeout)
        echo TIMEOUT=${ARG:-30} > "$HOME/.config/kbdlighttimeout.conf"
        systemctl --quiet --user stop kbdpulse
        systemctl --quiet --user restart kbdlighttimeout
        kbacklight 2
        STATE='timeout'
        ;;
    manual)
        systemctl --quiet --user stop kbdpulse
        systemctl --quiet --user stop kbdlighttimeout
        kbacklight 0
        STATE='manual'
        ;;
    cycle)
        if systemctl --quiet --user is-active kbdlighttimeout; then
            systemctl --quiet --user stop kbdlighttimeout
            systemctl --quiet --user start kbdpulse
            STATE='pulsing'
        elif systemctl --quiet --user is-active kbdpulse; then
            systemctl --quiet --user stop kbdpulse
            kbacklight 0
        STATE='manual'
        else
            systemctl --quiet --user start kbdlighttimeout
            kbacklight 2
            STATE='timeout'
        fi
        ;;
    *)
        echo No command specified. >&2
        exit 1
esac

KEYBOARD_IMG="$HOME/.local/share/icons/blue/keyboard.png"
LAST="`cat /tmp/kbd-not-id`"
ARGS="-t 2000 -r ${LAST:-"0"} -p"
ARGS+=" -h string:image_path:$KEYBOARD_IMG"
notify-send $ARGS 'Keyboard' "$STATE" > /tmp/kbd-not-id
