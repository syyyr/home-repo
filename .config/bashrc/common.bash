#!/bin/bash

if [[ -z "$STY" ]] && screen -ls > /dev/null; then
    screen -wipe
fi

case $- in
    *i*) ;;
      *) return;;
esac

stty susp undef
stty -ixon
shopt -s histappend

# This cannot be done in .inputrc
bind -x '"\C-z":"fg &> /dev/null"'

eval "$(dircolors | sed 's/ow=34;42:/ow=30;42:/')"

_FORMAT_EXEC_TIME()
{
    MILLI="$1"
    bc <(cat <<EOF
        input = read();
        min = input/60/1000;
        if (min >= 180) { /* after three hours, we'll also show hours */
            hours = min/60;
            print hours
            print "h ";
            input-=hours*60*60*1000;
        }
        min = input/60/1000;
        if (min >= 3) { /* from three minutes onward, we'll show to output in the XXm XX.XXs format. */
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
EOF
    ) <<< "$MILLI"
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
        local CURRENT_TIME="$(date '+%s%3N' | tr -d '\n')"
        # If the execution time is less than 1 second, don't bother showing the execution time. It won't be too precise anyway.
        if [[ $(("$CURRENT_TIME" - "$_COMMAND_START_TIME")) -ge 1000 ]]; then
            local LAST_COMMAND_DURATION=" ($(_FORMAT_EXEC_TIME $(("$CURRENT_TIME" - "$_COMMAND_START_TIME"))))"
        fi
        unset _COMMAND_START_TIME
    fi

    local TITLE=$'\033'']0;' GREEN_BOLD=$'\033''[01;32m' BLUE_BOLD=$'\033''[01;34m' GRAY=$'\033''[00;38;5;7m' CURSIVE_GRAY=$'\033''[00;38;5;7;3m' NORMAL_COLOR=$'\033''[00m'

    local USER_HOST="$(whoami)@$(hostname)" WORKDIR="$(dirs +0)" GIT_ROOT_DIR="$(git rev-parse --show-toplevel 2> /dev/null)" TIME="$(printf "%(%H:%M:%S)T")" COMMITS
    if [[ -n "$GIT_ROOT_DIR" ]]; then
        local GIT_INFO=""
        if [[ "$GIT_ROOT_DIR" != "$HOME" ]]; then
            GIT_INFO=" $(git branch | sed -r -n '/^\* /{s/\* //;s/HEAD detached (at|from) //;p}' | tr -d '()')"
            local REMOTE_BRANCH="${GIT_INFO# }"
            REMOTE_BRANCH="origin/${REMOTE_BRANCH#origin/}"
            if ! [[ "${GIT_INFO# }" =~ rebasing ]] && ! [[ "${GIT_INFO# }" =~ "bisect started" ]] && timeout 0.1 git diff --quiet "$REMOTE_BRANCH" "$(git rev-parse HEAD)" -- &> /dev/null; then
                GIT_INFO="${GIT_INFO}="
            fi
        else
            if COMMITS=$(git status | grep -Eo "[0-9]+ commit" | grep -Eo '[0-9]'+); then
                GIT_INFO="${GIT_INFO} (+${COMMITS})"
            fi
        fi
        local GIT_SYMBOLS=""
        if ! timeout 0.1 git diff --quiet; then
            GIT_SYMBOLS+="+"
        fi
        if ! timeout 0.1 git diff --cached --quiet; then
            GIT_SYMBOLS+="*"
        fi
        if [[ -n "$GIT_SYMBOLS" ]]; then
            GIT_INFO+=" [${GIT_SYMBOLS}]"
        fi
    fi

    local PROMPT_COLORLESS="${USER_HOST}:${WORKDIR} ${GIT_INFO}${ERROR}"
    # Eight characters for the date.
    local NUM_SPACES="$((COLUMNS - ${#PROMPT_COLORLESS} - ${#LAST_COMMAND_DURATION} - 8))"
    if [[ -n "$ERROR" ]]; then
        # Emojis actually take up two columns, but bash counts them as 1 character.
        NUM_SPACES="$(("$NUM_SPACES" - 1))"
    fi
    local SPACES="$(printf "%${NUM_SPACES}s")"

    # Set the title.
    echo -en "${TITLE}${USER_HOST}:${WORKDIR}\a"

    PS1="${GREEN_BOLD}${USER_HOST}${NORMAL_COLOR}:${BLUE_BOLD}${WORKDIR}${GRAY}${GIT_INFO}${ERROR}${SPACES}${CURSIVE_GRAY}${TIME}${LAST_COMMAND_DURATION}${NORMAL_COLOR}"'\n$ '
}

_SAVE_STARTUP_TIME()
{
    if [[ "$BASH_COMMAND" = "$PROMPT_COMMAND" ]]; then
        return
    fi
    _COMMAND_START_TIME="$(date '+%s%3N' | tr -d '\n')"
}

PROMPT_COMMAND=_GEN_PROMPT
trap _SAVE_STARTUP_TIME DEBUG

source /usr/share/fzf/completion.bash
source "$HOME/.config/bashrc/alias.bash"
source "$HOME/.config/bashrc/completerc.bash"
source "$HOME/.config/bashrc/env.bash"
source "$HOME/.config/bashrc/functions.bash"
if [[ -f "$HOME/.config/bashrc/ignore.bash" ]]; then
    source "$HOME/.config/bashrc/ignore.bash"
fi
