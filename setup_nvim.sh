#!/bin/bash

if ! command -v <nvim> &> /dev/null
then
    echo "Neovim must be installed before setup"
    exit
fi

echo "Installing Packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Running Packer..."
mkdir $HOME/.config/nvim/plugin
nvim +PackerSync

echo "Script Finished."
echo "Make sure to install lazygit & ripgrep for the neovim setup to run"
