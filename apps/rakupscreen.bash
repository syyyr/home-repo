#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

get_image()
{
    base64 -d <<< "$IMAGE"
}

IMAGE="$(xclip -se c -o -target image/png | base64)"

if ! get_image | pngcheck > /dev/null 2>&1; then
    echo 'No picture in clipboard'
    exit 1
fi

FILENAME=$(get_image | sha1sum | fold -w 7 | head -n1)
FILENAME+='.png'
echo "Saving to $FILENAME"

if get_image | SSH_ASKPASS_REQUIRE=never ssh rak@anip.icu "cat > www/anipicu-echo/rofl/$FILENAME"; then
    echo "https://anip.icu/rofl/$FILENAME to PRIMARY selection"
    echo "https://anip.icu/rofl/$FILENAME" | xclip -r
else
    notify-send -t 2000 "ssh-agent not available, screenshot not uploaded."
fi

