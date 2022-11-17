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
    completion=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}')

    # Some completions are loaded dynamically on demand
    if [[ -z "$completion" ]]; then
        _completion_loader "$1"
        completion=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}')
    fi

    if [[ -n "$completion" ]]; then
        # Completion functions take these arguments:
        # $1 the command name begin completed
        # $2 the word being completed
        # $3 the word preceding the being completed
        # So far, I have found out only fzf completions need the first argument, so I am going to supply it.
        "$completion" "$1"
    fi
}

__try_compl() {
    local completion

    COMP_LINE=("${COMP_LINE:4}")
    COMP_POINT=$((COMP_POINT - 4))
    COMP_WORDS=("${COMP_WORDS[@]:1}")
    COMP_CWORD=$((COMP_CWORD - 1))

    if [[ "${#COMP_WORDS[@]}" -eq 1 ]]; then
        readarray COMPREPLY < <(compgen -c "" | sort -u)
        return
    fi

    __do_completion_for "${COMP_WORDS[0]}"
}

__twitch_compl() {
    readarray COMPREPLY < <(compgen -W "$("$HOME/apps/twitch-online.bash")" "${COMP_WORDS[${COMP_CWORD}]}")
}

complete -W 'increase decrease min max'  brightness
complete -W 'increase decrease toggle' volume
complete -W 'toggle manual timeout' kbacklight_ctl
complete -C "$HOME/bin/tasklist" taskkill
_setup_path_compl "vimrc" "$HOME/.config/nvim"
_setup_path_compl "bashrc" "$HOME/.config/bashrc"
complete -F __twitch_compl twitch
complete -F __try_compl try
