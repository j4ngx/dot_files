#!/bin/bash

# Install ZSH 
sudo apt install -y zsh lsd bat
zhs --version

# Change SHELL
chsh -s $(which zsh)

echo $SHELL

#Install OH-MY-ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins for zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo ${ZSH_CUSTOM}/plugins/sudo

# Copy .zshrc to home directory
cp zshrc ~/.zshrc

# Install PowerLevel10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

cp p10k.zsh ~/.p10k.zsh

# Reload zshrc configuration
source ~/.zshrc

# Export variables to zshrc
mkdir -p ~/app-data

echo 'export APP_DATA="$HOME/app-data"' >> ~/.zshrc
echo 'export MEDIA_FOLDER="/media/films"' >> ~/.zshrc


