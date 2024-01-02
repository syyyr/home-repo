#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

"$HOME/apps/check-available.bash" rg || exit 1
OPEN_ALL='0'
RG_CMD_ARGS=()
for arg in "$@"; do
    case "$arg" in
        -*)
            [[ "$arg" =~ a ]] && OPEN_ALL='1' || OPEN_ALL='0'
            [[ "$arg" =~ n ]] && RG_CMD_ARGS+=('--no-ignore') || RG_CMD_ARGS+=('--ignore')
            while [[ "$arg" =~ ([^-ain]) ]]; do
                echo "Unknown option:" -"${BASH_REMATCH[1]}"
                arg="$(tr -d "${BASH_REMATCH[1]}" <<< "$arg")"
            done
            shift
            ;;
        *)
            break
            ;;
    esac
done

for arg in "$@"; do
    if [[ -d "$arg" || -r "$arg" ]]; then
        break
    fi

    SEARCH_PATTERN="${SEARCH_PATTERN:-}${SEARCH_PATTERN+ }$arg"
    shift
done

SEARCH_LOCATIONS=( "$@" )

if [[ -z "${SEARCH_PATTERN+x}" ]]; then
    SEARCH_PATTERN="${SEARCH_LOCATIONS[0]:-}"
    SEARCH_LOCATIONS=( "${SEARCH_LOCATIONS[@]:1}" )
fi

# Smart case
if [[ "${SEARCH_PATTERN}" != "${SEARCH_PATTERN,,}" ]]; then
    IGNORE_CASE='--case-sensitive'
else
    IGNORE_CASE='--ignore-case'
fi

RG_CMD_ARGS+=("$IGNORE_CASE")

if [[ "$OPEN_ALL" = "1" ]]; then
    RG_CMD_ARGS+=("--color=never")
else
    RG_CMD_ARGS+=("--color=always")
fi

RG_CMD=( rg "${RG_CMD_ARGS[@]}" --with-filename --line-number --column --regexp  "$SEARCH_PATTERN" "${SEARCH_LOCATIONS[@]}" )

echo "${RG_CMD[@]@Q}"
if RESULTS="$("${RG_CMD[@]}")"; then
    : # Need to handle the error code in the else branch, because `!` overrides it.
else
    if [[ "$?" = 2 ]]; then
        RG_CMD+=(--no-ignore)
        echo "${RG_CMD[@]@Q}"
        RESULTS="$("${RG_CMD[@]}")"
    else
        exit "$?"
    fi
fi
if [[ "$OPEN_ALL" = "1" ]]; then
    nvim -q <(echo "$RESULTS")
    exit 0
fi
FILE="$(fzf --tac -0 --height=50% --border --ansi --multi <<< "$RESULTS")"
case "$?" in
    0)
        nvim -q <(echo "$FILE")
        ;;
    1)
        echo "fzf: No match. This shouldn't happen." >&1
        ;;
    2)
        echo 'fzf: Error.' >&1
        ;;
    130)
        ;;
    *)
        echo 'error.' >&1
esac
