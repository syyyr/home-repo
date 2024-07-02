#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

git difftool --dir-diff "$@"
