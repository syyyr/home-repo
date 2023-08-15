#!/bin/bash

luacheck -q "$HOME/.config/nvim" | grep -v 'Total:'
shellcheck -a "$HOME"/.config/bashrc/*
LOGFILE="$(lua-language-server --check "$HOME/.config/nvim" --checklevel=Hint | grep -oE "[^ ]+check\.json")"
if [[ -n "$LOGFILE" ]]; then
	jq -r 'to_entries | map((.key | sub("file://"; "")) as $key | .value | map($key + ":" + (.range.start.line + 1 | tostring) + ":" + (.range.start.character + 1 | tostring) + ": " + .message + " [" + .code + "]") | .[]) | .[]' "$LOGFILE"
	rm "$LOGFILE"
fi
