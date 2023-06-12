#!/bin/bash

# BASH_COLOR_BLUE='$'\033''[34m'
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
        DIRNAME="$(dirname "$(realpath "$1")")"
        REQUEST="$({ for i in "$@"; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        COMPARE_TO="$({ for i in "$DIRNAME"/*; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        if [[ "$REQUEST" = "$COMPARE_TO" ]]; then
            if [[ "$DIRNAME" = "$HOME" ]]; then
                echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}You were about to remove everything in your home directory.${BASH_COLOR_NORMAL}"
                echo 'Aborting.'
                return 1
            fi
            if [[ "${*: -1}" = "*" ]]; then
                COUNT=0
            else
                COUNT="$#"
            fi
            echo "You are about to remove $COUNT thing$([[ $COUNT -ne 1 ]] && echo "s") from ${BASH_COLOR_BOLD}${BASH_COLOR_RED}$DIRNAME${BASH_COLOR_NORMAL}:"
            echo "$REQUEST" | head -n10
            NUMBER_OF_FILES="$(echo "$REQUEST" | wc -l)"
            if [[ "$NUMBER_OF_FILES" -gt 10 ]]; then
                echo "...and $((NUMBER_OF_FILES - 10)) more."
            fi
            echo -n 'Is that okay? [y/n] '
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
