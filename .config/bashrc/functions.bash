#!/bin/bash

# BASH_COLOR_BLUE='\033[34m'
BASH_COLOR_BOLD='\033[1m'
# BASH_COLOR_CYAN='\033[36m'
# BASH_COLOR_GREEN='\033[32m'
# BASH_COLOR_LIGHTGRAY='\033[37m'
BASH_COLOR_NORMAL='\033[0m'
# BASH_COLOR_ORANGE='\033[33m'
# BASH_COLOR_PURPLE='\033[35m'
BASH_COLOR_RED='\033[31m'

res()
{
    "$HOME/apps/check-available.bash"  cvt || return 1

    if [[ "$#" -ne 4 ]]; then
        echo 'usage: res <xrandr output> <x> <y> <hz>'
        return
    fi
    echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode"
    cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode
    echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode $1"
    cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode "$1"
    echo "xrandr --output $1 --mode $(cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2)"
    xrandr --output "$1" --mode "$(tr -d '"' <<< "$(cvt12 "$2" "$3" "$4" -b | tail -1 | cut -d' ' -f2)")"
}

gso()
{
    while true; do
        case $1 in
            -a)
                local OPEN_ALL='1'
                shift
                ;;
            -i)
                local CASE='-i'
                shift
                ;;
            -ai)
                local CASE='-i'
                local OPEN_ALL='1'
                shift
                ;;
            -ia)
                local CASE='-i'
                local OPEN_ALL='1'
                shift
                ;;
            *)
                break
                ;;
        esac
    done

    if [[ $# -gt 1 ]] && [[ -d "${*: -1}" || -r "${*: -1}" ]]; then
        local ARGS=( "${@:1:$#-1}" )
        local DIRECTORY=( "${@: -1}" )
    else
        local ARGS=( "$@" )
    fi

    # local is a command by itself, so first define local FILE and then assign,
    # so that the return code belongs to fzf
    local FILE
    if (("$OPEN_ALL")); then
        local COLOR=
    else
        local COLOR=--color=always
    fi

    echo "grep $CASE --exclude-dir=.git -IHrn $COLOR ${ARGS[*]} ${DIRECTORY[*]}"
    local RESULTS
    RESULTS="$(grep $CASE --exclude-dir=.git -IHrn $COLOR "${ARGS[@]}" "${DIRECTORY[@]}")"
    if [[ "$RESULTS" = '' ]]; then
        echo 'No match.' >&1
        return 0
    fi
    if (("$OPEN_ALL")); then
        nvim -q <(cat <<< "$RESULTS")
        return 0
    fi
    FILE="$(fzf --tac -0 --height=50% --border --ansi <<< "$RESULTS")"
    case "$?" in
        0)
            local VIM_ARG
            IFS=" " read -r -a VIM_ARG <<< "$(sed -E 's/([^:]+):([^:]+):.*/\1 +\2/' <<< "$FILE")"
            vim "${VIM_ARG[@]}"
            ;;
        1)
            echo "fzf: No match. This shouldn't happen." >&1
            ;;
        2)
            echo 'fzf: Error.' >&1
            ;;
        130)
            ;;
        *)
            echo 'error.' >&1
    esac
}

string_diff()
{
    "$HOME/apps/check-available.bash" dwdiff || return 1

    if [[ "$*" =~ "==" ]]; then
        local LEFT RIGHT
        LEFT=$(grep ".* == " -o <<< "$*" | sed 's/ == //')
        RIGHT=$(grep " == .*" -o <<< "$*" | sed 's/ == //')
        dwdiff -c <(echo "$LEFT") <(echo "$RIGHT")
    else
        dwdiff -c <(echo "$1") <(echo "$2")
    fi
}

twitch()
{
    "$HOME/apps/check-available.bash" streamlink google-chrome-stable || return 1
    if [[ $# != 1 ]]; then
        "$HOME/apps/twitch-online.bash"
        return 0
    fi
    google-chrome-stable --new-window "https://www.twitch.tv/popout/$1/chat"
    streamlink -v "http://twitch.tv/$1" best
}

rm()
{
    if [[ "$1" = "-rf" ]] && [[ "$#" -gt "1" ]]; then
        shift
        DIRNAME="$(realpath "$1" | xargs dirname)"
        REQUEST="$(echo "$*" | xargs realpath | sort)"
        COMPARE_TO="$(echo "$DIRNAME"/* | xargs realpath | sort)"
        if [[ "$REQUEST" =~ ^$HOME$ ]]; then
            echo -e "${BASH_COLOR_BOLD}${BASH_COLOR_RED}You were about to remove your home directory.${BASH_COLOR_NORMAL}"
            echo 'Aborting.'
            return 1
        fi
        if [[ "$REQUEST" = "$COMPARE_TO" ]]; then
            if [[ "$DIRNAME" = "$HOME" ]]; then
                echo -e "${BASH_COLOR_BOLD}${BASH_COLOR_RED}You were about to remove everything in your home directory.${BASH_COLOR_NORMAL}"
                echo 'Aborting.'
                return 1
            fi
            if [[ "${*: -1}" = "*" ]]; then
                COUNT=0
            else
                COUNT="$#"
            fi
            echo -e "You are about to remove $COUNT thing$([[ $COUNT -ne 1 ]] && echo "s") from ${BASH_COLOR_BOLD}${BASH_COLOR_RED}$DIRNAME${BASH_COLOR_NORMAL}:"
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
            echo /usr/bin/rm -rf "$@"
        fi
        /usr/bin/rm -rf "$@"
        return "$?"
    fi

    /usr/bin/rm "$@"
}

try()
{
    while ! "$@"; do sleep 0.1; done
}

do_auracle_update()
{
    for i in $(auracle -q outdated); do
        pushd "$i" || return
        git reset --hard
        MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --nocheck
        popd || return
    done
}

bt_phone()
{
    if bluetoothctl info | grep -o 'Connected: yes'; then
        bluetoothctl disconnect
    else
        if [[ -z "$PHONE_BT_MAC" ]]; then
            # shellcheck disable=SC2016
            echo '$PHONE_BT_MAC is not set, unable to connect to phone'.  >&2
            return 1
        fi
        bluetoothctl connect "$PHONE_BT_MAC"
    fi

    py3-cmd refresh bluetooth
}

pulse_mono()
{
    pacmd load-module module-remap-sink sink_name=mono master="$(pacmd list-sinks | grep -m 1 -oP 'name:\s<\K.*(?=>)')" channels=1 channel_map=mono
}

gen_cov()
{
    llvm-profdata merge -sparse default.profraw -o default.profdata
    llvm-cov show --instr-profile=default.profdata "$1" --format=html --ignore-filename-regex='3rdparty|autogen'
}

which-vim()
{
    vim "$(which "$1")"
}

android_mount()
{
    if mountpoint ~/mnt > /dev/null; then
        echo Unmounting Android...
        umount ~/mnt
        echo Android unmounted.
    else
        echo Mounting Android...
        aft-mtp-mount ~/mnt
        echo Android mounted.
    fi
}

git_generate_commit_graph()
{
    git commit-graph write --reachable --changed-paths
}

update_neovim()
{
    pushd "$HOME/.local/aur/neovim-git" || return 1
    makepkg -si
    popd || return 1
}
