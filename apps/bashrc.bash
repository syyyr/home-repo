#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/bashrc/"*
else
    nvim -p $(printf "$HOME/.config/bashrc/%s " "$@")
fi
