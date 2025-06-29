#!/bin/bash

# Define the error handler
on_error() {
  echo "❌ Error occurred while processing: $CURRENT"
  exit 1
}

# Register the trap
trap on_error ERR

# Set Current status
CURRENT="initializing"

# Define Backup Folder
BACKUP_DIR=~/.FedoraConfiguration/_BackupFiles

# List files to retore
FILES=(
  "$HOME/.p10k.zsh"
  "$HOME/.zshrc"
)

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
echo "✔️ Backup configuration files done"