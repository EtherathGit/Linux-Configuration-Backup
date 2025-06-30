#!/bin/bash

# Define the error handler
on_error() {
  echo "$(tput bold)❌ Error occurred while $CURRENT$(tput sgr0)"
  exit 1
}

# Register the trap
trap on_error ERR

# Update Oh-My-Zsh
CURRENT="updating Oh-my-zsh"
echo "$(tput bold)==> Updating Oh-my-zsh ...$(tput sgr0)"
cd "$HOME/.oh-my-zsh"
git pull

# Update Powerlevel10k
CURRENT="updating Powerlevel10k"
echo "$(tput bold)==> Updating Powerlevel10k ...$(tput sgr0)"
cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git pull

# Update plugins
CURRENT="updating zsh-z plugin"
echo "$(tput bold)==> Updating zsh-z plugin ...$(tput sgr0)"
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z
git pull

CURRENT="updating zsh-autosuggestions plugin"
echo "$(tput bold)==> Updating zsh-autosuggestions plugin ...$(tput sgr0)"
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git pull

CURRENT="updating zsh-syntax-highlighting plugin"
echo "$(tput bold)==> Updating zsh-syntax-highlighting plugin ...$(tput sgr0)"
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git pull

# Relaod OhMyZsh
CURRENT="reloading Oh-my-zsh"
echo "$(tput bold)==> Reloading Oh-my-zsh ...$(tput sgr0)"
omz reload

# Done
echo "$(tput bold)$(tput setaf 2)✓ Updates done.$(tput sgr0)"