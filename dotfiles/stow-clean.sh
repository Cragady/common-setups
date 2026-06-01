#!/usr/bin/zsh

. $HOME/common-setups/dotfiles/stow-config.sh

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
  echo "removing $folder"
  stow -D $folder
done
