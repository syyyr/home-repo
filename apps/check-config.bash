#!/bin/bash

print_and_run()
{
	echo RUN: "$@" >&2
	"$@"
}

print_and_run selene --no-summary --config .config/nvim/selene.toml .config/nvim/
print_and_run shellcheck -a "$HOME"/.config/bashrc/*
LOGFILE="$(print_and_run lua-language-server --check "$HOME/.config/nvim" --checklevel=Hint | grep -oE "[^ ]+check\.json")"
if [[ -n "$LOGFILE" ]]; then
	jq -r 'to_entries | map((.key | sub("file://"; "")) as $key | .value | map($key + ":" + (.range.start.line + 1 | tostring) + ":" + (.range.start.character + 1 | tostring) + ": " + .message + " [" + .code + "]") | .[]) | .[]' "$LOGFILE"
	rm "$LOGFILE"
fi
