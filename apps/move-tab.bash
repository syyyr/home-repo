#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit
TREE="$(i3-msg -t get_tree)"
if ! jq --exit-status '[..] | map(select(type == "object" and .focused)) | .[].window_properties.class == "Google-chrome"' <<< "$TREE"; then
    echo Chrome is not currently in focus.
    exit 0
fi

WORKSPACES="$(i3-msg -t get_workspaces)"
UNFOCUSED_NAME="$(jq -r 'map(select(.visible and (.focused | not))) | .[].name' <<< "$WORKSPACES")"
sleep 0.5
xvkbd -text '\e'
sleep 0.3
xvkbd -text W
sleep 0.3
i3-msg move container to workspace "$UNFOCUSED_NAME"
sleep 0.3
i3-msg workspace "$UNFOCUSED_NAME"
i3-msg layout stacking

# TODO: Hopefully Vimium gets window merging support at some point, so I can merge the tabs
