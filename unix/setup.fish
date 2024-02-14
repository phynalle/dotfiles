#!/usr/bin/env fish
set -x CURRENT_DIR (realpath (status --current-filename) | path dirname)

fish $CURRENT_DIR/install_configs.fish

curl -L https://get.oh-my.fish | fish
omf install agnoster

git config --global user.email "phynalism@gmail.com"
git config --global user.name "phynalle"
git config --global merge.tool diff3
