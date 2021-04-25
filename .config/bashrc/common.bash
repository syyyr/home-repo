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

expand_prompt()
{
    echo -n "${1@P}"
}

_GEN_PROMPT()
{
    # ERROR has to be generated first, otherwise $? gets overwritten
    local ERROR="$(_PROMPT_ERROR "$?")"
    local GREEN_BOLD=$'\033''[01;32m' BLUE_BOLD=$'\033''[01;34m' CURSIVE_GRAY=$'\033''[00;38;5;7;3m' NORMAL_COLOR=$'\033''[00m'
    local USER_HOST="$(expand_prompt '\u@\h')"
    local WORKDIR="$(expand_prompt '\w')"
    local PROMPT_COLORLESS="${USER_HOST}:${WORKDIR}${ERROR}"
    local TIME="$(date "+%H:%M:%S" | tr -d '\n')"
    # Eight characters for the date.
    local NUM_SPACES="$((${COLUMNS} - ${#PROMPT_COLORLESS} - 8))"
    if [[ "$ERROR" ]]; then
        # Emojis actually take up two columns, but bash counts them as 1 character.
        NUM_SPACES="$(("$NUM_SPACES" - 1))"
    fi
    local SPACES="$(printf ' %.0s' $(seq 1 "${NUM_SPACES}"))"
    PS1="${GREEN_BOLD}${USER_HOST}${NORMAL_COLOR}:${BLUE_BOLD}${WORKDIR}${CURSIVE_GRAY}${ERROR}${SPACES}${TIME}${NORMAL_COLOR}"'\n$ '
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
