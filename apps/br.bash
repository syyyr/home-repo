#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

git switch -C "$(git branch --contains HEAD | sed -r 's@[^/]*/(.*)\)$@\1@')"
