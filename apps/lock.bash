#!/bin/bash
#i3lock -t -i ~/.local/share/chrono.png
#i3lock -t -i ~/.local/share/win10lock.png
kbacklight 0
TIME="$(date '+%H:%M')"
DATE="$(date '+%A, %d. %B')"
convert .local/share/win10lock-template.png -font .local/share/fonts/segoeuil.ttf -fill white -pointsize 127 -draw "text 40,893 '$TIME'" -pointsize 57 -draw "text 40,970 '$DATE'" /tmp/lockscreen.png
i3lock -t -i /tmp/lockscreen.png
#xset dpms force off
