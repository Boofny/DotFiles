#!/bin/bash
#source this script

# fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'

dir="$1"
if [[ "$dir" == "" ]]; then

  choice=$( fd . ./ --type d --exclude go -E node_modules | 
  \fzf --style full --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf "\033[33m Git Pull? [y]: \033[0m"
    read pull
    if [[ "$pull" == "y" ]]; then 
      printf "\033[32m Pulling...\033[0m"
      git pull
      return 0
    fi

  else
    return 1
  fi

else
  choice=$( fd . "$1" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'CDF'
  ) && cd $choice || return 1

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

    printf "\033[33m Git Pull? [y]: \033[0m"
    read pull
    if [[ "$pull" == "y" ]]; then 
      printf "\033[31m Pulling...\033[0m"
      git pull
      return 0
    fi

  else
    return 1
  fi

fi
  
# choice=$( fd . ./$dir/ --type d --exclude go -E node_modules | fzf ) && cd $choice
# return 0
