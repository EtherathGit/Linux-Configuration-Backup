#!/bin/bash

# Define the error handler
on_error() {
  echo "❌ Error occurred while processing: $CURRENT"
  exit 1
}

# Register the trap
trap on_error ERR

# Define Backup Folder
CURRENT="initializing"
BACKUP_DIR=~/.ConfigurationBackup/_BackupFiles

# List files to retore
CURRENT="load configuration files list"
source "$HOME/.ConfigurationBackup/Ressources/ConfigurationFiles.sh"

# Install listed files
for FILE in "${FILES[@]}"; do
  CURRENT="restoring $FILE"
  cp -u "$BACKUP_DIR$FILE" "$FILE"
done

# Install VSCode Profiles
CURRENT="Installing VSCode Profiles"
VSCODE_PATH="$HOME/.config/Code/User"
cp -r "$BACKUP_DIR$(dirname "$VSCODE_PATH")" "$VSCODE_PATH"

# Install VSCode Extensions
CURRENT="Installing VSCode Extensions"
xargs -n1 code --install-extension < "$BACKUP_DIR/VSCode_entension.txt"

# Done
echo -e "\n✔️ \033[1;32mConfiguration files restored. \033[0m"