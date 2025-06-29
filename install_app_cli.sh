#!bin/bash

# Define Backup Folder
BACKUP_DIR=~/.FedoraConfiguration/BackupFiles

# Install Zsh
echo 'Install Zsh'
sudo apt install zsh -y

# Install OhMyZsh
echo 'Install OhMyZsh (OMZ)'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download fonts
echo 'Download fonts'
mkdir -p ~/.fonts && cd ~/.fonts
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Install fonts
echo 'Install fonts'
command fc-cache || sudo apt install fontconfig -y
fc-cache -f -v

# Download Powerlevel10k
echo 'Download Powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Download plugins
echo 'Download zsh-z plugin'
git clone https://github.com/agkozak/zsh-z.git $ZSH_CUSTOM/plugins/zsh-z
echo 'Download zsh-autosuggestions plugin'
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo 'Download zsh-syntax-highlighting plugin'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Import custom plugins
echo 'Install custom Updates plugin'
cp -r "$BACKUP_DIR/.oh-my-zsh/custom/updates/" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/"

# Enable Powerlevel10k
echo 'Set OMZ theme to Powerlevel10k'
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc

# Enable plugins
echo 'Enable OMZ plugins'
sed -i 's|^plugins=.*|plugins=(git zsh-z zsh-autosuggestions zsh-syntax-highlighting updates)|g' ~/.zshrc