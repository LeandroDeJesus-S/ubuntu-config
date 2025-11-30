#!/usr/bin/env bash
set -e
printout "[$0] started"

source ./functions.sh
# neovim
echo "Installing neovim"
safe_brew_install neovim
download_or_cp "$nvim_config" ~/.config/nvim

# golang
if [[ ! -f "~/Downloads/go$go_version.linux-amd64.tar.gz" ]]; then
    wget -O "~/Downloads/go$go_version.linux-amd64.tar.gz" "https://go.dev/dl/go$go_version.linux-amd64.tar.gz"
fi
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "~/Downloads/go$go_version.linux-amd64.tar.gz"

# python
safe_brew_install uv
curl -sSL https://install.python-poetry.org | python3 -

printout "[$0] finished"
