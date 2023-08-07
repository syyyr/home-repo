#!/bin/bash
set -euo pipefail

pushd "$HOME/.local/aur"
auracle update || true

# These are part of another package.
filter_disabled_packages() {
    grep -v "mingw-w64-harfbuzz-icu"
}

for i in $(auracle -q outdated | filter_disabled_packages) $(pacman -Qqs '.-git$'); do
    "$HOME/apps/update-aur-dep.bash" "$i" || true
done
popd

auracle update || true
