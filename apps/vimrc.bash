#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ $# -eq 0 ]]; then
    readarray -t FILES < <(find "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/"* -type f)
    nvim -p "${FILES[@]}"
else
    readarray -t ARGS < <(printf "$HOME/.config/nvim/%s\n" "$@")
    nvim -p "${ARGS[@]}"
fi
