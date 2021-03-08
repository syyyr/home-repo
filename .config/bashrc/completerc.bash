#!/bin/bash

__impl_path_compl() {
    command find -not -name '\.*' -type f | sed s@\./@@
}

_setup_path_compl() {
    eval "_$1_complete() {
        pushd '$2' > /dev/null
        FZF_DEFAULT_OPTS='-1' FZF_COMPLETION_TRIGGER='' __fzf_generic_path_completion __impl_path_compl '-m' ''
        popd > /dev/null
    }"
    complete -F "_$1_complete" "$1"
}

complete -W 'increase decrease min max'  brightness
complete -W 'increase decrease toggle' volume
complete -W 'toggle manual timeout' kbacklight_ctl
complete -C "$HOME/bin/tasklist" taskkill
_setup_path_compl "vimrc" "$HOME/.config/nvim"
_setup_path_compl "bashrc" "$HOME/.config/bashrc"
complete -C "$HOME/apps/twitch_online.bash" twitch
