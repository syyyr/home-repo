#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

sudo rmmod thinkpad_acpi
sudo modprobe thinkpad_acpi
