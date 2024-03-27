#!/bin/bash
if mount -l -t fuse.rclone | grep gdrive &> /dev/null; then
	echo "<span color='deepskyblue'>drive</span>"
fi
