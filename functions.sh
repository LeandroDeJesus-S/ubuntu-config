#!/usr/bin/env bash
set -euo pipefail

function try() {
    "$@"
    local status=$?
    if [[ $status -ne 0 ]]; then
        echo "Error with command: $*" >&2
    fi
    return $status
}

# A function to print a formatted message
function printout() {
    local len=${#1}
    local line=$(printf '%.0s=' {1..$len})
    echo "$line"
    echo "$1"
    echo "$line"
}

# A function to run a command with a spinner for user feedback.
# Exits the script if the command fails.

# A function to get a parameter value from the command line arguments
getparam() {
    local key="$1"
    local default="$2"
    [[ -z "$key" ]] && return 1
    shift 2

    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "$key" ]]; then
            echo "$2"
            return 0
        fi
        shift
    done

    echo "$default"
    return 0
}

# if dest already exists, backup it and clone url to dest
safe_git_clone() {
    local url="$1"
    local dest="$2"
    if [[ -d "$dest" ]]; then
        echo "Backup of existing $dest → $dest.bak"
        try mv "$dest" "$dest.bak"
    fi
    try git clone "$url" "$dest"
}

# A function to safely install packages using brew.
# It checks if a package is already installed before attempting installation.
safe_brew_install() {
    if ! cmd_exist brew; then
        echo "brew not available"
        return 1
    fi
    for pkg in "$@"; do
        if ! brew list "$pkg" &>/dev/null; then
            echo "Installing $pkg"
            try brew install "$pkg"
        else
            echo "Package '$pkg' is already installed."
        fi
    done
}

# A function to safely install packages using apt.
# It checks if a package is already installed before attempting installation.
safe_apt_install() {
    if ! cmd_exist apt || ! cmd_exist dpkg; then
        echo "apt or dpkg not available"
        return 1
    fi
    for pkg in "$@"; do
        if ! dpkg -s "$pkg" &>/dev/null; then
            echo "Installing $pkg"
            try apt install -y "$pkg"
        else
            echo "Package '$pkg' is already installed."
        fi
    done
}

# Check if a command exists
cmd_exist() {
    command -v "$1" >/dev/null 2>&1
}

# if src is a directory or file copy it to dest, otherwise clone if it ends with
# .git or download it using wget if it starts with https://
download_or_cp() {
    local src="$1"
    local dest="$2"

    if [[ -d "$src" ]]; then
        try cp -r "$src" "$dest"
    elif [[ -f "$src" ]]; then
        try cp "$src" "$dest"
    elif [[ "$src" =~ \.git$ ]]; then
        safe_git_clone "$src" "$dest"
    elif [[ "$src" =~ ^https:// ]]; then
        try wget -O "$dest" "$src"
    else
        echo "Unknown source $src"
        return 1
    fi

    return 0
}
