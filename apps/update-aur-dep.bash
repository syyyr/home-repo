#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

readonly BASH_COLOR_BOLD=$'\033''[1m' BASH_COLOR_RED=$'\033''[31m' BASH_BLUE_BOLD=$'\033''[01;34m' BASH_COLOR_NORMAL=$'\033''[0m' AUR_DEP="$1"
shift

info() {
    if [[ "$1" = "-n" ]]; then
        local ARGS=("-n")
        local TEXT="$2"
    else
        local ARGS=()
        local TEXT="$1"
    fi
    ARGS+=("${BASH_BLUE_BOLD}$TEXT${BASH_COLOR_NORMAL}")
    echo "${ARGS[@]}"
}

remove_build_dir() {
    echo "Removing $HOME/.local/aur/$AUR_DEP/src..."
    rm -rf "$HOME/.local/aur/$AUR_DEP/src"
}

ADDITIONAL_ARGS=("$@")
NO_CONFIRM=(--noconfirm --needed)
UPDATE_COMMAND=(env DEBUGINFOD_URLS="https://debuginfod.archlinux.org" CTEST_PARALLEL_LEVEL="$(nproc)" GNUMAKEFLAGS="-j$(nproc)" makepkg -si "${ADDITIONAL_ARGS[@]}")
UPDATE_COMMAND_INPUT=(true)

if [[ " ${ADDITIONAL_ARGS[*]} " =~ [[:space:]]-f[[:space:]] ]]; then
    UPDATE_COMMAND_INPUT=(echo -en "y\ny")
    NO_CONFIRM=()
    echo "Forcing building and installation of package."
fi

readonly DEP_DIR="$HOME/.local/aur/$AUR_DEP"
if ! [[ -d "$DEP_DIR" ]]; then
    auracle clone --chdir="$HOME/.local/aur" "$AUR_DEP"
fi
cd "$DEP_DIR" || exit 1
git fetch
git reset --hard origin/master

readonly AUTOREMOVE_PKGS=(
    cmake-language-server-git
    kddockwidgets
    mingw-w64-jasper
    mingw-w64-trompeloeil
    mingw-w64-vulkan-headers
    mingw-w64-vulkan-icd-loader
    shvcli-git
)

# https://aur.archlinux.org/packages/mingw-w64-curl#comment-965704
if grep \
    -e mingw-w64-curl \
    -e mingw-w64-gettext <<< "$AUR_DEP"; then
    export WINEPREFIX=/nonexistent
fi

while true; do
    info "Building $AUR_DEP..."

    for i in "${AUTOREMOVE_PKGS[@]}"; do
        if [[ "$i" = "$AUR_DEP" ]]; then
            info "Automatically removing build dir for $AUR_DEP."
            remove_build_dir
        fi
    done; unset i

    if "${UPDATE_COMMAND_INPUT[@]}" | "${UPDATE_COMMAND[@]}" "${NO_CONFIRM[@]}"; then
        exit 0
    fi

    echo "Building $AUR_DEP failed."
    info -n "Try again [(t)ry_again,(g)ive_up,(n)ocheck,(s)kippgpcheck,(r)emove_build_dir,(y)es]? "
    read -r

    if [[ -z "$REPLY" ]] || [[ "$REPLY" =~ "g" ]]; then
        break
    fi

    if [[ "$REPLY" =~ "t" ]]; then
        echo "Will try again."
    fi

    if [[ "$REPLY" =~ "y" ]]; then
        UPDATE_COMMAND_INPUT=(echo -en "y\ny")
        NO_CONFIRM=()
        echo "Will add yes to makepkg."
    fi

    if [[ "$REPLY" =~ "n" ]]; then
        echo "Adding --nocheck..."
        UPDATE_COMMAND+=(--nocheck)
    fi

    if [[ "$REPLY" =~ "s" ]]; then
        echo "Adding --skippgpcheck..."
        UPDATE_COMMAND+=(--skippgpcheck)
    fi

    if [[ "$REPLY" =~ "r" ]]; then
        remove_build_dir
    fi
done

echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Giving up.${BASH_COLOR_NORMAL}"
