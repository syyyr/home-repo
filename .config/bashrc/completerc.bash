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

__do_completion_for() {
    # Some completions are loaded dynamically on demand
    _completion_loader "$1"
    completion=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}')

    if [[ -n "$completion" ]]; then
        "$completion"
    fi
}

__try_compl() {
    local completion

    COMP_LINE=("${COMP_LINE:4}")
    COMP_POINT=$(($COMP_POINT - 4))
    COMP_WORDS=("${COMP_WORDS[@]:1}")
    COMP_CWORD=$(($COMP_CWORD - 1))

    if [[ "${#COMP_WORDS[@]}" -eq 1 ]]; then
        COMPREPLY=( $(compgen -c "${COMP_WORDS}" | sort -u) )
        return
    fi

    __do_completion_for "${COMP_WORDS[0]}"
}

complete -W 'increase decrease min max'  brightness
complete -W 'increase decrease toggle' volume
complete -W 'toggle manual timeout' kbacklight_ctl
complete -C "$HOME/bin/tasklist" taskkill
_setup_path_compl "vimrc" "$HOME/.config/nvim"
_setup_path_compl "bashrc" "$HOME/.config/bashrc"
complete -C "$HOME/apps/twitch_online.bash" twitch
complete -F __try_compl try
