#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

if [[ "${STY+x}" != x ]] && screen -ls > /dev/null; then
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
        if (min >= 3) { /* from three minutes onward, we'll show the output in the XXm XX.XXs format. */
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
    local USER_HOST="$USER@$HOSTNAME" WORKDIR="$(dirs +0)" TIME="$(printf "%(%H:%M:%S)T")" BAD=(👎 😭 😤) CURRENT_TIME="$(date '+%s%3N')" GIT_INFO="" ERROR="" LAST_COMMAND_DURATION=""
    if ((CODE)); then
        ERROR=" ${BAD[$RANDOM%3]} $CODE"
    fi

    # If the execution time is less than 1 second, don't bother showing the execution time. It won't be too precise anyway.
    if [[ $((CURRENT_TIME - _COMMAND_START_TIME)) -ge 1000 ]]; then
        LAST_COMMAND_DURATION=" ($(_FORMAT_EXEC_TIME $((CURRENT_TIME - _COMMAND_START_TIME))))"
    fi

    if GIT_ROOT_DIR="$(timeout 0.1 git rev-parse --show-toplevel 2> /dev/null)"; then
        local BASH_REMATCH
        if [[ "$GIT_ROOT_DIR" != "$HOME" ]]; then
            GIT_INFO=" $(git branch | sed -r -n '/^\* /{s/\* //;s/HEAD detached (at|from) //;p}' | tr -d '()')"
            local REMOTE_BRANCH="${GIT_INFO# }"
            if ! [[ "${GIT_INFO# }" =~ rebasing ]] && ! [[ "${GIT_INFO# }" =~ "bisect started" ]] && timeout 0.1 git diff --quiet "origin/${REMOTE_BRANCH#origin/}" "$(git rev-parse HEAD)" -- &> /dev/null; then
                GIT_INFO+="="
            fi
        else
            if [[ "$(git rev-list --left-right --count origin/main...HEAD)" =~ (([0-9]+)$'\t'([0-9]+)) ]] && [[ ${BASH_REMATCH[3]} != 0 ]]; then
                GIT_INFO+=" (+${BASH_REMATCH[3]})"
            fi
        fi
        local GIT_SYMBOLS=""
        if ! timeout 0.1 git diff --quiet > /dev/null; then
            GIT_SYMBOLS+="+"
        fi
        if ! timeout 0.1 git diff --cached --quiet > /dev/null; then
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
        NUM_SPACES="$((NUM_SPACES - 1))"
    fi

    # Set the title.
    echo -en $'\033'']0;'"${USER_HOST}:${WORKDIR}\a"

    PS1="\[\e[01;32m\]${USER_HOST}\[\e[00m\]:\[\e[01;34m\]${WORKDIR}\[\e[00;38;5;7m\]${GIT_INFO}${ERROR}$(printf "%${NUM_SPACES}s")\[\e[00;38;5;7;3m\]${TIME}${LAST_COMMAND_DURATION}\[\e[00m\]"'\n$ '
    # END_PROMPT="$(date '+%s%3N')"
    # _FORMAT_EXEC_TIME $((END_PROMPT - CURRENT_TIME))
    # echo
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
