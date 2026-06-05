#! /usr/bin/env bash

# this command will be like cargo init ./ usnig the current dir other than the root 

dirName=$(basename $PWD)

firstChar="${dirName:0:1}"

if [[ $firstChar == "." ]]; then
  printf "\033[31mCan't make project in a Dot directory: $dirName \33[0m"
  exit 1
fi

if [[ $dirName == $USER ]]; then
  printf "\033[31mCan't make project in root directory: $dirName \33[0m"
  exit 1
fi

go mod init $(basename $PWD)
touch main.go

cat >> main.go <<EOF
package main

import "fmt"

func main(){
  fmt.Println("Hello ${dirName}")
}
EOF

printf "\nGet Started by doing "
echo ""
printf "\n  go run main.go"
