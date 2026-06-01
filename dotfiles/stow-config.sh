#!/bin/bash

STOW_FOLDERS="bin,nvim,conky,editorconfig,shells,tmux,vim,systemd"

# NOTE:
# To preserve relative pathing use this in the script somewhere: SCRIPT_DIR=$(dirname "$0")
# this is only needed if you don't execute the scripts that use this file in a dir where these scripts don't exist.
# Can also do anther workaround, like using other variable expansion to ensure correct pathing, like $HOME.
# . $HOME/common-setups/dotfiles/stow-config.sh
