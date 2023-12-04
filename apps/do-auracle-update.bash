#!/bin/bash
set -euo pipefail

pushd "$HOME/.local/aur"

filter_disabled_packages() {
    local DISABLED_PKGS=(
        # These are part of another package.
        -e "mingw-w64-harfbuzz-icu"
    )
    grep -v "${DISABLED_PKGS[@]}"
}

for i in $(auracle -q outdated | filter_disabled_packages) $(pacman -Qqs '.-git$' | filter_disabled_packages); do
    "$HOME/apps/update-aur-dep.bash" "$i" || true
done
popd

auracle update || true
