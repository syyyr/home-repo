#!/bin/bash
set -e
"$HOME/apps/check_available.bash" escrotum ffmpeg notify-send convert || exit 1

ARGS='-h string:x-canonical-private-synchronous:areagif'
notify-send -t 3000 $ARGS "Select area..."
escrotum -rs /tmp/area-gif.webm
notify-send -t 100000 $ARGS  "Converting to gif..."
ffmpeg -i /tmp/area-gif.webm /tmp/area-gif.avi
rm /tmp/area-gif.webm
convert -set delay 10 -layers Optimize /tmp/area-gif.avi /tmp/area-gif.gif
rm /tmp/area-gif.avi
xclip <<< "/tmp/area-gif.gif"
notify-send -t 3000 $ARGS  "Saved as /tmp/area-gif.gif and copied path to PRIMARY selection."
