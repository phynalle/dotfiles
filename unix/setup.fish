#!/usr/bin/env fish
set -x CURRENT_DIR (realpath (status --current-filename) | path dirname)

curl -L https://get.oh-my.fish | fish
omf install fzf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

fish $CURRENT_DIR/install_configs.fish

# Settings for rust
rustup install stable
rustup component add rls rust-analysis rust-src clippy rustfmt

git config --global user.email "phynalism@gmail.com"
git config --global user.name "phynalle"
git config --global merge.tool diff3
