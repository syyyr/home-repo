#!/bin/bash
set -eu
shopt -s inherit_errexit

echo 'Turning backlight on.'
"$HOME/apps/kbacklight.bash" 2

xinput test "AT Translated Set 2 keyboard" | while true; do
{
    if read -r -t "${TIMEOUT:-5}"; then
        "$HOME/apps/kbacklight.bash" 2
    else
        echo 'Turning backlight off.'
        "$HOME/apps/kbacklight.bash" 0
    fi
}; done

