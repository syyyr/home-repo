#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

grep '\[.*\]$' | tr -d '`;()<>&'\' | sed -E 's@^(\/[^\:]+)@echo "$(realpath \1)"@g' | bash
