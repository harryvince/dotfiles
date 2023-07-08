# My Dotfiles

This is collection of configuration files and scripts that I use to customize my development environment.

## Usage
These dotfiles are intended to be used with a Unix-like operating system, such as macOS or Linux.
To use them, simply run the following:
```
git clone https://github.com/harryvince/dotfiles.git
cd dotfiles
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch --flake ".#shared-linux" --impure
```
The setup handles installs and setups required for your environment, effectively replacing the default configs with
these new ones.

If attempting to use the NixOS configuration it is reccomended to read up on the operating
system or at least have a couple months experience with the nix package manager first.

Before running the script, you may want to review the configuration files and remove any customizations that you do not want to use.

## Contents
This repository contains configuration files for the following:
- zsh
- neovim
- vim
- tmux
- i3
- nix

## Customization
Feel free to customize these dotfiles to suit your needs. If you make any improvements or additions that you think others might
find useful, please do submit a pull request.

## Moonlander MK1 Layout
https://configure.zsa.io/moonlander/layouts/9RooK/latest/0
