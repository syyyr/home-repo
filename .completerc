#!/bin/bash

_brightness_complete() {
    COMPREPLY+=($( compgen -W "up down toggle silent show quiet min max" "$2" ) )
}

_volume_complete() {
    COMPREPLY+=($( compgen -W "up down toggle silent show quiet" "$2" ) )
}

_kbd_pulsectl_complete() {
    COMPREPLY+=($( compgen -W "pulse cycle manual timeout" "$2" ) )
}

_taskkill_complete() {
    COMPREPLY+=($( compgen -W "$(tasklist)" "$2" ))
}

_vimrc_complete() {
    # TODO: This has to be improved to work with after/. If I type ftplugin/, I don't want the after/ directory.
    # Maybe I'll use fzf for this.
    COMPREPLY+=($( cd ~/.config/nvim; find -not -name "\.*" -type f | sed s@\./@@ | grep -F "$2" ))
}

_bashrc_complete() {
    COMPREPLY+=($( cd ~/.config/bashrc; find -not -name "\.*" -type f | sed s@\./@@ | grep -F "$2"))
}
complete -F _brightness_complete brightness
complete -F _volume_complete volume
complete -F _kbd_pulsectl_complete kbdlightctl
complete -F _taskkill_complete taskkill
complete -F _vimrc_complete vimrc
complete -F _bashrc_complete bashrc
