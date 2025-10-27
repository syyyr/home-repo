#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

set +H
echo "$@"
WIN_PATH=$(wslpath "$@")
echo "$WIN_PATH"
"$HOME/apps/kitty.wrapper" nvim "$WIN_PATH"
