#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ $# -eq 0 ]]; then
    readarray -t FILES < <(find "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/"* -type f)
    nvim -p "${FILES[@]}"
else
    read -ra ARGS < <(printf "$HOME/.config/nvim/%s " "$@")
    nvim -p "${ARGS[@]}"
fi
