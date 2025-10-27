#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

find . -type f -iname \*"$1"\*
