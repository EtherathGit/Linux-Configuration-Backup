#!bin/bash

# Load application lists
CURRENT="loading application lists"
source "${CONF_DIR_CUSTOM:-$HOME/.ConfigurationBackup}/Ressources/ApplicationBasics.sh"

# Get installation functions
CURRENT="loading installation functions files"
source "${CONF_DIR_CUSTOM:-$HOME/.ConfigurationBackup}/Installation/Install_app_common.sh"

# Start
install_all