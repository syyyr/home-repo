#!/bin/bash
set -eux

SVCL="$HOME/Documents/opt/soundvolumeview-x64/svcl.exe"
CACHE_FILE="${XDG_CACHE_HOME:=$HOME/.cache}/switch"

do_switch()
{
    "$SVCL" /SwitchDefault "$MONITOR_DEVICE" 'Realtek(R) Audio\Device\Reproduktory\Render' all
}

if [[ -r "$CACHE_FILE" ]]; then
    MONITOR_DEVICE="$(cat "$CACHE_FILE")"
fi

# Start refreshing the cache immediately. Only this or the other do_switch call can succeed.
{
    readarray -t DEVICES < <("$SVCL" /GetColumnValue 'NVIDIA High Definition Audio\Device\2460G4\Render' 'ItemID' | tr -s '\n' | tr -d '\r')
    for device in "${DEVICES[@]}"; do
        if [[ "$("$SVCL" /GetColumnValue "$device" 'DeviceState' | tr -s '\n' | tr -d '\r')" = "Active" ]]; then
            if [[ "${MONITOR_DEVICE:-}" != "$device" ]]; then
                MONITOR_DEVICE="$device"
                do_switch
                echo -n "$device" > "$CACHE_FILE"
            fi
        fi
    done
} &

do_switch
wait
