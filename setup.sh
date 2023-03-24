#!/bin/bash
# Setup base packages required for script
echo 'Setting up tools...'
packagesNeeded='curl jq tmux vim htop git ripgrep unzip'
if [ -x "$(command -v apt-get)" ]
then
    sudo apt-get install $packagesNeeded -y
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    sudo apt-get install zsh -y
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
    sudo apt install ./nvim-linux-64.deb
    rm nvim-linux64.deb
    # This is where the doppler setup begins - feel free to remove
    sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add -
    echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
    sudo apt-get update && sudo apt-get install doppler

elif [ -x "$(command -v brew)" ]
then
    brew install $packagesNeeded
    brew install jesseduffield/lazygit/lazygit
    brew install neovim
    # This is where the doppler setup begins - feel free to remove
    brew install gnupg
    brew install dopplerhq/cli/doppler
else
    echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi
fi

# Setup oh my zsh
echo "Installing oh my zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Neovim
cp -r nvim ~/.config/nvim
echo "Installing Packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir ~/pictures
cp ./2560x1440-Wallpaper-Free-Download-1.jpg ~/pictures/2560x1440-Wallpaper-Free-Download-1.jpg

echo "Running Packer..."
mkdir $HOME/.config/nvim/plugin
nvim +PackerSync

# Setup cht.sh
cp -r ./bin ~/bin

echo "Script Finished."
echo "Make sure to source your .zshrc\nIf using doppler make sure to grab your required secrets"
