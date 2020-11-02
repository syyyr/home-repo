#!/bin/bash

"$HOME/apps/check_available.bash" pngcheck base64 fold sha1sum xclip

get_image()
{
    base64 -d <<< "$IMAGE"
}

IMAGE="$(xclip -se c -o -target image/png | base64)"

if  ! $(get_image | pngcheck > /dev/null 2>&1) ; then
    echo 'No picture in clipboard'
    exit 1
fi

FILENAME=$(get_image | sha1sum | fold -w 7 | head -n1)
FILENAME+='.png'
echo "Saving to $FILENAME"
get_image | ssh rak@anip.icu "cat > www/anip.icu/rofl/$FILENAME"

echo "https://anip.icu/rofl/$FILENAME to PRIMARY selection"
echo "https://anip.icu/rofl/$FILENAME" | xclip -r
