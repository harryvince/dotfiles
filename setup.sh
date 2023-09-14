#!/usr/bin/env bash
mac=${1}

system_packages=('ansible' 'awscli2' 'zoxide' 'bat' 'fd' 'htop'
    'jq' 'just' 'ripgrep' 'unzip' 'wget' 'xclip' 'lazygit' 'tmux' 'neovim')
package_string=""

concat_packages() {
    for package in "${system_packages[@]}"
    do
        package_string+="$package "
    done
    echo "Packages for install: $package_string"
}

prompt_sudo() {
    if [ $EUID != 0 ]; then
        sudo "$0" "$@"
        exit $?
    fi
}

setup_homebrew() {
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew setup."
}

linux_base() {
    brew install zsh
    chsh -s $(which zsh)
}

setup_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_system() {
    concat_packages
    brew install $package_string
    git config --global user.name "Harry Vince"
    ln -s config/nvim ~/.config/nvim
    ln -s config/.tmux.conf ~/.tmux.conf
}

echo "Just prompting for sudo to enable a seamless setup."
prompt_sudo

setup_homebrew

if [ -n "$mac" ]; then
    echo 'Passed option for mac, not setting up zsh...'
else
    echo 'No option passed, setting up basic linux dependencies'
    linux_base
fi

setup_ohmyzsh
setup_system
