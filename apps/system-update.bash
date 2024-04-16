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
        -e "extremely-linear-git"
        -e "python-aioserial-git"
        -e "python-i3-chrome-tab-dragging-git"

        # Broken for now
        -e "libyang-cpp-git"
        -e "tree-sitter-git"
        -e "py3status-git"
    )
    grep -v "${DISABLED_PKGS[@]}"
}

pushd "$HOME" > /dev/null
exec 3< <(checkupdates)
sudo pacman -Syu --noconfirm
if grep -P '^\x1b\[0;1mlinux ' <&3; then
    info Detected a Linux update. Reboot the PC now.
    exit 0
fi

exec 3< <(git submodule update --remote |& cat)
UPDATE_PID="$!"
auracle outdated || echo "No outdated AUR packages."

pushd "$HOME/.local/aur" > /dev/null
for i in $(auracle -q outdated | filter_disabled_packages) $(pacman -Qqs '.-git$' | filter_disabled_packages); do
    "$HOME/apps/update-aur-dep.bash" "$i" || true
done
popd > /dev/null

echo "Waiting for submodules to finish updating..."
wait "$UPDATE_PID"
cat <&3
echo Updating tree-sitter parsers...
nvim --headless -c TSUpdateAndQuit
git --no-pager submodule summary
"$HOME/apps/check-config.bash"
popd > /dev/null
