#!/bin/bash
"$HOME/apps/check_available.bash" rofi xdotool nohup xclip || exit 1

PASTAS='thinking 🤔
tears 😭
joy 😂
:DD/grin 😁
ok_hand 👌
:D 😀
:* 😘
angery 😠
pray 🙏
hands 🙌
rofl 🤣
heart ❤
heart_eyes 😍
sunglasses 😎
diamond 💎
eyes 👀
roll 🙄
sweat 😅
hundred/100 💯
fear/scared 😱
honk/goose 🦢
devil 😈
shrug ¯\_(ツ)_/¯
tm ™
green_circle 🟢
sushi 🍣
linux/interject I'\''d just like to interject for a moment. What you'\''re referring to as Linux, is in fact, GNU/Linux, or as I'\''ve recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.
b 🅱️'

SELECTED_PASTA="$(rofi -dmenu -sort -matching fuzzy -p "> " <<< "$PASTAS")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_PASTA")"

# I have no idea why this doesn't work without nohup, when this script gets run by i3, but OK
if [[ -n "$RES" ]]; then
    nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
    xdotool type "$RES"
fi
