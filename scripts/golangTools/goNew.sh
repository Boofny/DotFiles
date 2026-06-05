#! /usr/bin/env bash

# this command will be like cargo new <path name>
baseDir=$(basename $PWD)
firstChar="${baseDir:0:1}"

if [[ $firstChar == "." ]]; then
  printf "\033[31mCan't make project in a Dot directory: $baseDir \33[0m"
  exit 1
fi

printf "\033[33mEnter Project Name: \033[0m"
read name
mkdir ./$name

cd "$name" || exit 1
go mod init $(basename $PWD)
touch main.go

dirName=$(basename $PWD)

cat >> main.go <<EOF
package main

import "fmt"

func main(){
  fmt.Println("Hello ${dirName}")
}
EOF

printf "\nStart by doing "
echo ""
printf "\n  cd ${name}"
printf "\n  go run main.go"
