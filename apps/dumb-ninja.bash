#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

TERM=dumb command ninja "$@"
