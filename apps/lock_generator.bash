#!/bin/bash
while true; do
    sleep 10
    TIME="$(date '+%H:%M')"
    DATE="$(date '+%A, %d. %B')"
    convert $HOME/.local/share/win10lock-template.png -font $HOME/.local/share/fonts/segoeuil.ttf -fill white -pointsize 127 -draw "text 40,893 '$TIME'" -pointsize 57 -draw "text 40,970 '$DATE'" /tmp/lockscreen.png
    killall -USR1 i3lock
done
