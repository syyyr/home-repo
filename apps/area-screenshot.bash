#!/bin/bash
"$HOME/apps/check_available.bash" escrotum feh || exit 1

escrotum /tmp/screenshot > /dev/null
feh /tmp/screenshot &
escrotum -s -C
killall feh
rm /tmp/screenshot
"$HOME/apps/rakupscreen.bash"
