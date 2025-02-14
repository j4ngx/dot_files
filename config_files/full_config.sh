#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Install ZSH, lsd, and bat
sudo apt install -y zsh lsd bat curl

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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true


ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo ${ZSH_CUSTOM}/plugins/sudo

git clone https://github.com/heapbytes/heapbytes-zsh $ZSH_CUSTOM/themes/heapbytes
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="heapbytes"/g' ~/.zshrc
cp -r ./heapbytes $ZSH_CUSTOM/themes/heapbytes/heapbytes.zsh-theme

mkdir -p $HOME/app-data

