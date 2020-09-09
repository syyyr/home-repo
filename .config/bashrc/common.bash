if [ -z "$STY" ]; then
screen -wipe | sed '/No Sockets found in/Q'
fi

case $- in
    *i*) ;;
      *) return;;
esac
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL='ignoredups'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE='50000'
HISTFILESIZE='50000'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt='yes';;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

_STATUS()
{
    local GOOD=(👍 😂 👌)
    local BAD=(👎 😭 😤)
    if [[ $1 = 0 ]]; then
        echo #${GOOD[$RANDOM % ${#GOOD[@]}]}
    else
        echo -n "${BAD[$RANDOM%${#BAD[@]}]}"
        echo -e ' \033[38;5;7m\033[3m'${1}'\033[0m'
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(_STATUS $?)\n$ '
else
    PS1='\u@\h:\w\$ '
fi

if [ -n "$SSH_CLIENT" ]; then
    PS1='\[\033[38;5;83m\]\u@\h\[\033[00m\]:\[\033[38;5;63m\]\w\[\033[00m\]\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

bind '"\e[18~":""'
stty susp undef
stty -ixon
bind -x '"\C-z":"fg &> /dev/null"'
source /usr/share/fzf/completion.bash
source "$HOME/.config/bashrc/completerc.bash"
