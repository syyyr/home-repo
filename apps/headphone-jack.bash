#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

refresh() {
    py3-cmd refresh volume_status
}

TO_MATCH=(
    -e "jack/microphone MICROPHONE unplug"
    -e "jack/headphone HEADPHONE unplug"
    -e "jack/headphone HEADPHONE plug"
    -e "jack/microphone MICROPHONE plug"
)

acpi_listen | while IFS= read -r line; do
    if ! grep -qF "${TO_MATCH[@]}" <<< "$line"; then
        continue
    fi

    refresh
done
