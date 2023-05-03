#!/bin/bash

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

format_exec_time()
{
    MILLI="$1"
    echo "$MILLI" | bc <(echo '
        input = read();
        min = input/60/1000;
        if (min >= 180) { /* after three hours, well also show hours */
            hours = min/60;
            print hours
            print "h ";
            input-=hours*60*60*1000;
        }
        min = input/60/1000;
        if (min >= 3) { /* from three minutes onward, we will show to output in the XXm XX.XXs format. */
            print min;
            print "m ";
            input-=min*60*1000;
        }
        scale=3;
        sec=input/1000;
        if (sec < 1) {
            print "0";
        }
        print sec;
        print "s";
    ')
}

_GEN_PROMPT()
{
    # Have to save the error code, otherwise it'll by be overwritten immediately (by the `[[` command).
    local CODE="$?"
    if [[ "$CODE" -ne 0 ]]; then
        local BAD=(👎 😭 😤)
        local ERROR=" ${BAD[$RANDOM%${#BAD[@]}]} $CODE"
    fi

    if [[ -n "$_COMMAND_START_TIME" ]]; then
        local CURRENT_TIME
        CURRENT_TIME="$(date '+%s%3N' | tr -d '\n')"
        # If the execution time is less than 1 second, don't bother showing the execution time. It won't be too precise anyway.
        if [[ $(("$CURRENT_TIME" - "$_COMMAND_START_TIME")) -ge 1000 ]]; then
            local LAST_COMMAND_DURATION
            LAST_COMMAND_DURATION=" ($(format_exec_time $(("$CURRENT_TIME" - "$_COMMAND_START_TIME"))))"
        fi
        unset _COMMAND_START_TIME
    fi

    local TITLE=$'\033'']0;' GREEN_BOLD=$'\033''[01;32m' BLUE_BOLD=$'\033''[01;34m' GRAY=$'\033''[00;38;5;7m' CURSIVE_GRAY=$'\033''[00;38;5;7;3m' NORMAL_COLOR=$'\033''[00m'

    local USER_HOST WORKDIR GIT_ROOT_DIR GIT_INFO TIME
    USER_HOST="$(whoami)@$(hostname)"
    WORKDIR="$(dirs +0)"
    GIT_ROOT_DIR="$(git rev-parse --show-toplevel 2> /dev/null)"
    if [[ -n "$GIT_ROOT_DIR" && "$GIT_ROOT_DIR" != "$HOME" ]]; then
        GIT_INFO=" $(git branch | sed -r -n '/^\* /{s/\* //;s/HEAD detached (at|from) //;p}' | tr -d '()')"
        REMOTE_BRANCH="${GIT_INFO# }"
        REMOTE_BRANCH="origin/${REMOTE_BRANCH#origin/}"
        if ! [[ "${GIT_INFO# }" =~ rebasing ]] && ! [[ "${GIT_INFO# }" =~ "bisect started" ]] && timeout 0.1 git diff --quiet "$REMOTE_BRANCH" "$(git rev-parse HEAD)" -- &> /dev/null; then
            GIT_INFO="${GIT_INFO}="
        fi
        SYMBOLS=""
        if ! timeout 0.1 git diff --quiet; then
            SYMBOLS+="+"
        fi
        if ! timeout 0.1 git diff --cached --quiet; then
            SYMBOLS+="*"
        fi
        if [[ -n "$SYMBOLS" ]]; then
            GIT_INFO="${GIT_INFO} [${SYMBOLS}]"
        fi
    fi
    GIT_INFO="${GIT_INFO:-}"
    TIME="$(printf "%(%H:%M:%S)T")"

    local PROMPT_COLORLESS="${USER_HOST}:${WORKDIR} ${GIT_INFO}${ERROR}"
    # Eight characters for the date.
    local NUM_SPACES="$((COLUMNS - ${#PROMPT_COLORLESS} - ${#LAST_COMMAND_DURATION} - 8))"
    if [[ -n "$ERROR" ]]; then
        # Emojis actually take up two columns, but bash counts them as 1 character.
        NUM_SPACES="$(("$NUM_SPACES" - 1))"
    fi
    local SPACES
    SPACES="$(printf "%${NUM_SPACES}s")"

    # Set the title.
    echo -en "${TITLE}${USER_HOST}:${WORKDIR}\a"

    PS1="${GREEN_BOLD}${USER_HOST}${NORMAL_COLOR}:${BLUE_BOLD}${WORKDIR}${GRAY}${GIT_INFO}${ERROR}${SPACES}${CURSIVE_GRAY}${TIME}${LAST_COMMAND_DURATION}${NORMAL_COLOR}"'\n$ '
}

PROMPT_COMMAND=_GEN_PROMPT

_SAVE_STARTUP_TIME()
{
      if [[ "$BASH_COMMAND" = "$PROMPT_COMMAND" ]]; then
          return
      fi
    _COMMAND_START_TIME="$(date '+%s%3N' | tr -d '\n')"
}

trap _SAVE_STARTUP_TIME DEBUG

stty susp undef
stty -ixon

# This cannot be done in .inputrc
bind -x '"\C-z":"fg &> /dev/null"'

eval "$(dircolors | sed 's/ow=34;42:/ow=30;42:/')"

source /usr/share/fzf/completion.bash
source "$HOME/.config/bashrc/alias.bash"
source "$HOME/.config/bashrc/completerc.bash"
source "$HOME/.config/bashrc/env.bash"
source "$HOME/.config/bashrc/functions.bash"
if [[ -f "$HOME/.config/bashrc/ignore.bash" ]]; then
    source "$HOME/.config/bashrc/ignore.bash"
fi
