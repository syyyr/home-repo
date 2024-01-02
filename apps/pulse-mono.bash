#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

pacmd load-module module-remap-sink sink_name=mono master="$(pacmd list-sinks | grep -m 1 -oP 'name:\s<\K.*(?=>)')" channels=1 channel_map=mono

