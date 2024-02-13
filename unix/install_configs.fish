#!/usr/bin/env fish
set -x ROOT_DIR (realpath (status --current-filename) | path dirname | path dirname)

mkdir -p ~/.config/fish
ln -s $ROOT_DIR/configs/fish/config.fish ~/.config/fish/
source $FISH_CONFIG_PATH

mkdir -p ~/.config/jj
ln -s $ROOT_DIR/configs/jj/config.toml ~/.config/jj/

mkdir -p ~/.config/helix
ln -s $ROOT_DIR/configs/helix/config.toml ~/.config/helix/
ln -s $ROOT_DIR/configs/helix/languages.toml ~/.config/helix/

mkdir -p ~/.config/zellij
ln -s $ROOT_DIR/configs/zellij/config.kdl ~/.config/zellij/
