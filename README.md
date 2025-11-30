# Shell script settings
A bash script to one-shot configure Ubuntu with my tools preferences.

> NOTE: This script was tested only on Ubuntu 24.04

## Usage

```bash
# clone the repo
git clone https://github.com/LeandroDeJesus/ubuntu-config.git
# go to the repo
cd ubuntu-config
# run the script
sudo sh ./configure.sh

# optionally, you can pass the go version as argument
sudo sh ./configure.sh -gover 1.25.4
```

### Tools installed

##### Git/GitHub
- git
- lazygit
- gh-cli
- git-flow

##### Docker
- docker
- docker-compose
- docker engine
- lazydocker

##### Terminal
- kitty
- zsh
- oh-my-zsh 
- auto suggestions 
- syntax highlighting 
- autocomplete 
- poetry autocomplete
- yazi
- tmux

##### Utilities
- curl
- wget
- homebrew
- ffmpeg 
- sevenzip 
- jq 
- poppler 
- fd 
- ripgrep 
- fzf 
- zoxide 
- resvg 
- imagemagick 
- font-symbols-only-nerd-font

##### Development
- pyenv
- neovim
- poetry
- uv
- golang
