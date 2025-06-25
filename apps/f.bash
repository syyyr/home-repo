#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

find . -type f -iname \*"$1"\*
