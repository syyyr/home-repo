#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if [[ "$1" = "-" ]] || ! [[ -t 0 ]]; then
    if [[ "$1" = "-" ]]; then
        shift
    fi
    TARGET_FILE="${1}"
    TARGET_FILE="$(basename "$TARGET_FILE")"
    cat | ssh "rak@anip.icu" "cat > www/rakac/$TARGET_FILE"
else
    if [[ $# = 1 ]]; then
        TARGET_FILE="${1}"
    else
        TARGET_FILE="${2}"
    fi
    TARGET_FILE="$(basename "$TARGET_FILE")"
    scp "$1" "rak@anip.icu:www/rakac/$TARGET_FILE"
fi

URL="$(python -c "import furl, sys; print(furl.furl(sys.argv[1]).url)" "https://rakac.anip.icu/$TARGET_FILE")"
echo "$URL"
xclip -rmlastnl <<< "$URL"
