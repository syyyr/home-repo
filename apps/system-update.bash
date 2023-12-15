#!/bin/bash
set -euxo pipefail

filter_disabled_packages() {
    local DISABLED_PKGS=(
        # These are part of another package.
        -e "mingw-w64-harfbuzz-icu"
    )
    grep -v "${DISABLED_PKGS[@]}"
}

pushd "$HOME"
sudo pacman -Syu --noconfirm
exec 3< <(git submodule update --remote |& cat)
UPDATE_PID="$!"
auracle outdated || echo "No outdated AUR packages."

pushd "$HOME/.local/aur"
for i in $(auracle -q outdated | filter_disabled_packages) $(pacman -Qqs '.-git$' | filter_disabled_packages); do
    "$HOME/apps/update-aur-dep.bash" "$i" || true
done
popd

echo "Waiting for submodules to finish updating..."
wait "$UPDATE_PID"
cat <&3
echo Updating tree-sitter parsers...
nvim --headless -c TSUpdateAndQuit
git --no-pager submodule summary
"$HOME/apps/check-config.bash"
popd
