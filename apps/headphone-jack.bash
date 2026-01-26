#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

refresh() {
    py3-cmd refresh volume_status 'external_script rfkill'
}

TO_MATCH=(
    -e "jack/microphone MICROPHONE unplug"
    -e "jack/headphone HEADPHONE unplug"
    -e "jack/headphone HEADPHONE plug"
    -e "jack/microphone MICROPHONE plug"
    -e "button/wlan WLAN 00000080 00000000 K"
)

acpi_listen | while IFS= read -r line; do
    if ! grep -qF "${TO_MATCH[@]}" <<< "$line"; then
        continue
    fi

    refresh
done
