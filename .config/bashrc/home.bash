# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

umask 022

export BROWSER=wslbrowser

#locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export DISPLAY=localhost:0

#win cmd autocomplete BS
source $HOME/.rustup-comp

#screen BS
export SCREENDIR=$HOME/.screen

#x server BS
if [ -z "$SSH_CLIENT" ]; then
export DISPLAY=localhost:0
export XDG_RUNTIME_DIR=/home/vk/test
export RUNLEVEL=3
rm -rf .cache/sessions
fi
xmodmap -e 'keycode 126='

#path BS
PATH=""
PATH="$HOME/.local/bin"
PATH="/usr/bin/core_perl:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" #default

source $HOME/.config/bashrc/alias.bash
source $HOME/.config/bashrc/common.bash
source $HOME/.config/bashrc/env.bash
source $HOME/.config/bashrc/functions.bash
