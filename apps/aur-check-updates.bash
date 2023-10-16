#!/bin/bash
if /usr/bin/auracle outdated | grep -v mingw-w64; then
	notify-send -i '/home/vk/.local/share/icons/blue/25-Ampoule.png' Auracle "AUR updates available."
fi
OUT=$(aur-out-of-date -user syyyr -json)
if [[ $? = 4 ]]; then
	notify-send "AUR" "$(tr -d '\036' <<< "$OUT" | grep OUT-OF-DATE | jq -r '"\(.name)\n<span color=\"red\">\(.version)</span> -> <span color=\"green\">\(.upstream)</span>"')"
fi
