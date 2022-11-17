#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/nvim/"*".vim" "$HOME/.config/nvim/autoload/custom.vim"
else
    read -ra ARGS < <(printf "$HOME/.config/nvim/%s " "$@")
    nvim -p "${ARGS[@]}"
fi
