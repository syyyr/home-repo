#!/bin/bash

export DAYSTART='8'
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='find . -type d \( -name ".cargo" -or -name ".local" -or -name ".rustup" -or -name ".npm" -or -name ".git" -or -name ".cache" \) -prune -o -type f -print'
export LESS='-RFS'
export MANPAGER='nvim +Man!'
export NIGHTSTART='22'
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
OUTPUT=$(xrandr | grep -o '^.* connected' | grep -v 'eDP-1' | sed 's/ connected//')
if [ -n "$OUTPUT" ]; then
	export QT_SCALE_FACTOR=1.5
fi
unset OUTPUT
export SCREENDIR="$HOME/.screen"
export UBSAN_OPTIONS=print_stacktrace=true,halt_on_error=1
export VISUAL='nvim'
