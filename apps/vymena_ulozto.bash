#!/bin/bash

DATE_REGEX="$(date -d "Wednesday" '+%d.*%-m.*%y')"

JSON="$(python3 "$HOME/apps/lib/search_ulozto.py" "výměna manželek" "$DATE_REGEX")"
if [[ $? -eq 1 ]]; then
    exit 1
fi

LINK="$(jq -r '.[]' <<< "$JSON")"
TITLE="$(jq -r '. | keys[]' <<< "$JSON")"
echo Title: "$TITLE"
echo "$LINK"
DATE_OUT="$(date -d "Wednesday" '+%d.%-m.%y')"

EXTENSION="${TITLE##*.}"
OUT_FILE="/mnt/d/vymena/vymena-${DATE_OUT//./-}.$EXTENSION"

if [[ -f "$OUT_FILE" ]]; then
    echo Already got that.
    exit 0
fi

POWERSHELL="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
if [[ -f "$POWERSHELL" ]]; then
    "$POWERSHELL" 'C:\Users\sirve\Documents\show_notif.ps1' '"Výměna manželek"' '"Stahuji novou výměnu."' > /dev/null
fi


"$HOME/apps/dl_ulozto.bash" "$OUT_FILE" "$LINK"
if [[ "$EXTENSION" != "mp4" ]]; then
    ffmpeg -i "$OUT_FILE" "/mnt/d/vymena/vymena-${DATE_OUT//./-}.mp4"
    OUT_FILE="/mnt/d/vymena/vymena-${DATE_OUT//./-}.mp4"
fi
rakup "$OUT_FILE"

if [[ -f "$POWERSHELL" ]]; then
    "$POWERSHELL" 'C:\Users\sirve\Documents\show_notif.ps1' '"Výměna manželek"' '"Hotovo."' > /dev/null
fi
