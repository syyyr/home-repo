#!/bin/bash
set -euxo pipefail

sudo pacman -Syu --noconfirm
exec 3< <(git submodule update --remote |& cat)
UPDATE_PID="$!"
auracle outdated || echo "No outdated AUR packages."
"$HOME/apps/do-auracle-update.bash"
echo "Waiting for submodules to finish updating..."
wait "$UPDATE_PID"
cat <&3
pushd "$HOME"
echo Updating tree-sitter parsers...
nvim --headless -c TSUpdateSync -c q
echo # The output from nvim doesn't have a trailing newline
git submodule summary
"$HOME/apps/check-config.bash"
popd
