# Shell script settings
A bash script to one-shot configure Ubuntu with my tools preferences.

> NOTE: This script was tested only on Ubuntu 24.04

## Prerequisites

- Ubuntu 24.04 (tested only on this version)
- sudo access
- Internet connection

## Warnings

- This script installs many tools and may modify system files.
- Run at your own risk; review the code before executing.
- Requires sudo, which can be dangerous if misused.

## Usage

```bash
# Clone the repo
git clone https://github.com/LeandroDeJesus/ubuntu-config.git
cd ubuntu-config

# Run the script with default settings
sudo sh ./configure.sh

# Run with custom Go version
sudo sh ./configure.sh -gover 1.25.4

# Run with custom Node version (via nvm)
sudo sh ./configure.sh -npmver 22

# Run with custom Python version
sudo sh ./configure.sh -pythonver 3.12.0

# Run with custom config paths
sudo sh ./configure.sh -lazydockerconf /path/to/lazydocker/config
sudo sh ./configure.sh -lazygitconf /path/to/lazygit/config
sudo sh ./configure.sh -yaziconf /path/to/yazi/config
sudo sh ./configure.sh -nvimconf https://github.com/user/nvim-config.git
sudo sh ./configure.sh -kittyconf /path/to/kitty/config

# Install optional tools
sudo sh ./configure.sh -installopts y

# Combine parameters
sudo sh ./configure.sh -gover 1.24.0 -npmver 20 -installopts y
```

### Parameters

- `-gover <version>`: Specify Go version (default: 1.25.4)
- `-npmver <version>`: Specify Node.js version for nvm install (default: 25)
- `-pythonver <version>`: Specify Python version (default: 3.13.3)
- `-lazydockerconf <path>`: Path to lazydocker config (default: ./dotfiles/lazydocker/)
- `-lazygitconf <path>`: Path to lazygit config (default: ./dotfiles/lazygit/)
- `-yaziconf <path>`: Path to yazi config (default: ./dotfiles/yazi/)
- `-nvimconf <path>`: Path to Neovim config (default: https://github.com/LeandroDeJesus-S/nvim-config.git)
- `-kittyconf <path>`: Path to Kitty config (default: https://github.com/LeandroDeJesus-S/kitty-conf.git)
- `-installopts <y/n>`: Install optional tools (default: n)

### Tools installed

Tools marked with * are optional and installed only if `-installopts y` is passed.

##### Git/GitHub
- git
- gh-cli
- lazygit*
- git-flow*
- git-delta*

##### Docker
- docker
- docker-compose
- docker engine
- lazydocker*

##### Terminal
- kitty
- zsh
- yazi
- tmux
- oh-my-zsh*
- auto suggestions*
- syntax highlighting*
- autocomplete*
- poetry autocomplete*

##### Utilities
- curl
- wget
- homebrew
- ffmpeg
- sevenzip
- jq*
- poppler*
- fd
- ripgrep
- fzf
- zoxide*
- resvg*
- imagemagick*
- font-symbols-only-nerd-font

##### Development
- pyenv
- neovim
- poetry*
- uv
- golang
- node / nvm
- pipx
- pyright
- ruff
- mypy
- gopls
- gotestsum
- pre-commit

## Troubleshooting

- If a tool fails to install, check if dependencies are met (e.g., apt update).
- For permission issues, ensure you're running with sudo.
- If zsh shell change doesn't take effect, log out and back in.
- For Docker issues, ensure the service is started: `sudo systemctl start docker`.
- If Homebrew fails, check the installation path in your PATH.

## Contributing

Feel free to open issues or PRs for improvements. Test changes on Ubuntu 24.04.