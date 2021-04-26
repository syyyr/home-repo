export BROWSER="wslbrowser"

# locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

# win cmd autocomplete BS
source "$HOME/.rustup-comp"

# x server BS
if [ -z "$SSH_CLIENT" ]; then
export RUNLEVEL="3"
rm -rf "$HOME/.cache/sessions"
fi
xmodmap -e 'keycode 126='
export SDL_RENDER_DRIVER=software # We don't have hardware rendering on WSL, so let's just use software by default

# path BS
PATH=""
PATH="$HOME/.local/bin"
PATH="/usr/bin/core_perl:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" #default

source "$HOME/.config/bashrc/common.bash"
