#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

pacman -Qdtq | sudo pacman -Rs -
