#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

pacman -Qdtq | sudo pacman -Rs -
