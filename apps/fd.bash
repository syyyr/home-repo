#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

find . -type d -iname \*"$1"\*
