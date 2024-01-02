#!/bin/bash
set -euxo pipefail
shopt -s inherit_errexit

readonly BASH_COLOR_BOLD=$'\033''[1m'
readonly BASH_COLOR_RED=$'\033''[31m'
readonly BASH_BLUE_BOLD=$'\033''[01;34m'
readonly BASH_COLOR_NORMAL=$'\033''[0m'
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

remove_build_dir() {
	echo "Removing $HOME/.local/aur/$AUR_DEP/src..."
	rm -rf "$HOME/.local/aur/$AUR_DEP/src"
}

UPDATE_COMMAND=(env CTEST_PARALLEL_LEVEL="$(nproc)" MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm --needed)

readonly DEP_DIR="$HOME/.local/aur/$AUR_DEP"
if ! [[ -d "$DEP_DIR" ]]; then
	auracle clone --chdir="$HOME/.local/aur" "$AUR_DEP"
fi
pushd "$DEP_DIR" || exit 1
git fetch
git reset --hard origin/master

while true; do
	info "Building $AUR_DEP..."

	readonly AUTOREMOVE_PKGS=(
		cmake-language-server-git
		mingw-w64-trompeloeil
		mingw-w64-vulkan-headers
		mingw-w64-vulkan-icd-loader
	)
	for i in "${AUTOREMOVE_PKGS[@]}"; do
		if [[ "$i" = "$AUR_DEP" ]]; then
			info "Automatically removing build dir for $AUR_DEP."
			remove_build_dir
		fi
	done; unset i

	if "${UPDATE_COMMAND[@]}"; then
		exit 0
	fi

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
		remove_build_dir
	fi
done

echo "${BASH_COLOR_BOLD}${BASH_COLOR_RED}Giving up.${BASH_COLOR_NORMAL}"
