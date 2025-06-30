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
echo "$(tput bold)==> Starting CLI installation...$(tput sgr0)"

# Install Zsh
CURRENT="instaling Zsh"
echo 'Install Zsh'
sudo dnf install zsh -y

# Install Oh-My-Zsh
CURRENT="instaling OMZ"
echo 'Install Oh-My-Zsh (OMZ)'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download fonts
CURRENT="downloading fonts"
echo 'Download fonts'
mkdir -p ~/.fonts && cd ~/.fonts
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Install fonts
CURRENT="installing fonts"
echo 'Install fonts'
command fc-cache || sudo dnf install fontconfig -y
fc-cache -f -v

# Download Powerlevel10k
CURRENT="downloading Powerlevel10k"
echo 'Download Powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Download plugins
CURRENT="donwloading plugin zsh-z"
echo 'Download zsh-z plugin'
git clone https://github.com/agkozak/zsh-z.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z
CURRENT="donwloading plugin zsh-autosuggestions"
echo 'Download zsh-autosuggestions plugin'
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
CURRENT="donwloading plugin zsh-syntax-highlighting"
echo 'Download zsh-syntax-highlighting plugin'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
CURRENT="donwloading plugin zsh-updates"
echo 'Download Updates plugin'
git clone https://github.com/EtherathGit/zsh-updates.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}//plugins/zsh-updates

# Enable Powerlevel10k
CURRENT="setting Powerlevel10k as theme"
echo 'Set OMZ theme to Powerlevel10k'
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc

# Enable plugins
CURRENT="enabling all plugins"
echo 'Enable OMZ plugins'
sed -i 's|^plugins=.*|plugins=(git zsh-z zsh-autosuggestions zsh-syntax-highlighting zsh-updates)|g' ~/.zshrc

# Done
echo "$(tput bold)$(tput setaf 2)✓ CLI installation done.$(tput sgr0)"