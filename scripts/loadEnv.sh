#! /usr/bin/env bash


if [[ $1 == "" ]]; then # no file name given
  printf "Error no file named"
  return 0 # use this for source scripts
fi

set -a && source $1 && set +a
