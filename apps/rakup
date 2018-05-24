#!/bin/bash

if [ -z $1 ];then
    echo Specify filepath.
    exit 1
fi

if [ -z $2 ];then
    scp "$1" rak@rakac.club:www/html/"$1"
    echo "rakac.club/$1"
else
    scp "$1" rak@rakac.club:www/html/"$2"
    echo "rakac.club/$2"
fi


