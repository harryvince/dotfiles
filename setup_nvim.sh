#!/bin/bash

echo "Installing Packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Running Packer..."
mkdir $HOME/.config/nvim/plugin
nvim +PackerSync

echo "Script Finished."
