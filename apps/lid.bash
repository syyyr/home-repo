#!/bin/bash
set -eu

wait_for() {
    echo "Waiting for: \"$1\""
    expect -c "\
        set timeout -1; \
        spawn acpi_listen; \
        expect \"$1\" close" > /dev/null
    echo "Got: \"$1\""
}

wait_for "button/lid LID close"
before=$(date "+%s")
echo "Suspending..."
xset dpms force off
systemctl suspend
wait_for "button/lid LID open"
after=$(date "+%s")

elapsed=$((after-before))
echo -n "Lid was closed for $elapsed seconds. "
if [[ $elapsed -gt $timeout ]]; then
    echo "Locking the screen..."
    $HOME/apps/lock.bash
else
    echo "Not locking the screen."
    xset dpms force on
fi