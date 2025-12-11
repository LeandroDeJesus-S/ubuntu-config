#!/usr/bin/env bash
set -euo pipefail
source ./functions.sh

try apt update

DEFAULT_GO_VERSION="1.25.4"
DEFAULT_NPM_VERSION="25"
DEFAULT_PYTHON_VERSION="3.13.3"

DEFAULT_NVIM_CONFIG="https://github.com/LeandroDeJesus-S/nvim-config.git"
DEFAULT_LAZYDOCKER_CONFIG="./dotfiles/lazydocker/"
DEFAULT_LAZYGIT_CONFIG="./dotfiles/lazygit/"
DEFAULT_YAZI_CONFIG="./dotfiles/yazi/"
DEFAULT_KITTY_CONFIG="https://github.com/LeandroDeJesus-S/kitty-conf.git"

go_version=$(getparam -gover "$DEFAULT_GO_VERSION" "$@")
npm_version=$(getparam -npmver "$DEFAULT_NPM_VERSION" "$@")
python_version=$(getparam -pythonver "$DEFAULT_PYTHON_VERSION" "$@")

lazydocker_config=$(getparam -lazydockerconf "$DEFAULT_LAZYDOCKER_CONFIG" "$@")
lazygit_config=$(getparam -lazygitconf "$DEFAULT_LAZYGIT_CONFIG" "$@")
yazi_config=$(getparam -yaziconf "$DEFAULT_YAZI_CONFIG" "$@")
nvim_config=$(getparam -nvimconf "$DEFAULT_NVIM_CONFIG" "$@")
kitty_config=$(getparam -kittyconf "$DEFAULT_KITTY_CONFIG" "$@")

install_optionals=$(getparam -installopts "n" "$@")
if [[ "$install_optionals" == "y" ]]; then
    install_optionals=true
else
    install_optionals=false
fi

printout "[$0] started"

# common utilitaries  WARN: must be the first
. ./utilitaries.sh

# git stuffs
. ./git_stuffs.sh

# docker engine
. ./docker_stuffs.sh

# development stuffs
. ./development_stuffs.sh

# terminal stuffs    WARN: requires git
. ./terminal_stuffs.sh

# setup config files
download_or_cp ./dotfiles/.zshrc ~/.zshrc
download_or_cp "$nvim_config" ~/.config/nvim
download_or_cp "$lazydocker_config" ~/.config/lazydocker
download_or_cp "$lazygit_config" ~/.config/lazygit
download_or_cp "$yazi_config" ~/.config/yazi
source ~/.zshrc

. ./verify.sh

printout "[$0] finished"
