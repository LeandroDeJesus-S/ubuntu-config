#!/usr/bin/env bash
set -e

printout "[$0] script started"

source ./functions.sh
safe_brew_install yazi

# kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

safe_git_clone "$kitty_config" ~/.config/kitty

# zsh
safe_brew_install zsh
sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

if $install_optionals; then
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # auto-suggestion
    safe_brew_install zsh-autosuggestions
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # syntax highlighting
    safe_git_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    safe_git_clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    # autocomplete
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]]; then
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    fi

    # poetry autocomplete
    mkdir -p ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/poetry
    poetry completions zsh >${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/poetry/_poetry
fi

printout "[$0] script finished"
