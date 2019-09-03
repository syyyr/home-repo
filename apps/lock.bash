#!/bin/bash
# TODO: Make this faster somehow. The initial lock takes forever.
kbacklight 0
TOGGLE=no
if ! volume silent | grep muted; then
    volume silent toggle
    TOGGLE=yes
fi
TIME="$(date '+%H:%M')"
DATE="$(date '+%A, %d. %B')"
convert /home/vk/.local/share/win10lock-template-res.png \
    -font $HOME/.local/share/fonts/segoeuil.ttf \
    -fill white \
    -pointsize 127 -draw "text 40,893 '$TIME'" \
    -pointsize 57 -draw "text 40,970 '$DATE'" \
    -pointsize 169 -draw "text 1973,1190 '$TIME'" \
    -pointsize 76 -draw "text 1973,1293 '$DATE'" \
    /tmp/lockscreen.png
systemctl --user start lock_generator.service
/usr/local/bin/i3lock -n -i /tmp/lockscreen.png
systemctl --user stop lock_generator.service

if [ $TOGGLE = "yes" ]; then
    volume silent toggle
fi
#xset dpms force off
