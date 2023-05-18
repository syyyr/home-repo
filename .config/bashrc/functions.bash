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
    local CASE="--no-ignore-case" OPEN_ALL='0'
    while true; do
        case $1 in
            -a)
                OPEN_ALL='1'
                shift
                ;;
            -i)
                CASE='--ignore-case'
                shift
                ;;
            -ai)
                CASE='--ignore-case'
                OPEN_ALL='1'
                shift
                ;;
            -ia)
                CASE='--ignore-case'
                OPEN_ALL='1'
                shift
                ;;
            *)
                break
                ;;
        esac
    done

    local SEARCH_PATTERN

    local arg
    for arg in "$@"; do
        if [[ -d "$arg" || -r "$arg" ]]; then
            break
        fi

        SEARCH_PATTERN="${SEARCH_PATTERN:-}${SEARCH_PATTERN+ }$arg"
        shift
    done

    local SEARCH_LOCATIONS=()

    for arg in "$@"; do
        SEARCH_LOCATIONS=( "${SEARCH_LOCATIONS[@]}" "$arg" )
    done

    if [[ "$SEARCH_PATTERN" = "" ]]; then
        SEARCH_PATTERN="${SEARCH_LOCATIONS[0]}"
        SEARCH_LOCATIONS=( "${SEARCH_LOCATIONS[@]:1}" )
    fi

    # local is a command by itself, so first define local FILE and then assign,
    # so that the return code belongs to fzf
    if [[ "$OPEN_ALL" = "1" ]]; then
        local COLOR=--color=never
    else
        local COLOR=--color=always
    fi

    GREP_ARGS=( "$CASE" --exclude-dir=.git "$COLOR" -IHrn -e "$SEARCH_PATTERN" "${SEARCH_LOCATIONS[@]}" )

    echo "grep" "${GREP_ARGS[@]@Q}"
    local RESULTS
    if ! RESULTS="$(grep "${GREP_ARGS[@]}")"; then
        echo 'No match.' >&1
        return 0
    fi
    if [[ "$OPEN_ALL" = "1" ]]; then
        nvim -q <(echo "$RESULTS")
        return 0
    fi
    local FILE;
    FILE="$(fzf --tac -0 --height=50% --border --ansi --multi <<< "$RESULTS")"
    case "$?" in
        0)
            nvim -q <(echo "$FILE")
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
        DIRNAME="$(dirname "$(realpath "$1")")"
        REQUEST="$({ for i in "$@"; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        COMPARE_TO="$({ for i in "$DIRNAME"/*; do printf '%s\0' "$i"; done; } | xargs -0 realpath | sort)"
        if [[ "$DIRNAME" =~ ^$HOME$ ]]; then
            echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}You were about to remove your home directory.${BASH_COLOR_NORMAL}"
            echo 'Aborting.'
            return 1
        fi
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
            echo /usr/bin/rm -rf "${@@Q}"
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

bt_phone()
{
    if bluetoothctl info | grep -o 'Connected: yes'; then
        bluetoothctl disconnect
    else
        if [[ -z "$PHONE_BT_MAC" ]]; then
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

wv()
{
    vim "$(command -v "$1")"
}

android_mount()
{
    if mountpoint ~/mnt &> /dev/null; then
        echo Unmounting Android...
        umount ~/mnt
        echo Android unmounted.
    else
        echo Mounting Android...
        aft-mtp-mount ~/mnt && echo Android mounted.
    fi
}

git_generate_commit_graph()
{
    git commit-graph write --reachable --changed-paths
}

__update_aur_dep()
{
    pushd "$HOME/.local/aur/$1" || return 1
    git reset --hard
    MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --needed
    popd || return 1
}

do_auracle_update()
{
    local i
    for i in $(auracle -q outdated) $(pacman -Qqs .-git); do
        __update_aur_dep "$i" || return 1
    done
}

update_neovim()
{
    __update_aur_dep "neovim-git" || return 1
}

system_update()
{
    sudo pacman -Syu --noconfirm
    cd "$HOME/.local/aur" || return 1
    auracle outdated || echo "No outdated AUR packages."
    auracle update
    do_auracle_update
    cd "$HOME" || return 1
    git submodule update --remote
    echo Updating tree-sitter parsers...
    nvim --headless -c TSUpdateSync -c q
    echo # The output from nvim doesn't have a trailing newline
    git submodule summary
}

backtrace()
{
    vim -c 'lua vim.o.errorformat =[[%\s%#%m%# %f:%l:%c,%f:%l:%c: %m]]' -c "cfile $1"
}

ldapbase64decode()
{
    perl -MMIME::Base64 -n -00 -e 's/\n +//g;s/(?<=:: )(\S+)/decode_base64($1)/eg;print'
}

pacman_autoremove()
{
    pacman -Qdtq | sudo pacman -Rs -
}

check_config()
{
    luacheck -q "$HOME/.config/nvim" | grep -v 'Total:'
    shellcheck -a .config/bashrc/*
}
