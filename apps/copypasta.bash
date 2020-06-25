#!/bin/bash
PASTAS='thinking 🤔
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
linux/interject I'\''d just like to interject for a moment. What you'\''re referring to as Linux, is in fact, GNU/Linux, or as I'\''ve recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.
b 🅱️'

SELECTED_PASTA="$(rofi -dmenu -matching fuzzy -p "> " <<< "$PASTAS")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_PASTA")"

# I have no idea why this doesn't work without nohup, when this script gets run by i3, but OK
if [[ -n "$RES" ]]; then
    nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
    xvkbd -text '\CV'
fi
