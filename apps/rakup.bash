#!/bin/bash

if [[ -z "$1" ]]; then
    echo 'Specify filepath.'
    exit 1
fi

url_encode() {
    python -c "import furl, sys; print(furl.furl(sys.argv[1]).url)" "$1"
}

if [[ -z "$2" ]]; then
    scp "$1" 'rak@anip.icu:www/rakac/'
    url_encode "https://rakac.anip.icu/$(basename "$1")"
    xclip -rmlastnl <<< "$(url_encode "https://rakac.anip.icu/$(basename "$1")")"
else
    if [[ "$1" = "-" ]]; then
        cat | ssh "rak@anip.icu" "cat > www/rakac/$2"
    else
        scp "$1" "rak@anip.icu:www/rakac/$2"
    fi

    url_encode "https://rakac.anip.icu/$2"
    xclip -rmlastnl <<< "$(url_encode "https://rakac.anip.icu/$2")"
fi


