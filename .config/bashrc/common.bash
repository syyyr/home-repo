if [[ -z "$STY" ]] && screen -ls > /dev/null; then
    screen -wipe
fi

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL='ignoredups'

shopt -s histappend

HISTSIZE='50000'
HISTFILESIZE='50000'

_STATUS()
{
    echo -en '\033[38;5;7m\033[3m'
    date "+%H:%M:%S" | tr -d '\n'
    # local GOOD=(👍 😂 👌)
    local BAD=(👎 😭 😤)
    if [[ "$1" -eq 0 ]]; then
        :
        # echo ${GOOD[$RANDOM % ${#GOOD[@]}]}
    else
        echo -n " ${BAD[$RANDOM%${#BAD[@]}]}"
        echo -n " ${1}"
    fi
    echo -en '\033[0m'
}

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(_STATUS $?)\n$ '

stty susp undef
stty -ixon

# This cannot be done in .inputrc
bind -x '"\C-z":"fg &> /dev/null"'

eval "$(dircolors)"

source /usr/share/fzf/completion.bash
source "$HOME/.config/bashrc/alias.bash"
source "$HOME/.config/bashrc/colors.bash"
source "$HOME/.config/bashrc/completerc.bash"
source "$HOME/.config/bashrc/env.bash"
source "$HOME/.config/bashrc/functions.bash"
if [[ -f "$HOME/.config/bashrc/ignore.bash" ]]; then
    source "$HOME/.config/bashrc/ignore.bash"
fi
