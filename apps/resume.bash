#!/bin/bash

if find /tmp/suspend_time -newermt "-60 seconds" | grep '.' > /dev/null; then
    echo Killing...
    pkill i3lock
else
    echo Not killing...
fi
