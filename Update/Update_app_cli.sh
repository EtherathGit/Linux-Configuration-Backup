#!/bin/bash

# Update OhMyZsh
echo 'Update Oh-my-zsh'
cd ~/.oh-my-zsh
git pull

# Update Powerlevel10k
echo 'Update powerlevel10k'
cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git pull

# Update plugins
echo 'Update zsh-z plugin'
cd ~/.oh-my-zsh/custom/plugins/zsh-z
git pull

echo 'Update zsh-autosuggestions plugin'
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git pull

echo 'Update zsh-syntax-highlighting plugin'
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git pull

# Relaod OhMyZsh
omz reload