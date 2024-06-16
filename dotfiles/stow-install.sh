#!/bin/zsh

STOW_FOLDERS="bin,nvim,conky,editorconfig,shells,tmux,vim"

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
  echo "stow $folder"
  stow $folder -t $HOME
  if (( $? == 1 )); then
    echo "stow failed, attempting to adopt $folder"
    stow --adopt $folder -t $HOME
  fi
done
