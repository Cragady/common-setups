#!/usr/bin/zsh

STOW_FOLDERS="bin,nvim,conky,editorconfig,shells,tmux,vim"

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
  echo "removing $folder"
  stow -D $folder
done
