#!/bin/bash
if [[ $# -eq 0 ]]; then
    nvim -p ~/.config/bashrc/*
else
    nvim -p $(printf '/home/vk/.config/bashrc/%s ' "$@")
fi
