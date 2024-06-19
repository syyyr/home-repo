#!/bin/bash
if mount -l -t fuse.rclone | grep gdrive &> /dev/null; then
	echo -n "<span color='deepskyblue'>drive</span> "
fi

for MOUNTPOINT_PATH in $(mount | grep cifs | cut -d' ' -f1); do
	echo -n "<span color='lime'>smb</span> $MOUNTPOINT_PATH "
done; unset mountpoint
