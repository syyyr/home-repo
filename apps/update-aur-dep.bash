#!/bin/bash
set -u

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
		return 1
	fi
	echo "Trying again with ${1}..."
}

pushd "$HOME/.local/aur/$AUR_DEP" || exit 1
git reset --hard

if "${UPDATE_COMMAND[@]}"; then
	exit 0
fi


if try_again_message '--skippgpcheck'; then
	"${UPDATE_COMMAND[@]}" --skippgpcheck && exit 0
fi

if try_again_message 'removing the build directory'; then
	echo "Removing $HOME/.local/aur/$AUR_DEP/src and trying again..."
	rm -rf "$HOME/.local/aur/$AUR_DEP/src"
	"${UPDATE_COMMAND[@]}" && exit 0
fi

echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Building $AUR_DEP failed. Giving up.${BASH_COLOR_NORMAL}"
