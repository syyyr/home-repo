#!/bin/bash
set -euo pipefail


${EDITOR:-vim} "$(command -v "$1")"
