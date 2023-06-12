#!/bin/bash

luacheck -q "$HOME/.config/nvim" | grep -v 'Total:'
shellcheck -a "$HOME"/.config/bashrc/*
