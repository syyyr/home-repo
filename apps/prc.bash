#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

MOUNTPOINT="$HOME/git/pi-backup"
mkdir -p "$MOUNTPOINT"
if ! mountpoint "$MOUNTPOINT" &> /dev/null; then
    sshfs pi:/homeassistant "$MOUNTPOINT"
fi

cd "$HOME/git/pi-backup"
FILE_CONTENT="$(cat configuration.yaml)"
nvim 'configuration.yaml'
if [[ "$FILE_CONTENT" != "$(cat configuration.yaml)" ]]; then
    echo 'Detected changes to configuration.yaml, running `git status`...'
    git status
else
    echo 'configuration.yaml unchanged.'
fi
