#! /usr/bin/env bash


if [[ "$1" == "" ]]; then
    printf "\033[33mNeed a file name!\033[0m"
    return
fi

file_name="$1.mp4"

ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 ~/Videos/$file_name

