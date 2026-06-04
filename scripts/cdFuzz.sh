#!/bin/bash
#source this script

# fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'

dir="$1"
if [[ "$dir" == "" ]]; then

  choice=$( fd . ./ --type d --exclude go -E node_modules | 
  \fzf --style full --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	  # printf "\033[H\033[2J"
    printf "\033[33mDont forget to git pull!\033[0m"
  fi

else

  choice=$( fd . "$1" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	  # printf "\033[H\033[2J"
    printf "\033[33mDont forget to git pull!\033[0m"
  fi

fi
  
# choice=$( fd . ./$dir/ --type d --exclude go -E node_modules | fzf ) && cd $choice
# return 0
