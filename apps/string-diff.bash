#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ "$*" =~ "==" ]]; then
    LEFT=$(grep ".* == " -o <<< "$*" | sed 's/ == //')
    RIGHT=$(grep " == .*" -o <<< "$*" | sed 's/ == //')
    dwdiff -c <(echo "$LEFT") <(echo "$RIGHT")
else
    dwdiff -c <(echo "$1") <(echo "$2")
fi

