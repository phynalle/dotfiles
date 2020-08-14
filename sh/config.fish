set -x CONFIG_PATH "~/.config/fish/config.fish"

set -x DENO_INSTALL "/home/phynalle/.local"
set -a PATH "$DENO_INSTALL/bin"

source ~/.cargo/env
set -xg EDITOR vim

direnv hook fish | source

alias ls=exa
alias vi=nvim
alias vim=nvim
alias viconf="vi ~/.config/nvim/init.vim"
alias conf="vi $CONFIG_PATH; and source $CONFIG_PATH"
alias kz="date '+%Y-%0m-%d %H:%M:%S %z (%s)'"

alias node="node --max_old_space_size=8192"

# Display
set -g theme_color_scheme terminal2-dark
