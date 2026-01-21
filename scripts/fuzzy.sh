#!/bin/bash

RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m' # No Color Reset

y_flag=false # --yes flag
p_flag=false # --preview flag open files 
h_flag=false # --help flag basicly a sub in for man page just explane what this does 

while getopts 'yph' flag; do # check flag status
  case "${flag}" in
    y) y_flag=true;;
    p) p_flag=true;;
    h) h_flag=true;;
    *) exit 1
  esac
done



if $h_flag; then
  echo " DESCRIPTION:"
  echo "   simple script made for fast and easy access for a users most used work directory"
  echo "   user defines their main working dir and this script will open a tmux session for the chosen directory" 
  echo 
  echo " USAGE:"
  echo "   fg [Flag]     by default this program will use your most used work directory defined in .bashrc as MAINWORKDIR"
  echo "   with additional flags for better movment around the terminl"
  echo
  echo " INPUT OPTIONS:"
  echo "   -h            help and show options"
  echo "   -y            skips past the comfirmation and straght into tmux"
  echo "   -p            in the open directory will fuzzy find and preview files and once selected will open file with chosen EDITOR"
  echo "                 defined in bashrc"
  exit 0
fi




if $p_flag; then 
  choice=$( fd . "$MAINWORKDIR" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'
  ) && cd $choice || exit 1
  sessionName=$(basename $PWD)

  file=$(fd . ./ --type file --exclude node_modules -E go -E .git | 
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim') ||
  exit 0
  tmux new-session -A -d -s "$sessionName" -c "$choice" # makes tmux session call dev 
  tmux send-keys -t "$sessionName" ""$EDITOR" \"$file\"" C-m # runs command in tmux session windows end C-m enters it 
  tmux attach -t "$sessionName" # now we attach into the made tmux session
  exit 0
fi




if $y_flag; then # if y flag (the yes) flag is used bypass comfirmation option
  choice=$( fd . "$MAINWORKDIR" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'
  ) && cd $choice || exit 1
  sessionName=$(basename $PWD)
  tmux new-session -A -d -s "$sessionName" -c "$choice" # makes tmux session call dev 
  tmux attach -t "$sessionName" # now we attach into the made tmux session
  exit 0
else

  choice=$( fd . "$MAINWORKDIR" --type d --exclude go -E node_modules | 
  \fzf --style full --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Vim'
  ) || exit 1

  printf "%b" "Make tmux session in (${GREEN}$choice${NC})? [y/n]"
  read option

  if [[ $option == "y" || $option == "" ]]; then
    cd $choice || exit 1
    sessionName=$(basename $PWD)
    tmux new-session -A -d -s "$sessionName" -c "$choice" # makes tmux session call dev 
    tmux attach -t "$sessionName" # now we attach into the made tmux session
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

