#!/bin/bash

RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m' # No Color Reset

y_flag=false

while getopts 'y' flag; do # check flag status
  case "${flag}" in
    y) y_flag=true;;
    *) exit 1
  esac
done

if $y_flag; then # if y flag (the yes) flag is used bypass comfirmation option
  choice=$( fd . ~/gitThings/ --type d --exclude node_modules | fzf )
  cd $choice && tmux
else
  command
  choice=$( fd . ~/gitThings/ --type d --exclude node_modules | fzf )

  # read -p "${RED}Make tmux session in ($choice)? [y\n] ${NC}" option
  printf "%b" "Make tmux session in (${GREEN}$choice${NC})? [y/n]"
  read option

  if [[ $option == "y" || $option == "" ]]; then
   cd $choice && tmux
  fi

  if [[ $option == "n" ]]; then
    echo "Exiting..."
    exit 1 
  fi

  # TODO: if no go back to fzf and loop until YES or exit
  if [[ $option != "n" || $option != "y" || $option == "" ]]; then 
    echo "Not an option"
    exit 1
  fi
fi
