#!/bin/bash
# The lockscreen now shows up immediately, but the image generation is still
# rather slow...
TIME="$(date '+%H:%M')"
DATE="$(date '+%A, %d. %B')"
convert /home/vk/.local/share/win10lock-template-res.png \
    -font "$HOME/.local/share/fonts/segoeuil.ttf" \
    -fill white \
    -pointsize 127 -draw "text 40,893 '$TIME'" \
    -pointsize 57 -draw "text 40,970 '$DATE'" \
    -pointsize 169 -draw "text 1973,1190 '$TIME'" \
    -pointsize 76 -draw "text 1973,1293 '$DATE'" \
    /tmp/lockscreen.png
killall -USR1 i3lock

while true; do
    sleep 10
    TIME="$(date '+%H:%M')"
    DATE="$(date '+%A, %d. %B')"
    convert /home/vk/.local/share/win10lock-template-res.png \
        -font "$HOME/.local/share/fonts/segoeuil.ttf" \
        -fill white \
        -pointsize 127 -draw "text 40,893 '$TIME'" \
        -pointsize 57 -draw "text 40,970 '$DATE'" \
        -pointsize 169 -draw "text 1973,1190 '$TIME'" \
        -pointsize 76 -draw "text 1973,1293 '$DATE'" \
        /tmp/lockscreen.png
    killall -USR1 i3lock
done
