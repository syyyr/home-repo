#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

composite -density 200 -geometry 200x200+1000+1800  ~/.local/share/signature.png "$@"
