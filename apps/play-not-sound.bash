#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit
ffplay "$HOME/.local/share/notification.mp3" -nodisp -autoexit
