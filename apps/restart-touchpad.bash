#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

sudo rmmod thinkpad_acpi
sudo modprobe thinkpad_acpi
