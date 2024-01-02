#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

FILE_PATH="$(command -v "$1")"
if ! grep --binary-files=without-match --regexp="" "$FILE_PATH" &> /dev/null; then
	echo "$FILE_PATH is a binary file." >&2
	exit 1
fi

${EDITOR:-vim} "$FILE_PATH"
