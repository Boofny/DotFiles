# /usr/bin/env bash

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

mkdir include 
mkdir include/${name}
mkdir src
touch CMakeLists.txt
touch .gitignore

touch src/main.cpp
touch src/test.cpp
touch include/${name}/test.hpp

cat >> CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.16)
project(cmd LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # this fixed lsp problem

file(GLOB SOURCES src/*.cpp) # compiles ALL files in src change as needed

add_executable(cmd ${SOURCES})

if (MSVC)
    target_compile_options(cmd PRIVATE /W4)
else()
    target_compile_options(cmd PRIVATE -Wall -Wextra)
endif()

# uncomment if need json lib
# target_link_libraries(cmd PRIVATE jsoncpp)

target_include_directories(cmd
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include
)
EOF

cat >> src/main.cpp <<EOF
#include <iostream>
#include "${name}/test.hpp"

int main(int argc, char *argv[]){
  std::cout << "Hello world" << std::endl;
  Test::greet();
  return 0;
}

EOF

cat >> include/${name}/test.hpp <<EOF
#pragma once

namespace Test{
  void greet();
}

EOF

cat >> src/test.cpp <<EOF
#include <iostream>
#include "${name}/test.hpp"

void Test::greet(){
  std::cout << "hello from testing hpp" << std::endl;
}

EOF

cat >> .gitignore <<EOF
build
EOF


printf "\nStart by doing "
echo ""
printf "\n  cd ${name}"
printf "\n  [cmake -S . -B build] to init cmake build once"
printf "\n  cmake --build build"
printf "\n  ./build/cmd"

