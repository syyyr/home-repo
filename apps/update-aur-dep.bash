#!/bin/bash
set -euo pipefail

readonly BASH_COLOR_BOLD=$'\033''[1m'
readonly BASH_COLOR_RED=$'\033''[31m'
readonly BASH_COLOR_NORMAL=$'\033''[0m'

readonly UPDATE_COMMAND=(env CTEST_PARALLEL_LEVEL="$(nproc)" MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --needed)
readonly AUR_DEP="$1"

try_again_message() {
	echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Building $AUR_DEP failed.${BASH_COLOR_NORMAL}"
	echo -n "Try again with ${1}? [Y/n] "
	read -r
	if [[ -n "$REPLY" ]] && ! [[ "$REPLY" =~ [Yy] ]]; then
		echo 'Aborting.'
		exit 1
	fi
	echo "Trying again with ${1}..."
}

pushd "$HOME/.local/aur/$AUR_DEP"
git reset --hard

if "${UPDATE_COMMAND[@]}"; then
	exit 0
fi

try_again_message '--skippgpcheck'
if "${UPDATE_COMMAND[@]}" --skippgpcheck; then
	exit 0
fi

try_again_message 'removing the build directory'
echo "Removing $HOME/.local/aur/$AUR_DEP/src and trying again..."
rm -rf "$HOME/.local/aur/$AUR_DEP/src"
"${UPDATE_COMMAND[@]}"
popd
