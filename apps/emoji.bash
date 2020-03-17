#!/bin/bash
EMOJI='thinking 🤔
tears 😭
joy 😂
ok_hand 👌
b 🅱️'

SELECTED_EMOJI="$(fzf --no-sort --border <<< "$EMOJI")"
RES="$(sed -r 's/^[^ ]+ //' <<< "$SELECTED_EMOJI")"

# I have no idea why this doesn't work without nohup, when this script gets run in a separate terminal but OK.
nohup xclip -rmlastnl -se c <<< "$RES" &> /dev/null
