#!/bin/bash
"$HOME/apps/check-available.bash" rofi xvkbd nohup xclip || exit 1

PASTAS='thinking 🤔
tears 😭
joy 😂
xd 😆
:DD/grin 😁
oof/popofka 😬
ok_hand 👌
fingers_crossed 🤞
thumbs_up 👍
:D 😀
kiss/:* 😘
lick/tongue 😋
loved 🥰
angery 😠
angery2 😡
angery3 🤬
pray/dorime 🙏
hands 🙌
rofl 🤣
sleepy 😴
happy/tear 🥲
spit/saliva/drooling 🤤
holy/halo 😇
wow 😲
gun/pistol 🔫
handshake/shaking_hands 🤝
party 🎉
heart ❤
broken_heart 💔
cash 💸
facepalm 🤦
heart_eyes 😍
star_eyes 🤩
eggplant 🍆
sweat/drops 💦
toust/toast/bread 🍞
hidden/hands 🫣
sunglasses 😎
smirk/lewd 😏
annoyed/unamused 😒
oops/blush/embarrassed 😳
death/skull 💀
peace ✌️
smiling/crying 🥲
checkmark ✅
night 🌃
goto 𝓰𝓸𝓽𝓸
lightning ⚡
com/rice cơm
lit/fire 🔥
diamond 💎
shhhh 🤫
clown 🤡
duck/kachna 🦆
eyes 👀
strong/arm 💪
knife 🔪
hammer 🔨
roll 🙄
smoke/exhale 😤
sweat 😅
sweat/hot 🥵
freezing/cold 🥶
hundred/100 💯
fear/scared 😱
rock 🤘
honk/goose 🦢
puke 🤮
devil 😈
shrug ¯\_(ツ)_/¯
lenny ( ͡° ͜ʖ ͡°)
monocle/detective 🧐
tm ™
green_circle 🟢
sushi 🍣
linux/interject I'\''d just like to interject for a moment. What you'\''re referring to as Linux, is in fact, GNU/Linux, or as I'\''ve recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.
ab 🆎
b 🅱️'

SELECTED_PASTA="$(rofi -dmenu -p "> " -sort -matching fuzzy -scroll-method 1 <<< "$PASTAS")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_PASTA")"

# I have no idea why this doesn't work without nohup, when this script gets run by i3, but OK
if [[ -n "$RES" ]]; then
    nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
    # Leave some time to allow focus switch back to whatever app I'm using
    sleep 0.2
    xvkbd -text '\CV'
fi
