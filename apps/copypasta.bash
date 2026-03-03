#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

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
weary 😩
kiss/:* 😘
lick/tongue 😋
tongue 👅
loved 🥰
angery 😠
angery2 😡
angery3 🤬
pray/dorime 🙏
highfive 🙌
hands 🙌
italy 🤌
rofl 🤣
sleepy 😴
happy/tear 🥲
spit/saliva/drooling 🤤
holy/halo 😇
wow 😲
gun/pistol 🔫
handshake/shaking_hands 🤝
party 🎉
party 🥳
heart ❤
broken_heart 💔
cash/money/flying 💸
money/face 🤑
fear/scared 😱
facepalm 🤦
heart_eyes 😍
star_eyes 🤩
up_eyes/rolling_eyes 🙄
eggplant 🍆
rocket 🚀
pig/prase 🐷
japan 🗾
watery_eyes 🥹
sweat/drops 💦
toust/toast/bread 🍞
hidden/hands 🫣
mushroom/houby/houba 🍄🍄‍🟫
sunglasses 😎
smirk/lewd/smug 😏
annoyed/unamused 😒
oops/blush/embarrassed 😳
death/skull 💀
moai 🗿
peace ✌️
smiling/crying 🥲
checkmark ✅
night 🌃
goto 𝓰𝓸𝓽𝓸
lightning ⚡
com/rice cơm
lit/fire 🔥
snowflake ❄️
boom 💥
diamond 💎
shhhh 🤫
clown 🤡
duck/kachna 🦆
eyes 👀
strong/arm/flex 💪
fist 👊
knife 🔪
not_stonks 📉
hammer 🔨
roll 🙄
smoke/exhale 😤
sweat 😅
sweat/hot 🥵
motorcycle/bike 🏍️
car/f1/formule/formula 🏎️
zzz/sleep 💤
freezing/cold 🥶
hundred/100 💯
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
    sleep 0.3
    xvkbd -text '\CV'
fi
