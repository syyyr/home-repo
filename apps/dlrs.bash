#!/bin/bash
if [ $# = 0 ]; then
    echo "Specify the url."
exit 1
fi
SITE=$(curl -s $1)
IMG="$(grep -o -m 1 'http.*jpg' <<< "$SITE")"
$(cd ~/sirve/Disk\ Google/shit/rs; wget "$IMG")
echo "Successfully downloaded that shit :)"
