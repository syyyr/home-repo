#!/bin/bash
set -u

readonly BASH_COLOR_BOLD=$'\033''[1m'
readonly BASH_COLOR_RED=$'\033''[31m'
readonly BASH_COLOR_NORMAL=$'\033''[0m'
readonly BASH_BLUE_BOLD=$'\033''[01;34m'
readonly AUR_DEP="$1"

info() {
	if [[ "$1" = "-n" ]]; then
		local ARGS=("-n")
		local TEXT="$2"
	else
		local ARGS=()
		local TEXT="$1"
	fi
	ARGS+=("${BASH_BLUE_BOLD}$TEXT${BASH_COLOR_NORMAL}")
	echo "${ARGS[@]}"
}

UPDATE_COMMAND=(env CTEST_PARALLEL_LEVEL="$(nproc)" MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --needed)

pushd "$HOME/.local/aur/$AUR_DEP" || exit 1
git reset --hard

while true; do
	info "Building $AUR_DEP..."
	"${UPDATE_COMMAND[@]}" && exit 0

	echo "Building $AUR_DEP failed."
	info -n "Try again [(n)ocheck,(s)kippgpcheck,(r)emove_build_dir]? "
	read -r

	if [[ -z "$REPLY" ]]; then
		break
	fi

	if [[ "$REPLY" =~ "n" ]]; then
		echo "Adding --nocheck...";
		UPDATE_COMMAND+=(--nocheck)
	fi

	if [[ "$REPLY" =~ "s" ]]; then
		echo "Adding --skippgpcheck...";
		UPDATE_COMMAND+=(--skippgpcheck)
	fi

	if [[ "$REPLY" =~ "r" ]]; then
		echo "Removing $HOME/.local/aur/$AUR_DEP/src..."
		rm -rf "$HOME/.local/aur/$AUR_DEP/src"
	fi
done

echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Giving up.${BASH_COLOR_NORMAL}"
