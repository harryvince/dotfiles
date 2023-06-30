# My Dotfiles

This is collection of configuration files and scripts that I use to customize my development environment.

## Usage
These dotfiles are intended to be used with a Unix-like operating system, such as macOS or Linux.
To use them, simply clone the repository to a directory and run the setup.sh script:
```
git clone https://github.com/harryvince/dotfiles.git
cd dotfiles
sh <(curl -L https://nixos.org/nix/install) --daemon
NIXPKGS_ALLOW_UNFREE=1 nix run .#homeConfigurations.shared.activationPackage --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
The setup script handles most of the installs and setups required for your environment, effectively replacing the default configs with
these new ones.

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
