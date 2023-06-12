#!/bin/bash
set -euo pipefail

pacman -Qdtq | sudo pacman -Rs -
