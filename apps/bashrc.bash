#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/bashrc/"*
else
    read -ra ARGS < <(printf "$HOME/.config/bashrc/%s " "$@")
    nvim -p "${ARGS[@]}"
fi
