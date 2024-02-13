let ROOT_DIR = ($env.FILE_PWD | path dirname)
let CONFIG_DIR = $'($env.HOMEPATH)/AppData/Roaming/'

# Copy jj config
let JJ_CONFIG_DIR = $'($CONFIG_DIR)jj'
mkdir $JJ_CONFIG_DIR
cp $'($ROOT_DIR)/configs/jj/config.toml' $JJ_CONFIG_DIR

# Copy helix configs
let HELIX_CONFIG_DIR = $'($CONFIG_DIR)helix'
mkdir $HELIX_CONFIG_DIR
cp $'($ROOT_DIR)/configs/helix/config.toml' $HELIX_CONFIG_DIR
cp $'($ROOT_DIR)/configs/helix/languages.toml' $HELIX_CONFIG_DIR

# Copy wezterm config to HOME directory
cp $'($ROOT_DIR)/configs/wezterm/config.lua' $'($env.HOMEPATH)/.wezterm.lua'
