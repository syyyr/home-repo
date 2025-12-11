#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if [[ "$#" -ne 1 ]]; then
    echo "usage: $0 <REQUIRED_QT_VERSION>"
    exit 1
fi

REQUIRED_QT_VERSION="$1"

readarray -t QT6_PKGS < <(pacman -Qqs ^qt6 | grep -v mqtt | sed "s/\$/=${REQUIRED_QT_VERSION}-1/")

sudo downgrade --ignore never --prefer-cache "${QT6_PKGS[@]}"
ldd /usr/lib/libQt6Core.so | grep libicu
