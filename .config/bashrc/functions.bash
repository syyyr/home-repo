#!/bin/bash

BASH_COLOR_BLUE=$'\033''[34m'
BASH_COLOR_BOLD=$'\033''[1m'
# BASH_COLOR_CYAN=$'\033''[36m'
# BASH_COLOR_GREEN=$'\033''[32m'
# BASH_COLOR_LIGHTGRAY='$'\033''[37m'
BASH_COLOR_NORMAL=$'\033''[0m'
# BASH_COLOR_ORANGE=$'\033''[33m'
# BASH_COLOR_PURPLE=$'\033''[35m'
BASH_COLOR_RED=$'\033''[31m'

rm()
{
    if [[ "$1" = "-rf" ]] && [[ "$#" -gt "1" ]]; then
        shift
        local DIRNAME="$(dirname "$(realpath "$1")")"
        local REQUEST="$({ for i in "$@"; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        local COMPARE_TO="$({ for i in "$DIRNAME"/*; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        if [[ "$REQUEST" = "$COMPARE_TO" ]]; then
            if [[ "$DIRNAME" = "$HOME" ]]; then
                echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}You were about to remove everything in your home directory.${BASH_COLOR_NORMAL}"
                echo 'Aborting.'
                return 1
            fi
            if [[ "${*: -1}" = "*" ]]; then
                local COUNT=0
            else
                local COUNT="$#"
            fi
            echo "You are about to remove $COUNT thing$([[ $COUNT -ne 1 ]] && echo "s") from ${BASH_COLOR_BOLD}${BASH_COLOR_RED}$DIRNAME${BASH_COLOR_NORMAL}:"
            echo "$REQUEST" | head -n10
            local NUMBER_OF_FILES="$(echo "$REQUEST" | wc -l)"
            if [[ "$NUMBER_OF_FILES" -gt 10 ]]; then
                echo "...and $((NUMBER_OF_FILES - 10)) more."
            fi
            echo -n 'Is that okay? [y/n] '
            local REPLY
            if ! read -r -t 10; then
                echo
                echo 'No reply. Aborting just to be safe.'
                return 1
            fi

            if [[ "$REPLY" != "y" ]]; then
                echo 'Aborting.'
                return 1
            fi
            echo rm -rf "${@@Q}"
        fi
        env rm -rf "$@"
        return "$?"
    fi

    env rm "$@"
}

try()
{
    while ! "$@"; do
        sleep 0.1;
    done
}

try_not()
{
    while "$@"; do
        sleep 0.1;
    done
}

add_overrides() {
    SCRIPT='. + {overrides:{}}'
    for PACKAGE_PATH in "$@"; do
        npm install "$PACKAGE_PATH"
        PACKAGE="$(jq -r .name "$PACKAGE_PATH/package.json")"
        SCRIPT+=" | . + {overrides: .overrides + {\"$PACKAGE\": \"\$$PACKAGE\"}}"
    done

    echo jq "$SCRIPT" package.json
    NEW_PACKAGE_JSON="$(jq "$SCRIPT" package.json)"
    echo "$NEW_PACKAGE_JSON" > package.json
}

__info_log() {
    BASH_BLUE_BOLD="${BASH_COLOR_BOLD}${BASH_COLOR_BLUE}"
    echo -ne "${BASH_BLUE_BOLD}$*${BASH_COLOR_NORMAL}"
}

__detect_and_run() {
    if [[ "${#ORIG_GIT[@]}" -gt "$#" ]]; then
        return 1
    fi
    local INDEX
    local ARG_REGEXES=("$@")
    for INDEX in $(seq 0 "$(("${#ARG_REGEXES[@]}" - 1))"); do
        if ! [[ "${ORIG_GIT[$INDEX]:-}" =~ ^${ARG_REGEXES[$INDEX]}$ ]]; then
            return 1
        fi
    done
    OUTPUT="$(command "${ORIG_GIT[@]}" 2>&1)"
    CODE="$?"
    echo "$OUTPUT"
}

__ask_user_to_run() {
    __info_log "Do you want to run '${NEW_COMMAND[*]}' ? [y/n] "
    if ! read -r -t 10; then
        echo
        return "$CODE"
    fi

    if [[ "${REPLY}" != "y" ]]; then
        exit "$CODE"
    fi

    echo "${NEW_COMMAND[@]}"
    "${NEW_COMMAND[@]}"
    exit "$?"
}

__fix_git_switch_c() {
    if ! [[ "$OUTPUT" =~ fatal:\ a\ branch\ named\ \'([^[:space:]]+)\'\ already\ exists ]]; then
        exit "$CODE"
    fi

    BRANCH_NAME="${BASH_REMATCH[1]}"

    echo
    __info_log "Branch '$BRANCH_NAME' points to:\n"
    git show  --abbrev --oneline --no-patch main

    NEW_COMMAND=("${ORIG_GIT[@]}")
    NEW_COMMAND[2]="-C"

    __ask_user_to_run
}

# I am making this a bash function so that it doesn't mess with non-interactive scripts.
git() (
    ORIG_GIT=(git "$@")

    __detect_and_run git switch -c '\S+' '\S*' && __fix_git_switch_c

    command "${ORIG_GIT[@]}"
)
