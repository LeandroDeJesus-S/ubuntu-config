#!/usr/bin/bash
set -e
sudo apt update && sudo apt upgrade -y
sudo apt install curl
echo "$(curl --version) installed"

# git
sudo apt install git -y
echo "$(git --version) installed successfully"

# github cli
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y


# zsh
sudo apt install zsh-autosuggestions zsh-syntax-highlighting zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# auto-suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

echo -e "export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
" >> ~/.zshrc

# python build dependencies
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

# pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

echo "$(pyenv --version) installed successfully"

# poetry
curl -sSL https://install.python-poetry.org | python3 -

mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# syncing .zshrc file plugins
sed -i "s/plugins=(git)/plugins=(git poetry zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/" ~/.zshrc

# oh-my-zsh theme
sed -i "s/$(cat ~/.zshrc | grep 'ZSH_THEME=')/ZSH_THEME='random'\nZSH_THEME_RANDOM_CANDIDATES=('amuse' 'cloud' 'jonathan')/"

# docker engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "$(sudo docker --version) and $(sudo docker compose version) installed successfully"

# vscode
sudo snap install code --classic
