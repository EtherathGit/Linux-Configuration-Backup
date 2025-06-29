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

# List files to backup
FILES=(
  "$HOME/.p10k.zsh"
  "$HOME/.zshrc"
)

# Backup listed files
for FILE in "${FILES[@]}"; do
  CURRENT="copying $FILE"
  DEST="$BACKUP_DIR$(dirname "$FILE")"
  mkdir -p "$DEST"
  cp -u "$FILE" "$DEST/"
done

# Backup VSCode Profiles
CURRENT="Backup VSCode Profiles"
VSCODE_PATH="$HOME/.config/Code/User"
DEST="$BACKUP_DIR$(dirname "$VSCODE_PATH")"
mkdir -p "$BACKUP_DIR$(dirname "$VSCODE_PATH")"
cp -r "$VSCODE_PATH" "$DEST"

# Backup VSCode Extensions
CURRENT="Backup VSCode Extensions"
code --list-extensions > "$BACKUP_DIR/VSCode_entension.txt"

# Done
echo "✔️ Backup configuration files done"