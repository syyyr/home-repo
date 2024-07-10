#!/bin/bash

export BROWSER="wslbrowser"

# locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export LIBGL_ALWAYS_INDIRECT=0
export LIBGL_ALWAYS_SOFTWARE=1

if [[ -n "$DISPLAY" ]]; then
	xmodmap -e 'keycode 126='
fi
export SDL_RENDER_DRIVER=software # We don't have hardware rendering on WSL, so let's just use software by default
export QMLSCENE_DEVICE=softwarecontext

alias msvc='cmd cmd /k "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"'
alias wsl_clearcache="echo 1 | sudo tee /proc/sys/vm/drop_caches"
alias win_path="wslpath -w"

source "$HOME/.config/bashrc/common.bash"
