#!/bin/bash

if [ -z "$1" ];then
    echo 'Specify filepath.'
    exit 1
fi

if [ -z "$2" ];then
    scp "$1" 'rak@anip.icu:www/rakac/'
    echo "https://rakac.anip.icu/$(basename "$1")"
    xclip <<< "https://rakac.anip.icu/$(basename "$1")"
else
    if [ "$1" = "-" ]; then
        scp <(cat) "rak@anip.icu:www/rakac/$2"
    else
        scp "$1" "rak@anip.icu:www/rakac/$2"
    fi

    echo "https://rakac.anip.icu/$2"
    xclip <<< "https://rakac.anip.icu/$2"
fi


