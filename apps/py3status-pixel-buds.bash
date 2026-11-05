#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

source "$HOME/.local/share/ha-token"

if pgrep -f 'fix_headphones.bash' &> /dev/null; then
    echo -n '[\?color=plum&show Fixing headphones…]'
    exit 0
fi

get_ha_battery() {
    local ENTITY_ID="$1"
    local VALUE

    if ! VALUE="$(
        curl --fail --silent \
            --header "Authorization: Bearer ${HASS_TOKEN}" \
            "http://${HASS_SERVER}/api/states/${ENTITY_ID}" |
            jq -er '.state' 2>/dev/null
    )"; then
        return
    fi

    echo -n "$VALUE"
}

get_disconnected_battery() {
    LEFT="$(get_ha_battery sensor.pixel_buds_left_battery_last)"
    CASE="$(get_ha_battery sensor.pixel_buds_case_battery_last)"
    RIGHT="$(get_ha_battery sensor.pixel_buds_right_battery_last)"
}

get_connected_battery() {
    local BATTERY_INFO

    BATTERY_INFO="$(pbpctrl show battery)"
    LEFT="$(grep "left bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"

    if ! CASE="$(grep "case:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')" || [[ -z "${CASE}" ]]; then
        CASE="$(get_ha_battery sensor.pixel_buds_case_battery_last)"
    fi

    RIGHT="$(grep "right bud:" <<< "$BATTERY_INFO" | grep -o '[0-9]*')"
}

format_battery() {
    local LABEL="$1"
    local VALUE="$2"

    echo -n "[\?color=lightblue&show ${LABEL}: ${VALUE}%]"
}

add_battery_label() {
    local LABEL="$1"
    local VALUE="$2"

    if [[ -n "$VALUE" ]]; then
        BATTERY_LABELS+=("$LABEL")
    fi
    return 0
}

declare -A BATTERY_VALUES
BATTERY_LABELS=()

# FIXME: Change back to `bluetoothctl devices` after upstream fixes the bug.
if ! printf 'devices Connected\nquit\n' | bluetoothctl | grep 'Pixel Buds Pro' &> /dev/null; then
    CONNECTED=0
    get_disconnected_battery
    if [[ "$CASE" -ne 100 ]]; then
        BATTERY_VALUES=([C]="$CASE")
        add_battery_label C "$CASE"
    fi
else
    CONNECTED=1
    get_connected_battery
    BATTERY_VALUES=([L]="$LEFT" [C]="$CASE" [R]="$RIGHT")
    add_battery_label L "$LEFT"
    add_battery_label C "$CASE"
    add_battery_label R "$RIGHT"
fi

OUTPUT_PARTS=()
for LABEL in "${BATTERY_LABELS[@]}"; do
    OUTPUT_PARTS+=("$(format_battery "$LABEL" "${BATTERY_VALUES[$LABEL]}")")
done

if [[ "$CONNECTED" -eq 1 ]]; then
    ANC="$(pbpctrl get anc)"
    if [[ "$ANC" = active ]]; then
        OUTPUT_PARTS+=("[\?color=lightblue&show ANC]")
    fi
    pactl list | grep -F 'High Fidelity Playback (A2DP Sink,' &> /dev/null || OUTPUT_PARTS+=("[\?color=salmon&show A2DP unavailable!]")
fi

OUTPUT="${OUTPUT_PARTS[*]}"

echo -n "$OUTPUT"
