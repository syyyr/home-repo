#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

find "${2:-.}" -type d -iname \*"$1"\*
