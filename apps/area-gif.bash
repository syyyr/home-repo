#!/bin/bash
set -e

exec &> ~/log.out
notify-send -t 3000 -R /tmp/area-gif-not-id "Select area..."
escrotum -rs /tmp/area-gif.webm
notify-send -t 100000 -R /tmp/area-gif-not-id "Converting to gif..."
ffmpeg -i /tmp/area-gif.webm /tmp/area-gif.avi
rm /tmp/area-gif.webm
convert -set delay 10 -layers Optimize /tmp/area-gif.avi /tmp/area-gif.gif
rm /tmp/area-gif.avi
notify-send -t 3000 -R /tmp/area-gif-not-id "Saved as /tmp/area-gif.gif"
