#!/bin/bash

export BROWSER="wslbrowser"

# locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export LIBGL_ALWAYS_INDIRECT=1

if [[ -n "$DISPLAY" ]]; then
	xmodmap -e 'keycode 126='
fi
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

alias msvc='cmd cmd /k "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"'
alias wsl_clearcache="echo 1 | sudo tee /proc/sys/vm/drop_caches"
alias win_path="wslpath -w"

source "$HOME/.config/bashrc/common.bash"
