#!/bin/bash
set -euo pipefail

"$HOME/apps/check-available.bash" dwdiff || exit 1

if [[ "$*" =~ "==" ]]; then
    LEFT=$(grep ".* == " -o <<< "$*" | sed 's/ == //')
    RIGHT=$(grep " == .*" -o <<< "$*" | sed 's/ == //')
    dwdiff -c <(echo "$LEFT") <(echo "$RIGHT")
else
    dwdiff -c <(echo "$1") <(echo "$2")
fi

