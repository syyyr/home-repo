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
_setup_path_compl "vimrc" "$HOME/.config/nvim"
_setup_path_compl "bashrc" "$HOME/.config/bashrc"

__do_completion_for() {
    local completion_func=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}')

    # Some completions are loaded dynamically on demand
    if [[ -z "$completion_func" ]]; then
        _completion_loader "$1"
        completion_func=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}')
    fi

    if [[ -n "$completion_func" ]]; then
        # completion_func functions take these arguments:
        # $1 the command name being completed
        # $2 the word being completed
        # $3 the word preceding the word being completed
        # So far, I have found out only fzf completions need the first argument, so I am going to supply it.
        "$completion_func" "$1"
    fi
}

__try_compl() {
    COMP_LINE=("${COMP_LINE:4}")
    COMP_POINT=$((COMP_POINT - 4))
    COMP_WORDS=("${COMP_WORDS[@]:1}")
    COMP_CWORD=$((COMP_CWORD - 1))

    if [[ "${#COMP_WORDS[@]}" -eq 1 ]]; then
        readarray -t COMPREPLY < <(compgen -c "" | sort -u)
        return
    fi

    __do_completion_for "${COMP_WORDS[0]}"
}
complete -F __try_compl try

__update-aur-dep_compl() {
    readarray -t COMPREPLY < <(compgen -W "$(auracle outdated -q)" "${COMP_WORDS[${COMP_CWORD}]}")
    readarray -O "${#COMPREPLY[@]}" -t COMPREPLY < <(compgen -W "$(pacman -Qqs '.-git$')" "${COMP_WORDS[${COMP_CWORD}]}")
}
complete -F __update-aur-dep_compl update-aur-dep

__twitch_compl() {
    readarray -t COMPREPLY < <(compgen -W "$("$HOME/apps/twitch-online.bash")" "${COMP_WORDS[${COMP_CWORD}]}")
}
complete -F __twitch_compl twitch

__taskkill_compl() {
    readarray -t COMPREPLY < <(IFS=$'\n' compgen -W "$("$HOME/bin/tasklist")" "${COMP_WORDS[${COMP_CWORD}]}")
}
complete -F __taskkill_compl taskkill

complete -W 'increase decrease min max'  brightness
complete -W 'increase decrease toggle' volume
complete -W 'toggle manual timeout' kbacklight_ctl
complete -W 'android asan cov gcc no-cache release release-di time tsan werror' -o default my_cmake
complete -c wv
