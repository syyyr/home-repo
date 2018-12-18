#!/bin/bash

if [ -z $1 ];then
    echo Specify filepath.
    exit 1
fi

if [ -z $2 ];then
    scp "$1" rak@anip.icu:www/html/"$1"
    echo "http://anip.icu/$1"
else
    scp "$1" rak@anip.icu:www/html/"$2"
    echo "http://anip.icu/$2"
fi


