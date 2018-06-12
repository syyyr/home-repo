#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Showing HEAD"
    sleep 1
    GIT_CURRENT_COMMIT="HEAD" git multidiff HEAD^..HEAD
    exit 0
fi


for arg in $@; do
    if grep '\.\.' <<< $arg; then
        for hash in $(git log --format=%h $arg); do
            echo "Showing ${hash}"
            read -r
            GIT_CURRENT_COMMIT=${hash} git multidiff "${hash}~" "${hash}"
        done
    else
        echo "Showing ${arg}"
        GIT_CURRENT_COMMIT=${arg} git multidiff "${arg}~" "${arg}"
    fi
done


