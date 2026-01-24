#!/usr/bin/env bash

#this is just a script to add a preveow flag to fzf 
#this script will be sourced

preview_flag=false

while getopts 'p' flag; do # check flag status
  case "${flag}" in
    p) preview_flag=true;;
    *) return 1
  esac
done

if $preview_flag ; then
  fzf --style full --preview 'bat --color=always --style=numbers --line-range=:500 {}' --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'FZF' || exit 1
  exit 0
fi

fzf --style full --margin=0%,0% --layout reverse --border --color 'border:#89b5fa' --border-label 'FZF' || exit 0
