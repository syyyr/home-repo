#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if mount -l -t fuse.rclone | grep gdrive &> /dev/null; then
    echo Unmounting gdrive...
    if ! fusermount -u "$HOME/mnt"; then
        find "$HOME/mnt" -print0 | xargs --null fuser 2> /dev/null | xargs ps -f
    fi
else
    echo Mounting gdrive...
    rclone mount --daemon gdrive: "$HOME/mnt"
fi

py3-cmd refresh "external_script mountpoint"
