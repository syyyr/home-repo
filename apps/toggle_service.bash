#!/bin/bash

if [ $# -eq 0 ]; then
    echo 'No service specified.'
    exit 1
fi

if systemctl is-active $@ > /dev/null ; then
    systemctl stop $@
else
    systemctl start $@
fi
