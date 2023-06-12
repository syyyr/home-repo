set -euo pipefail

"$HOME/apps/check-available.bash" rg || exit 1
CASE="--case-sensitive"
OPEN_ALL='0'
while true; do
    case $1 in
        -a)
            OPEN_ALL='1'
            shift
            ;;
        -i)
            CASE='--ignore-case'
            shift
            ;;
        -ai)
            CASE='--ignore-case'
            OPEN_ALL='1'
            shift
            ;;
        -ia)
            CASE='--ignore-case'
            OPEN_ALL='1'
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
    SEARCH_PATTERN="${SEARCH_LOCATIONS[0]}"
    SEARCH_LOCATIONS=( "${SEARCH_LOCATIONS[@]:1}" )
fi

if [[ "$OPEN_ALL" = "1" ]]; then
    COLOR=--color=never
else
    COLOR=--color=always
fi

RG_CMD=( rg "$CASE" "$COLOR" --with-filename --line-number --column --regexp  "$SEARCH_PATTERN" "${SEARCH_LOCATIONS[@]}" )

echo "${RG_CMD[@]@Q}"
if ! RESULTS="$("${RG_CMD[@]}")"; then
    echo 'No match.' >&1
    exit 0
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
