#!/usr/bin/env fish
set -x FISH_CONFIG_PATH ~/.config/fish/config.fish
set -x VIM_CONFIG_PATH ~/.config/nvim/init.vim

curl -L https://get.oh-my.fish | fish
omf install fzf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p (dirname $FISH_CONFIG_PATH)
ln -s (realpath sh/config.fish) $FISH_CONFIG_PATH
source $FISH_CONFIG_PATH

mkdir -p (dirname $VIM_CONFIG_PATH)
ln -s (realpath vim/base.vim) $VIM_CONFIG_PATH

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vi +PlugInstall

# Settings for rust
rustup install stable
rustup component add rls rust-analysis rust-src clippy rustfmt

git config --global user.email "phynalism@gmail.com"
git config --global user.name "phynalle"
git config --global merge.tool diff3
