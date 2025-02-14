#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Install ZSH, lsd, and bat
sudo apt install -y zsh lsd bat

zsh --version

chsh -s $(which zsh)

if [ $SHELL == "/bin/zsh" ]; then
    echo "ZSH is already the default shell."
else
    echo "ZSH is not the default shell. Changing it now..."
    chsh -s $(which zsh)
    echo "Default shell changed to ZSH."
fi

# Install OH-MY-ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
