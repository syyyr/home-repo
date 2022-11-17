#!/bin/bash
set +H
export DISPLAY=$(grep nameserver < /etc/resolv.conf | awk '{print $2; exit;}'):0.0
echo "$@"
WIN_PATH=$(wslpath "$@")
echo "$WIN_PATH"
xfce4-terminal --hide-menubar --hide-scrollbar --hide-toolbar -e "nvim '$WIN_PATH'"
