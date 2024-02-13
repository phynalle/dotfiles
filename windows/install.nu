# cp zellij/config.kdl ~/AppData/Roaming/zellij

let CONFIG_DIR = '~\AppData\Roaming\'

# Copy jj config
let JJ_CONFIG_DIR = $'($CONFIG_DIR)jj'
mkdir $JJ_CONFIG_DIR
cp '../configs/jj/config.toml' $JJ_CONFIG_DIR

# Copy helix configs
let HELIX_CONFIG_DIR = $'($CONFIG_DIR)helix'
mkdir $HELIX_CONFIG_DIR
cp '../configs/helix/config.toml' $HELIX_CONFIG_DIR
cp '../configs/helix/languages.toml' $HELIX_CONFIG_DIR

# Copy wezterm config to HOME directory
cp '../configs/wezterm/.wezterm.lua' ~/
