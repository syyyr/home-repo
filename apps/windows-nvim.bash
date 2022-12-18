#!/bin/bash
set +H
echo "$@"
WIN_PATH=$(wslpath "$@")
echo "$WIN_PATH"
xfce4-terminal --hide-menubar --hide-scrollbar --hide-toolbar -e "nvim '$WIN_PATH'"
