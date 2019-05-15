#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p ~/.config/nvim/*.vim ~/.config/nvim/autoload/custom.vim
else
    nvim -p $(printf '/home/vk/.config/nvim/%s ' "$@")
fi
