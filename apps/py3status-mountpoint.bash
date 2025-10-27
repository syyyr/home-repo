#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

OUTPUT=()
if mount -l -t fuse.rclone | grep gdrive &> /dev/null; then
    OUTPUT+=("<span color='deepskyblue'>drive</span>")
fi

for MOUNTPOINT_PATH in $(mount | grep cifs | cut -d' ' -f1); do
    OUTPUT+=("<span color='lime'>smb</span> $MOUNTPOINT_PATH")
done; unset mountpoint

echo -n "${OUTPUT[@]}"
