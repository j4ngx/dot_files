#!/bin/bash

# Install ZSH, lsd, and bat
sudo apt update
sudo apt install -y zsh lsd bat

# Verify ZSH installation
zsh --version

# Change the default shell to ZSH
chsh -s $(which zsh)

# Print the current shell to confirm the change (may still show the old shell until you log out and back in)
echo "Current shell: $SHELL"

# Install OH-MY-ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins for ZSH
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo ${ZSH_CUSTOM}/plugins/sudo

# Copy .zshrc to the home directory if it exists in the current directory
if [ -f ./zshrc ]; then
    cp ./zshrc ~/.zshrc
else
    echo ".zshrc file not found in the current directory."
fi

# Install PowerLevel10K theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

# Copy p10k.zsh configuration to the home directory if it exists in the current directory
if [ -f ./p10k.zsh ]; then
    cp ./p10k.zsh ~/.p10k.zsh
else
    echo "p10k.zsh file not found in the current directory."
fi

# Reload zsh configuration
source ~/.zshrc

# Create app-data directory and export variables to .zshrc
mkdir -p ~/app-data

# Append environment variables to .zshrc
echo 'export APP_DATA="$HOME/app-data"' >> ~/.zshrc
echo 'export MEDIA_FOLDER="/media/films"' >> ~/.zshrc

# Reload zshrc to apply the changes
source ~/.zshrc

echo "ZSH setup complete."

