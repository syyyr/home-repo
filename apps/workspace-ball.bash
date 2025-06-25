#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

OUTPUT=$(xrandr | grep -o '^.* connected' | grep -v 'eDP-1' | sed 's/ connected//')
i3 "workspace 2; move workspace to output $OUTPUT"
i3 "workspace 3; move workspace to output $OUTPUT"
i3 "workspace 4; move workspace to output $OUTPUT"
i3 'workspace N; move workspace to output eDP-1'
i3 "workspace M; move workspace to output $OUTPUT"
i3 'workspace M; move workspace to output eDP-1'
i3 'workspace N'
i3 "workspace 1; move workspace to output $OUTPUT"
