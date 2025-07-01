#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

if [[ $# -eq 0 ]]; then
    nvim -p "$HOME/.config/bashrc/"*
else
    readarray -t ARGS < <(printf "$HOME/.config/bashrc/%s\n" "$@")
    nvim -p "${ARGS[@]}"
fi
