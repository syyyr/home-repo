#!/bin/bash

_vimrc_complete() {
    # TODO: This has to be improved to work with after/. If I type ftplugin/, I don't want the after/ directory.
    # Maybe I'll use fzf for this.
    COMPREPLY+=($( cd ~/.config/nvim; find -not -name "\.*" -type f | sed s@\./@@ | grep -F "$2" ))
}

_bashrc_complete() {
    COMPREPLY+=($( cd ~/.config/bashrc; find -not -name "\.*" -type f | sed s@\./@@ | grep -F "$2"))
}

complete -W "up down silent show quiet min max"  brightness
complete -W "up down toggle silent show quiet" volume
complete -W "pulse cycle manual timeout" kbdlightctl
complete -C "$HOME/bin/tasklist" taskkill
complete -F _vimrc_complete vimrc
complete -F _bashrc_complete bashrc
complete -C "$HOME/apps/twitch_online.bash" twitch
