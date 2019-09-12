#!/bin/bash
systemctl --user start lock_generator.service
kbacklight 0
TOGGLE=no
if ! volume silent | grep muted; then
    volume silent toggle
    TOGGLE=yes
fi
# The color here is for when the image doesn't exist (gets deleted from /tmp on
# reboot).
(sleep 7; xset dpms force off)&
/usr/local/bin/i3lock -c 000000 -n -i /tmp/lockscreen.png

# This kills the background subshell.
kill $!
systemctl --user stop lock_generator.service

if [ $TOGGLE = "yes" ]; then
    volume silent toggle
fi
