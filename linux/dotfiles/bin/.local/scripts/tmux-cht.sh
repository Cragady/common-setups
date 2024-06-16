#!/usr/bin/zsh
# TODO: clean up logic, and expand functionality
selected=`cat ~/.config/tmux/.tmux-cht-languages ~/.config/tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

# read -p "Enter Query: " query
vared -p "Enter Query: " -c query

if grep -qs "$selected" ~/.config/tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    search="echo \"curl cht.sh/$selected/$query/\" & curl -s cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    if [[ -z $TMUX ]]; then
      zsh -c $search
    else
      tmux neww zsh -c $search
    fi
else
    search="curl -s cht.sh/$selected~$query | less"
    if [[ -z $TMUX ]]; then
      zsh -c $search
    else
      tmux neww zsh -c $search
    fi
fi

