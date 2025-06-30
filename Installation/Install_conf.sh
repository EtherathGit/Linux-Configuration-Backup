#!/bin/bash

# Define the error handler
on_error() {
  echo "$(tput bold)❌ Error occurred while $CURRENT$(tput sgr0)"
  exit 1
}

# Register the trap
trap on_error ERR

# Define Backup Folder
CURRENT="initializing"
BACKUP_DIR="${CONF_DIR_CUSTOM:-$HOME/.ConfigurationBackup}/_BackupFiles"

# List files to retore
CURRENT="loading configuration files list"
source "${CONF_DIR_CUSTOM:-$HOME/.ConfigurationBackup}/Ressources/ConfigurationFiles.sh"

# Install listed files
for FILE in "${FILES[@]}"; do
  CURRENT="restoring $FILE"
  cp -u "$BACKUP_DIR$FILE" "$FILE"
done

# Install VSCode Profiles
CURRENT="installing VSCode Profiles"
cp -r "$BACKUP_DIR$(dirname "$VSCODE_PATH")" "$VSCODE_PATH"

# Install VSCode Extensions
CURRENT="installing VSCode Extensions"
xargs -n1 code --install-extension < "$BACKUP_DIR/VSCode_entension.txt"

# Done
echo "$(tput bold)$(tput setaf 2)✓ Configuration files restored.$(tput sgr0)"