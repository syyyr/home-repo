#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

nvim -d "$1" "scp://anip.icu/www/rakac/$1"
