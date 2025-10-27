#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

git commit-graph write --reachable --changed-paths
