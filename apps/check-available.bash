#!/bin/bash
for program in "$@"; do
    if ! type "$program" &> /dev/null; then
        echo "$program"' is not installed in PATH.'
        NOTFOUND=1
    fi
done
if ((NOTFOUND)); then
    exit 1
fi

