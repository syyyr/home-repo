#!/bin/bash
notify-send -t 3000 -R /tmp/area-gif-not-id "Select area..."
ffcast -s % ffmpeg -y -f x11grab -show_region 1 -framerate 15 -video_size %s -i %D+%c -codec:v huffyuv -vf crop="iw-mod(iw\\,2):ih-mod(ih\\,2)" /tmp/area-gif.avi
notify-send -t 100000 -R /tmp/area-gif-not-id "Converting to gif..."
convert -set delay 10 -layers Optimize /tmp/area-gif.avi /tmp/area-gif.gif
notify-send -t 3000 -R /tmp/area-gif-not-id "Saved as /tmp/area-gif.gif"
rm /tmp/area-gif.avi
