#! /usr/bin/env bash

# Parse -f flag for frame rate
while getopts "f:" opt; do
  case $opt in
    f) framerate="$OPTARG" ;;
    *) echo "Usage: $0 -f <framerate>"; exit 1 ;;
  esac
done

framerate="${framerate:-30}"

if [[ "$1" == "" ]]; then
    printf "\033[33mNeed a file name!\033[0m"
    return
fi

file_name="$1.mp4"

ffmpeg -video_size 1920x1080 -framerate "$framerate" -f x11grab -i :0.0 "$HOME/videos/$file_name"

