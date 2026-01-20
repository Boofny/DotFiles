#!/usr/bin/env bash

if [[ "$1" == "" ]]; then  # just the neovim command alone open the current dir
# fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Find'
  choice=$(fd . ./ --type file --exclude node_modules -E go -E .git | 
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Find') ||
  exit 0
  vim $choice
  exit 0
fi

if [[ -d "$1" ]]; then # this checks if a input is a file or dir
  choice=$(fd . "$1" --type file --exclude node_modules -E go -E .git | 
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=10%,10% --layout reverse --border --color 'border:#89b5fa' --border-label 'Find') ||
  exit 0
  vim $choice

  echo "is a dir"
  exit 0
else 
  vim $1
  echo "is a file"
  exit 0
fi

