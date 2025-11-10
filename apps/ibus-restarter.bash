#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

do_restart()
{
    echo Restarting ibus...
    systemctl --user restart 'ibus@:0.service'
    echo Restarted ibus.
}

while ! systemctl --user is-active 'ibus@:0.service'; do
    do_restart
done


while true; do
    echo Wating for i3 socket...
    while ! [[ -r "$(i3 --get-socketpath)" ]]; do
        sleep 0.1
    done
    echo Socket ready.
    echo Listening to i3.
    i3-msg -t subscribe || true
    do_restart
done

