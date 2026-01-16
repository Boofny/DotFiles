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

# can also add if dir is emty with no other dirs idk





# basic usage and will mabye add the 

dir=$1
echo "$dir"
if [[ "$dir" == "" ]]; then # this means current dir by default
  choice=$(fd . ./$dir/ -t d --exclude go | fzf) && cd $choice 
  return 1
fi
choice=$(fd . ./$dir/ -t d --exclude node_modules | fzf) && cd $choice
return 0







# function cdIntoFZFDir(){
#   # can also add if dir is emty with no other dirs idk
#   dir=$1
#   if [[ "$dir" == "" ]]; then # this means current dir by default
#     choice=$(fd . ./$dir/ -t d --exclude go | fzf) && cd $choice 
#     return 1
#   fi
#   choice=$(fd . ./$dir/ -t d --exclude node_modules | fzf) && cd $choice
#   return 0
# }
#
# cdIntoFZFDir


# this is the windows one that i made in class and want to klnow how it works and why the linux one did not
