# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

umask 022

export BROWSER=wslbrowser

#locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#export HOMEPC="yes"
export DISPLAY=localhost:0

#win cmd autocomplete BS
source $HOME/.completerc
source $HOME/.rustup-comp

#screen BS
export SCREENDIR=$HOME/.screen
if [ -z "$STY" ]; then
screen -wipe | sed '/No Sockets found in/Q'
fi

#x server BS
if [ -z "$SSH_CLIENT" ]; then
export DISPLAY=localhost:0
export XDG_RUNTIME_DIR=/home/vk/test
export RUNLEVEL=3
if [ -z "$(find /var/run/dbus 2> /dev/null)" ]; then
: #sudo mkdir /var/run/dbus
fi
if [ -z "$(find /var/run/dbus/pid 2> /dev/null)" ]; then
: #sudo dbus-daemon --config-file=/usr/share/dbus-1/system.conf
fi
rm -rf .cache/sessions
fi

#path BS
PATH=""
PATH="$HOME/.local/bin"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/bin/core_perl:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/lib/go-1.9/bin:$PATH"
PATH="$HOME/apps/b_dogecoin-1.10.0/bin:$PATH"
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/gcc-4.7-mipsel/bin:$PATH"
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" #default
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

source ~/.config/bashrc/alias.bash
source ~/.config/bashrc/common.bash
source ~/.config/bashrc/env.bash
source ~/.config/bashrc/functions.bash