#!/bin/bash
EMOJI='thinking 🤔
tears 😭
joy 😂
ok_hand 👌
:D 😀
:* 😘
angery 😠
rofl 🤣
heart ❤
heart_eyes 😍
hundred/100 💯
b 🅱️'

SELECTED_EMOJI="$(rofi -dmenu -matching fuzzy -p "> " <<< "$EMOJI")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_EMOJI")"

# I have no idea why this doesn't work without nohup, when this script gets run by i3, but OK
if [[ -n "$RES" ]]; then
    nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
fi
