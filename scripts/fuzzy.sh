#!/bin/bash

# choice=$(fzf)
choice=$( fd . ./gitThigns/ --type d --exclude node_modules | fzf )
# echo "$choice"

# dir=$(dirname $choice)
# fullPath=$($choice | pwd)

read -p "Make tmux session in ($choice)? [y\n] " option

if [[ $option == "y" || $option == "" ]]; then
 cd $choice && tmux
fi

if [[ $option == "n" ]]; then
  echo "Exiting..."
  exit 1 
fi

if [[ $option != "n" || $option != "y" || $option == "" ]]; then
  echo "Not an option"
  exit 1
fi


# fd . ./gitThigns/ --type d --exclude node_modules .git | fzf
