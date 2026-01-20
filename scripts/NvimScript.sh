#!/bin/bash

# what this file will kinda be will be like if neovim did not need fzf
# when the script is ran like nvim and not args then open fzf and exlude things like node_modls and hidden files
#
# if nvim is ran with a file name or a dir then open as normal 
#   if it is a dir then open fzf in that dir 

if [[ "$1" == "" ]]; then  # just the neovim command alone open the current dir
  choice=$( fd . ./ --type file --exclude node_modules -E go -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || exit 0
  vim $choice
  exit 0
fi

if [[ -d "$1" ]]; then # this checks if a input is a file or dir
  choice=$( fd . ./"$1" --type file --exclude node_modules -E go -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || exit 0
  echo $choice 
  vim $choice
  echo "is a dir"
  exit 0
else 
  vim $1
  echo "is a file"
  exit 0
fi
