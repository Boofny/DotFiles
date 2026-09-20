#!/usr/bin/env bash

options="Suspend\nExit i3\n"

choice=$(printf "$options" | rofi -dmenu -i -p "Power" -no-custom -lines 5)

case "$choice" in
  "Suspend")   systemctl suspend ;;
  "Exit i3")   i3-msg exit ;;
esac
