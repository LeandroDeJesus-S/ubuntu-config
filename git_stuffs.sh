#!/usr/bin/env bash
set -euo pipefail

printout "[$0] started"

source ./functions.sh
safe_apt_install git gh

$install_optionals && safe_apt_install git-flow && safe_brew_install git-delta && safe_brew_install lazygit

printout "[$0] finished"
