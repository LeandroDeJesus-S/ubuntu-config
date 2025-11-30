#!/usr/bin/env bash
set -e

printout "[$0] script started"

source ./functions.sh
if ! curl --version &>/dev/null; then
    sudo apt install curl
    echo "$(curl --version) installed"
fi

if ! brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "$(brew --version) installed"
fi

safe_brew_install wget ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font

printout "[$0] script finished"
