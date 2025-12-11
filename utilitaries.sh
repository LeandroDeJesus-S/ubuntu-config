#!/usr/bin/env bash
set -e

printout "[$0] script started"

source ./functions.sh

if ! cmd_exist git; then
    safe_apt_install git
fi

if ! cmd_exist curl; then
    safe_apt_install curl
fi

if ! cmd_exist brew; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash /dev/stdin
    echo >>/root/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/root/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

safe_brew_install wget ffmpeg sevenzip fd ripgrep fzf font-symbols-only-nerd-font
if $install_optionals; then
    safe_brew_install jq poppler zoxide resvg imagemagick
fi

printout "[$0] script finished"
