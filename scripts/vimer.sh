#!/usr/bin/env bash

# what this file will kinda be will be like if neovim did not need fzf
# when the script is ran like nvim and not args then open fzf and exlude things like node_modls and hidden files
#
# if nvim is ran with a file name or a dir then open as normal 
#   if it is a dir then open fzf in that dir 

# slime=$(fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --border-label 'Vim')

if [[ "$1" == "" ]]; then  # just the neovim command alone open the current dir
  # choice=$( fd . ./ --type file --exclude node_modules -E go -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || exit 0

  #62bcc6
  #99c379;
  choice=$(fd . ./ --type file --exclude node_modules -E go -E .git | 
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#62bcc6' --border-label 'Vim') ||
  exit 0
  vim $choice
  exit 0
fi

if [[ -d "$1" ]]; then # this checks if a input is a file or dir
  # choice=$( fd . ./"$1" --type file --exclude node_modules -E go -E .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || exit 0
  # choice=$(fd . "$1" --type file --exclude node_modules -E go -E .git | $slime) || exit 0
  # echo $choice 

  choice=$(fd . "$1" --type file --exclude node_modules -E go -E .git | 
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#62bcc6' --border-label 'Vim') ||
  exit 0
  vim $choice
  # choice=$(fd . "$1" --type file --exclude node_modules -E go -E .git | 
  # fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --border-label 'Vim') ||
  # exit 0
  # vim $choice

  echo "is a dir"
  exit 0
else 
  vim $1
  echo "is a file"
  exit 0
fi


# fzf --style full     --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --border-label 'Vim'
