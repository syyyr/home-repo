#!/bin/bash

if [ -z $1 ];then
    echo Specify filepath.
    exit 1
fi

if [ -z $2 ];then
    scp "$1" rak@ja.neviem.us:www/html/"$1"
    echo "ja.neviem.us/$1"
else
    scp "$1" rak@ja.neviem.us:www/html/"$2"
    echo "ja.neviem.us/$2"
fi


