#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ "$#" -ne 4 ]]; then
    echo 'usage: res <xrandr output> <x> <y> <hz>'
    exit 1
fi
echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode"
cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode
echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode $1"
cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode "$1"
echo "xrandr --output $1 --mode $(cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2)"
xrandr --output "$1" --mode "$(tr -d '"' <<< "$(cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2)")"
