#!/bin/bash
set -euo pipefail

readonly BASH_COLOR_BOLD=$'\033''[1m'
readonly BASH_COLOR_RED=$'\033''[31m'
readonly BASH_COLOR_NORMAL=$'\033''[0m'

readonly UPDATE_COMMAND=(env MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --needed)

pushd "$HOME/.local/aur/$1"
git reset --hard
if ! "${UPDATE_COMMAND[@]}"; then
	# Try to remove the src directory if the build fails.
	echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Building $1 failed.${BASH_COLOR_NORMAL}"
	echo "Removing $HOME/.local/aur/$1/src and trying again..."
	rm -rf "$HOME/.local/aur/$1/src"
	"${UPDATE_COMMAND[@]}"
fi
popd