#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

readonly BASH_BLUE_BOLD=$'\033''[01;34m' BASH_COLOR_NORMAL=$'\033''[0m'

info() {
	echo "${BASH_BLUE_BOLD}$*${BASH_COLOR_NORMAL}"
}

filter_disabled_packages() {
    local DISABLED_PKGS=(
        # These are part of another package.
        -e "mingw-w64-harfbuzz-icu"

        # These aren't updated all that frequently (or never).
        -e "auracle-git"
        -e "cmake-language-server-git"
        -e "ctcache-git"
        -e "extremely-linear-git"
        -e "flamerobin-git"
        -e "gdb-ctest-git"
        -e "leagueoflegends-git"
        -e "libosmscout-git"
        -e "mingw-w64-ntldd-git"
        -e "mingw-libosmscout-git"
        -e "python-aioserial-git"
        -e "python-i3-chrome-tab-dragging-git"
        -e "yang-lsp-git"
        -e "wireshark-chainpack-rpc-block-dissector-git"
    )
    grep -v "${DISABLED_PKGS[@]}"
}

exec 3< <(checkupdates)
sudo pacman -Syu --noconfirm
CHECKUPDATES_OUTPUT="$(cat <&3)"
SHOULD_RESTART=0
for PACKAGE in linux systemd mkinitcpio; do
    if grep -P '^\x1b\[0;1m'"$PACKAGE"' ' <<< "$CHECKUPDATES_OUTPUT"; then
        SHOULD_RESTART=1
    fi
done

if ((SHOULD_RESTART)); then
    echo Detected major updates. Reboot the PC now.
    exit 0
fi

rustup update

if [[ -z "${NO_SUB+x}" ]]; then
    exec 3< <(git -C "$HOME" submodule update --remote |& cat)
    UPDATE_PID="$!"
fi

if [[ -z "${NO_AUR+x}" ]]; then
    (
        auracle outdated || echo "No outdated AUR packages."
        mkdir -p "$HOME/.local/aur"
        cd "$HOME/.local/aur" > /dev/null
        for i in $({ auracle -q outdated || true; pacman -Qqs '.-git$'; } | filter_disabled_packages); do
            "$HOME/apps/update-aur-dep.bash" "$i" || true
        done
    )
fi

if [[ -z "${NO_SUB+x}" ]]; then
    echo "Waiting for submodules to finish updating..."
    wait "$UPDATE_PID"
    cat <&3
fi

echo Updating tree-sitter parsers...
nvim --headless -c TSUpdateAndQuit
git -C "$HOME" --no-pager submodule summary
"$HOME/apps/check-config.bash"
