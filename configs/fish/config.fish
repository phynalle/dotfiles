set -x CONFIG_PATH "~/.config/fish/config.fish"

set -x DENO_INSTALL "~/.local"
set -a PATH "$DENO_INSTALL/bin"

set -xg EDITOR hx

eval (direnv hook fish)
jj util completion fish | source

alias ls=exa
alias conf="hx $CONFIG_PATH; and source $CONFIG_PATH"
alias kz="date '+%Y-%0m-%d %H:%M:%S %z (%s)'"

alias node="node --max_old_space_size=8192"

# Display
set -g theme_color_scheme terminal2-dark
