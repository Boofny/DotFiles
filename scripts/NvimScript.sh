#!/bin/bash

c_flag=false # --clean flag

while getopts 'c' flag; do # check flag status
  case "${flag}" in
    c) c_flag=true;;
    *) exit 1
  esac
done

if $c_flag; then
  NVIM_APPNAME=nvim-minimal nvim $1
else 
  nvim $1
fi

alias nvim='bash ./NvimScript.sh'
# NVIM_APPNAME=nvim-minimal
