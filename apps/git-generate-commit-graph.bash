#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

git commit-graph write --reachable --changed-paths
