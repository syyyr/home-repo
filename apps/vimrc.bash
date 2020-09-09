#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/nvim/"*".vim" "$HOME/.config/nvim/autoload/custom.vim"
else
    nvim -p $(printf "$HOME/.config/nvim/%s " "$@")
fi
