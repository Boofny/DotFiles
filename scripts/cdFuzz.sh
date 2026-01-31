#!/bin/bash

#source this script

t_flag=false # tmux flag

while getopts 't' flag; do # check flag status
  case "${flag}" in
    t) t_flag=true;;
    *) return 1
  esac
done

echo "$t_flag"

if $t_flag; then #if t flag is empty that means to things one that it could be not chosen or two that the user did use -t but did not enter a dir name
  choice=$( fd . ./ --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1
  sessionName=$(basename $PWD)
  tmux new-session -A -d -s "$sessionName" # makes tmux session call dev 
  tmux attach -t "$sessionName" # now we attach into the made tmux session
  return 0
fi

# fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'
dir="$1"
if [[ "$dir" == "" ]]; then
  choice=$( fd . ./ --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1
  return 0
else
  choice=$( fd . "$1" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1
  return 0
fi
  
# choice=$( fd . ./$dir/ --type d --exclude go -E node_modules | fzf ) && cd $choice
# return 0
