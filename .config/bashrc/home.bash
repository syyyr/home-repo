#!/bin/bash
#
export BROWSER="wslbrowser"

# locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export LIBGL_ALWAYS_INDIRECT=1

# x server BS
if [ -z "$SSH_CLIENT" ]; then
    export RUNLEVEL="3"
    rm -rf "$HOME/.cache/sessions"
fi
xmodmap -e 'keycode 126='
export SDL_RENDER_DRIVER=software # We don't have hardware rendering on WSL, so let's just use software by default
export QMLSCENE_DEVICE=softwarecontext

# path BS
export PATH=""
export PATH="$HOME/.local/bin"
export PATH="/usr/bin/core_perl:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/cesnet/bin:$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" #default

alias wsl_clearcache="echo 1 | sudo tee /proc/sys/vm/drop_caches"

source "$HOME/.config/bashrc/common.bash"
