#!/usr/bin/env bash
source ./functions.sh

try sudo apt update && try sudo apt upgrade -y

BASEORG="https://github.com/LeandroDeJesus-S/ubuntu-config/blob/main/dotfiles"

DEFAULT_GO_VERSION="1.25.4"
DEFAULT_NVIM_CONFIG="https://github.com/LeandroDeJesus-S/nvim-config.git"
DEFAULT_LAZYDOCKER_CONFIG="$BASEORG/lazydocker/config.yml"
DEFAULT_LAZYGIT_CONFIG="$BASEORG/lazygit/config.yml"
DEFAULT_YAZI_CONFIG="$BASEORG/yazi"
DEFAULT_KITTY_CONFIG="https://github.com/LeandroDeJesus-S/kitty-conf.git"


go_version=$(getparam -gover "$DEFAULT_GO_VERSION" "$@")
lazydocker_config=$(getparam -lazydockerconf "$DEFAULT_LAZYDOCKER_CONFIG" "$@")
lazygit_config=$(getparam -lazygitconf "$DEFAULT_LAZYGIT_CONFIG" "$@")
yazi_config=$(getparam -yaziconf "$DEFAULT_YAZI_CONFIG" "$@")
nvim_config=$(getparam -nvimconf "$DEFAULT_NVIM_CONFIG" "$@")
kitty_config=$(getparam -kittyconf "$DEFAULT_KITTY_CONFIG" "$@")

printout "[$0] started"

# common utilitaries  WARN: must be the first
./utilitaries.sh

# git stuffs
./git_stuffs.sh

# pyenv
safe_brew_install pyenv
echo "pyenv installed successfully, restart your shell to apply changes"

# docker engine
./docker_stuffs.sh

# development stuffs
./development_stuffs.sh

# terminal stuffs    WARN: requires git
./terminal_stuffs.sh

printout "[$0] finished"
