#!/bin/bash
make_html()
{
	NAME="$1"
	OLD="$2"
	NEW="$3"
	echo "<span color='lightblue'>$NAME</span> <span color='red'>$OLD</span> <span color='lightgrey'>-></span> <span color='lime'>$NEW</span>"
}

UPDATED=()

if [[ "$1" = updates ]]; then
	OUT="$(auracle outdated)"
elif [[ "$1" = out-of-date ]]; then
	OUT="$(aur-out-of-date -user syyyr -json | tr -d '\036' | grep OUT-OF-DATE | jq -r '"\(.name) \(.version) -> \(.upstream)"')"
else
	echo Unknown mode "$1" 2>&1
	exit 1
fi

if [[ -n "$OUT" ]]; then
	while read -r LINE; do
		NAME="$(cut -d ' ' -f1 <<< "$LINE")"
		OLD="$(cut -d ' ' -f2 <<< "$LINE")"
		NEW="$(cut -d ' ' -f4 <<< "$LINE")"
		UPDATED+=("$(make_html "$NAME" "$OLD" "$NEW")")
	done <<< "$OUT"; unset LINE
fi

if [[ ${#UPDATED[@]} -ne 0 ]]; then
	echo "${UPDATED[@]}"
fi


