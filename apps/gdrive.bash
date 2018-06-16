#!/bin/bash
fusermount -u ~/drive 2>/dev/null

if [ $# -gt 0 ]; then
    exit 0
fi

echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 #> /dev/null 2>&1
while [ ! $? = 0 ]; do
    sleep 7
    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 #> /dev/null 2>&1
done
google-drive-ocamlfuse ~/drive
