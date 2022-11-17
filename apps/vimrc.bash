#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/"*
else
    read -ra ARGS < <(printf "$HOME/.config/nvim/%s " "$@")
    nvim -p "${ARGS[@]}"
fi
