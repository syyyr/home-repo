#!/bin/bash
ARG="$1"
export BROWSER=/home/vk/bin/wslbrowser
export DISPLAY=0 # xdg-open refuses to work with mime types if DISPLAY is not set
echo Current working directory: "'$(pwd)'"
echo Arg "'$ARG'"
WSL_PATH="$(wslpath -ua "$ARG")"
echo Opening "'$ARG'" as "'$WSL_PATH'"
xdg-open "$WSL_PATH"
