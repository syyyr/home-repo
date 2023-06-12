#!/bin/bash
set -euo pipefail

if mountpoint ~/mnt &> /dev/null; then
    echo Unmounting Android...
    umount ~/mnt
    echo Android unmounted.
else
    echo Mounting Android...
    aft-mtp-mount ~/mnt && echo Android mounted.
fi
