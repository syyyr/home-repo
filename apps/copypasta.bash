#!/bin/bash
"$HOME/apps/check_available.bash" rofi xvkbd nohup xclip || exit 1

PASTAS='thinking 🤔
tears 😭
joy 😂
:DD/grin 😁
ok_hand 👌
thumbs_up 👍
:D 😀
:* 😘
angery 😠
angery2 😡
angery3 🤬
pray 🙏
hands 🙌
rofl 🤣
party 🎉
heart ❤
heart_eyes 😍
sunglasses 😎
checkmark ✅
goto 𝓰𝓸𝓽𝓸
lightning ⚡
lit/fire 🔥
diamond 💎
eyes 👀
strong/arm 💪
roll 🙄
smoke/exhale 😤
sweat 😅
sweat 🥵
hundred/100 💯
fear/scared 😱
rock 🤘
honk/goose 🦢
puke 🤮
devil 😈
shrug ¯\_(ツ)_/¯
tm ™
green_circle 🟢
sushi 🍣
linux/interject I'\''d just like to interject for a moment. What you'\''re referring to as Linux, is in fact, GNU/Linux, or as I'\''ve recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.
b 🅱️'

SELECTED_PASTA="$(rofi -dmenu -p "> " -sort -matching fuzzy -scroll-method 1 <<< "$PASTAS")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_PASTA")"

# I have no idea why this doesn't work without nohup, when this script gets run by i3, but OK
if [[ -n "$RES" ]]; then
    nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
    # Leave some time to allow focus switch back to whatever app I'm using
    sleep 0.3
    xvkbd -text '\CV'
fi
