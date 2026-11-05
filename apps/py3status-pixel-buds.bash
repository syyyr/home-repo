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
        return 0
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

# FIXME: Change back to `bluetoothctl devices` after upstream fixes the bug.
if ! echo -e 'devices Connected\nquit' | bluetoothctl | grep 'Pixel Buds Pro' &> /dev/null; then
    CONNECTED=0
    get_disconnected_battery
else
    CONNECTED=1
    get_connected_battery
fi

if [[ -n "${LEFT}" ]]; then
    LEFT="[\?color=lightblue&show L: ${LEFT}%]"
fi

if [[ -n "${CASE}" ]]; then
    CASE=" [\?color=lightblue&show C: ${CASE}%] "
elif [[ "$CONNECTED" -eq 1 ]]; then
    CASE=" "
fi

if [[ -n "${RIGHT}" ]]; then
    RIGHT="[\?color=lightblue&show R: ${RIGHT}%]"
fi

if [[ "$CONNECTED" -eq 0 ]]; then
    echo -n "${CASE}"
    exit 0
fi

ANC="$(pbpctrl get anc)"

if [[ "$ANC" = active ]]; then
    ANC=" [\?color=lightblue&show ANC]"
else
    ANC=""
fi

if ! pactl list | grep -F 'High Fidelity Playback (A2DP Sink,' &> /dev/null; then
    A2DP=" [\?color=salmon&show A2DP unavailable!]"
else
    A2DP=""
fi

echo -n "${LEFT}${CASE}${RIGHT}${ANC}${A2DP}"
