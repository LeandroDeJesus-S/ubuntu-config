#!/usr/bin/env bash
set -e

source ./functions.sh

printout "[$0] script started"

function check_command {
    local cmd=$1
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed or not in PATH"
        exit 1
    fi
    echo "$cmd is installed"
}

# Utilitaries
check_command curl
check_command brew
check_command wget
check_command ffmpeg
check_command 7z
check_command jq
check_command pdftotext
check_command fd
check_command rg
check_command fzf
check_command zoxide
check_command rsvg-convert
check_command convert

# Git Stuffs
check_command git
check_command gh
check_command git-flow
check_command lazygit

# Docker Stuffs
check_command docker
check_command lazydocker

# Development Stuffs
check_command nvim
check_command go
check_command gopls
check_command pyenv
check_command uv
check_command poetry
check_command nvm
check_command node
check_command npm
check_command pipx
check_command pyright
check_command ruff
check_command mypy
check_command pre-commit

# Terminal Stuffs
check_command yazi
check_command kitty
check_command tmux
check_command zsh

printout "[$0] script finished"
printout "All tools are installed correctly"
