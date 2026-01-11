#!/bin/bash

#this script will be used to set up a new arch env when needed for all packages and hopfully some configs like tmux and starship
#and maybe things like git with ssh 
# still need to perfect this script but at a good stopping point

packages=(
  neovim 
  vim 
  ufw
  base-devel
  postgresql
  docker
  git 
  openssh 
  fastfetch 
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

curl https://raw.githubusercontent.com/Boofny/DotFiles/refs/heads/main/zshStarShip.txt >> ~/.config/starship.toml
