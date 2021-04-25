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

_PROMPT_ERROR()
{
    # FIXME: perhaps merge this with the prompt function
    # local GOOD=(👍 😂 👌)
    local BAD=(👎 😭 😤)
    if [[ "$1" -eq 0 ]]; then
        :
        # echo ${GOOD[$RANDOM % ${#GOOD[@]}]}
    else
        echo -n " ${BAD[$RANDOM%${#BAD[@]}]}"
        echo -n " ${1}"
    fi
}

_GEN_PROMPT()
{
    # FIXME: make this code a littler cleaner, perhaps get rid of shell expansion completely and generate everything myself
    # ERROR has to be generated first, otherwise $? gets overwritten
    local ERROR="$(_PROMPT_ERROR "$?")"
    local USER="$(whoami | tr -d '\n')"
    local TEMPLATE_COLORLESS='\u@\h:\w'"$ERROR"
    local PREFIX_COLORLESS="${TEMPLATE_COLORLESS@P}"
    # 8 because eight characters for the date
    local NUM_SPACES="$((${COLUMNS} - ${#PREFIX_COLORLESS} - 8))"
    if [[ "$ERROR" ]]; then
        # Emojis actually take up two columns, but bash counts them as 1 character.
        NUM_SPACES="$(("$NUM_SPACES" - 1))"
    fi
    local SPACES="$(printf ' %.0s' $(seq 1 "${NUM_SPACES}"))"
    PS1='\[\033[01;32m\]'"${USER}"'@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[38;5;7;3m\]'"${ERROR}${SPACES}"'$(date "+%H:%M:%S" | tr -d '\n')\[\033[00m\]\n$ '
}

PROMPT_COMMAND=_GEN_PROMPT

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
