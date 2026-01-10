#!/bin/bash

#this script will be used to set up a new arch env when needed for all packages and hopfully some configs like tmux and starship
#and maybe things like git with ssh

packages=(
  postgresql
  docker
  git 
  openssh 
  fastfetch 
  neovim 
  vim 
  xclip 
  ripgrep 
  lazygit 
  gcc 
  go 
  clang 
  python 
  nodejs 
  npm 
  tmux 
  starship
  curl
)

sudo pacman -Syu --needed "${packages[@]}"

eval "$(starship init bash)"
