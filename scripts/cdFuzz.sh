#!/bin/bash

#source this script

# t_flag=false # tmux flag
#
# while getopts 't' flag; do # check flag status
#   case "${flag}" in
#     t) t_flag=true;;
#     *) return 1
#   esac
# done
#
echo "$t_flag"

dir=$1

if  [[ "$2" == "-t" ]]; then
  choice=$( fd . "$dir" --type d --exclude node_modules | fzf )
  sessionName=$(basename $PWD)
  tmux new-session -A -d -s "$sessionName" -c "$choice" # makes tmux session call dev 
  # tmux send-keys -t "$sessionName" "cd "$choice"" C-m # runs command in tmux session windows end C-m enters it 
  tmux attach -t "$sessionName" # now we attach into the made tmux session
  return 0
fi

echo "$dir"
if [[ "$dir" == "" ]]; then # this means current dir by default
  choice=$(fd . ./ -t d --exclude go | fzf) && cd $choice 
  return 1
fi
choice=$(fd . ./$dir/ -t d --exclude node_modules | fzf) && cd $choice
return 0
