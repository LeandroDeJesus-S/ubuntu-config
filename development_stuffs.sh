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

if go version &> /dev/null; then
    go install golang.org/x/tools/gopls@latest
fi

# python
safe_brew_install uv
curl -sSL https://install.python-poetry.org | python3 -

# node / nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

\. "$HOME/.nvm/nvm.sh"

try nvm install 25

if ! node -v ; then
    echo "failed to install node"
else if ! nvm current ; then
    echo "failed to install nvm"
else if ! npm -v ; then
    echo "failed to install npm"
fi

# pipx
sudo apt install pipx
pipx ensurepath
# sudo pipx ensurepath --global # optional to allow pipx actions with --global argument

pipx install pyright ruff mypy pre-commit

printout "[$0] finished"
