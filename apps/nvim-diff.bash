#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

LEFT="$1"
RIGHT="$2"
if [[ -f "$LEFT" ]] && [[ -f "$RIGHT" ]]; then
    nvim -d "$LEFT" "$RIGHT"
    exit 0
fi

readarray -t FILES < <(find "$LEFT" "$RIGHT" -type f,l | sed "s@$LEFT@@;s@$RIGHT@@" | sort | uniq -d | uniq)

NVIM_ARGS=()
for FILE in "${FILES[@]}"; do
    NVIM_ARGS+=("$(realpath "$LEFT/$FILE")" "$(realpath "$RIGHT/$FILE")")
done

echo "${NVIM_ARGS[@]}"
nvim "${NVIM_ARGS[@]}" -c 'lua require("syyyr").diff_adjacent_args()'
