#!/bin/bash

print_and_run()
{
	BASH_COLOR_BOLD=$'\033''[1m'
	BASH_COLOR_NORMAL=$'\033''[0m'
	echo "${BASH_COLOR_BOLD}RUN:${BASH_COLOR_NORMAL}" "$@" >&2
	"$@"
}

impl_lua_language_server()
{
	FILE="$1"
	LOGFILE="$(print_and_run lua-language-server --configpath="$HOME/.config/nvim/.luarc.json" --check="$FILE" --checklevel=Hint | grep -oE "[^ ]+check\.json")"
	if [[ -n "$LOGFILE" ]]; then
		jq -r 'to_entries | map((.key | sub("file://"; "")) as $key | .value | map($key + ":" + (.range.start.line + 1 | tostring) + ":" + (.range.start.character + 1 | tostring) + ": " + .message + " [" + .code + "]") | .[]) | .[]' "$LOGFILE"
		rm "$LOGFILE"
	fi
}

export -f print_and_run
export -f impl_lua_language_server

{
	echo print_and_run selene --no-summary --config .config/nvim/selene.toml .config/nvim/
	echo print_and_run shellcheck -a "$HOME"/.config/bashrc/*
	find "$HOME/.config/nvim" -type f -name '*lua' | while read -r line; do echo "impl_lua_language_server $line"; done
} | parallel
