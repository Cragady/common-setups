#!/usr/bin/zsh
selected=`cat ~/.config/tmux/.tmux-cht-languages ~/.config/tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

# read -p "Enter Query: " query
vared -p "Enter Query: " -c query

if grep -qs "$selected" ~/.config/tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww zsh -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww zsh -c "curl -s cht.sh/$selected~$query | less"
fi

