#!/bin/bash

if [ -z "$1" ];then
    echo Specify filepath.
    exit 1
fi

if [ -z "$2" ];then
    scp "$1" "rak@anip.icu:www/rakac/"
    echo "https://rakac.anip.icu/$1"
else
    scp "$1" rak@anip.icu:www/rakac/"$2"
    echo "https://rakac.anip.icu/$2"
fi


