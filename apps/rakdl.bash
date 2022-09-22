#!/bin/bash
"$HOME/apps/check-available.bash" fzf

FILE=$(ssh -t "rak@anip.icu" 'ls -1A --color=always www/rakac' | fzf -0 --height=50% --border --ansi | tr -d '')
if [[ "$?" -ne 0 ]]; then
    exit 1
fi

scp "rak@anip.icu:www/rakac/$FILE" .
