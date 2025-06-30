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

# List files to backup
CURRENT="loading configuration files list"
source "${CONF_DIR_CUSTOM:-$HOME/.ConfigurationBackup}/Ressources/ConfigurationFiles.sh"

# Backup listed files
for FILE in "${FILES[@]}"; do
  CURRENT="copying $FILE"
  DEST="$BACKUP_DIR$(dirname "$FILE")"
  mkdir -p "$DEST"
  cp -u "$FILE" "$DEST/"
done

# Backup VSCode Profiles
CURRENT="saving VSCode Profiles"
DEST="$BACKUP_DIR$(dirname "$VSCODE_PATH")"
mkdir -p "$BACKUP_DIR$(dirname "$VSCODE_PATH")"
cp -r "$VSCODE_PATH" "$DEST"

# Backup VSCode Extensions
CURRENT="saving VSCode Extensions"
code --list-extensions > "$BACKUP_DIR/VSCode_entension.txt"

# Done
echo "$(tput bold)$(tput setaf 2)✓ Backup configuration files completed.$(tput sgr0)"