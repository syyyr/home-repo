#!/bin/bash
ARG="$1"
export BROWSER=/home/vk/bin/wslbrowser
echo Current working directory: "'$(pwd)'"
echo Arg "'$ARG'"
WSL_PATH="$(wslpath -ua "$ARG")"
echo Opening "'$ARG'" as "'$WSL_PATH'"
xdg-open "$WSL_PATH"
sleep 0.5
