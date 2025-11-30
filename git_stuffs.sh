#!/usr/bin/env bash
set -e

printout "[$0] started"

source ./functions.sh
sudo apt install git -y >/dev/null

safe_brew_install gh

sudo apt install git-flow -y

safe_brew_install lazygit

printout "[$0] finished"
