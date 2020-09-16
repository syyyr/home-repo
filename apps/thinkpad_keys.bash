#!/bin/bash
if [[ -z $DISPLAY ]]; then
    echo X is not available. Quitting after 5s. >&2
    sleep 5
    exit 1
fi
acpi_listen | sed -u -n "s@ibm/hotkey LEN0268:00 00000080 0000131@@p" | while true; do
{
    read number
    [[ number -eq 7 ]] && key=XF86Tools
    [[ number -eq 8 ]] && key=XF86Explorer
    [[ number -eq 9 ]] && key=XF86LaunchA
    echo "$key"
    xdotool key "$key"
    key=
}; done
