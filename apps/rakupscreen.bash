#!/bin/bash

if  ! xclip -se c -o -target image/png | pngcheck > /dev/null 2>&1 ; then
    echo "No picture in clipboard"
    exit 1
fi

FILENAME=$(xclip -se c -o -target image/png | sha1sum | fold -w 7 | head -n1)
FILENAME+=".png"
echo "Saving to $FILENAME"
xclip -se c -o -target image/png | ssh rak@do "cat > www/html/rofl/$FILENAME"

if [ $# = 0 ]; then
    exit 0
fi

if [ "$1" = "-c" ];then
    echo "http://rakac.neviem.us/rofl/$FILENAME to clipboard"
    echo "http://rakac.neviem.us/rofl/$FILENAME" | xclip -se c -r
fi
