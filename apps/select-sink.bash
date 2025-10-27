#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

SINKS="$(pamixer --list-sinks | grep -v 'Sinks:')"

SELECTED_SINK="$(rofi -dmenu -p "> " -sort -matching fuzzy -scroll-method 1 <<< "$SINKS")"
SINK_NAME="$(tr -d '"' <<< "$SELECTED_SINK" | cut -d ' ' -f 2)"
echo Setting "'$SINK_NAME'" as default string...
pactl set-default-sink "$SINK_NAME"
