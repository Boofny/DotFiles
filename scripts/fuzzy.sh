#!/bin/bash

# also need to make quiting better 

RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m' # No Color Reset

y_flag=false # --yes flag
p_flag=false # --preview flag 

while getopts 'yp' flag; do # check flag status
  case "${flag}" in
    y) y_flag=true;;
    p) p_flag=true;;
    *) exit 1
  esac
done

if $p_flag; then 
  choice=$( fd . ~/gitThings/ --type d --exclude node_modules | fzf ) || exit 0
  cd $choice || exit 1
  file=$( fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || exit 1

  sessionName="dev"
  tmux new-session -A -d -s "$sessionName" -c "$choice" # makes tmux session call dev 
  tmux send-keys -t "$sessionName" "nvim \"$file\"" C-m # runs command in tmux session windows end C-m enters it 
  tmux attach -t "$sessionName" # now we attach into the made tmux session
  exit 0
fi

if $y_flag; then # if y flag (the yes) flag is used bypass comfirmation option
  choice=$( fd . ~/gitThings/ --type d --exclude node_modules | fzf ) || exit 0
  cd $choice && tmux
  exit 0
else
  choice=$( fd . ~/gitThings/ --type d --exclude node_modules | fzf ) || exit 0

  printf "%b" "Make tmux session in (${GREEN}$choice${NC})? [y/n]"
  read option

  if [[ $option == "y" || $option == "" ]]; then
    cd $choice && tmux
    exit 0
  fi

  if [[ $option == "n" ]]; then
    echo "Exiting..."
    exit 0
  fi

  # TODO: if no go back to fzf and loop until YES or exit
  if [[ $option != "n" || $option != "y" || $option == "" ]]; then 
    echo "Not an option"
    exit 1
  fi
fi

