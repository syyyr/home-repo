#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

print_and_run()
{
	BASH_COLOR_BOLD=$'\033''[1m'
	BASH_COLOR_NORMAL=$'\033''[0m'
	echo "${BASH_COLOR_BOLD}RUN:${BASH_COLOR_NORMAL}" "$@" >&2
	"$@"
}

ignore_line()
{
	if grep -Fv 'Diagnosis completed, no problems found'; then
		if [[ $? = 1 ]]; then
			return 0
		fi
	fi
}

print_and_run selene --no-summary --config "$HOME/.config/nvim/selene.toml" "$HOME/.config/nvim/"
print_and_run shellcheck -a "$HOME"/.config/bashrc/*
print_and_run lua-language-server --check="$HOME/.config/nvim" --checklevel=Hint | ignore_line
