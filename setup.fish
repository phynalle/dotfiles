#!/usr/bin/env fish
set -x FISH_CONFIG_PATH ~/.config/fish/config.fish
set -x VIM_CONFIG_PATH ~/.config/nvim/init.vim

curl -L https://get.oh-my.fish | fish
omf install fzf

ln -s (realpath sh/config.fish) $FISH_CONFIG_PATH
source $FISH_CONFIG_PATH

ln -s (realpath vim/base.vim) $VIM_CONFIG_PATH

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vi +PlugInstall
