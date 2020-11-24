#!/bin/bash
"$HOME/apps/check_available.bash" fzf

# Set TERM and use dircolors to tell remote bash that I'm using a color enabled terminal
FILE=$(ssh "rak@anip.icu" 'export TERM=xterm-256color; eval $(dircolors); ls -A --color=always www/rakac' | fzf -0 --height=50% --border --ansi);
if [[ "$?" -ne 0 ]]; then
    exit 1
fi

scp "rak@anip.icu:www/rakac/$FILE" .
