#!bin/bash

# Define the error handler
on_error() {
  echo "$(tput bold)❌ Error occurred while $CURRENT$(tput sgr0)"
  exit 1
}

# Register the trap
trap on_error ERR

# Starting
CURRENT="starting"
echo "$(tput bold)==> Starting CLI base installation...$(tput sgr0)"

# Install Zsh
CURRENT="instaling Zsh"
echo 'Install Zsh'
sudo dnf install zsh -y

# Install Oh-My-Zsh
CURRENT="instaling OMZ"
echo 'Install Oh-My-Zsh (OMZ)'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Done
echo "$(tput bold)$(tput setaf 2)✓ CLI installation done.$(tput sgr0)"