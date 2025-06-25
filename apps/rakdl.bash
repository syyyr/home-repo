#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if ! FILE=$(ssh -t "rak@anip.icu" 'ls -1A --color=always www/rakac' | fzf -0 --height=50% --border --ansi | tr -d ''); then
    exit 1
fi

scp "rak@anip.icu:www/rakac/$FILE" .
