#!/usr/bin/env bash
printout "[$0] started"

source ./functions.sh
# neovim
echo "Installing neovim"
safe_brew_install neovim

# golang
if [[ ! -f "~/Downloads/go$go_version.linux-amd64.tar.gz" ]]; then
    wget -O "~/Downloads/go$go_version.linux-amd64.tar.gz" "https://go.dev/dl/go$go_version.linux-amd64.tar.gz"
fi
rm -rf /usr/local/go && tar -C /usr/local -xzf "~/Downloads/go$go_version.linux-amd64.tar.gz"

if cmd_exist go; then
    go install golang.org/x/tools/gopls@latest
    go install gotest.tools/gotestsum@latest
fi

# pyenv
safe_brew_install pyenv

# add temporary pyenv to path to install python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv install $python_version

# python
safe_brew_install uv
$install_optionals && curl -sSL https://install.python-poetry.org | python3 -

# node / nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

\. "$HOME/.nvm/nvm.sh"

try nvm install $npm_version

# pipx
safe_apt_install pipx
pipx ensurepath
pipx install pyright ruff mypy pre-commit

printout "[$0] finished"
