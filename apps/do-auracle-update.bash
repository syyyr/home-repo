#!/bin/bash
set -euo pipefail

pushd "$HOME/.local/aur"
auracle update || true
for i in $(auracle -q outdated) $(pacman -Qqs '.-git$'); do
    "$HOME/apps/update-aur-dep.bash" "$i"
done
popd
