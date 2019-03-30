#!/bin/bash
#i3lock -t -i ~/.local/share/chrono.png
#i3lock -t -i ~/.local/share/win10lock.png
kbacklight 0
TOGGLE=no
if ! volume silent | grep muted; then
    volume silent toggle
    TOGGLE=yes
fi
TIME="$(date '+%H:%M')"
DATE="$(date '+%A, %d. %B')"
convert $HOME/.local/share/win10lock-template.png -font $HOME/.local/share/fonts/segoeuil.ttf -fill white -pointsize 127 -draw "text 40,893 '$TIME'" -pointsize 57 -draw "text 40,970 '$DATE'" /tmp/lockscreen.png
systemctl --user start lock_generator.service
/usr/local/bin/i3lock -n -t -i /tmp/lockscreen.png
systemctl --user stop lock_generator.service

if [ $TOGGLE = "yes" ]; then
    volume silent toggle
fi
#xset dpms force off
