#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

git log --oneline origin/master~..HEAD 2>/dev/null || git log --oneline origin/main~..HEAD
