#! /usr/bin/env bash

# works for now gonna test it out to see how it works 
# branch=$(git branch | fzf --style full --margin=20%,20% --layout reverse --border --color 'border:#89b5fa' --border-label 'Branches')
branch=$( git branch | fzf --height 40% --layout=reverse --info=inline --no-separator )

git checkout $branch
