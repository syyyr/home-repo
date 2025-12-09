#!/bin/bash
set -euxo pipefail
shopt -s failglob inherit_errexit

if ! mountpoint "$HOME/mnt" > /dev/null; then
    "$HOME/apps/drive.bash"
fi
DIRS=("$HOME/datovka/" "$HOME/mnt/datovka-backup/")
rsync -aur "${DIRS[@]}"
diff -r "${DIRS[@]}"
sync
"$HOME/apps/drive.bash"
rm -r "$HOME/datovka/"
