set -x CONFIG_PATH "~/.config/fish/config.fish"

source ~/.cargo/env
set -xg EDITOR vim

direnv hook fish | source

alias ls=exa
alias vi=nvim
alias vim=nvim
alias viconf="vi ~/.config/nvim/init.vim"
alias conf="vi $CONFIG_PATH; and source $CONFIG_PATH"

# Display
set -g theme_color_scheme terminal2-dark
