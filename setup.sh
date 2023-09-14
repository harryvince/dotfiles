#!/usr/bin/env bash
mac=${1}

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git_username="Harry Vince"
git_email="harryavince@gmail.com"
system_packages=('ansible' 'awscli' 'zoxide' 'bat' 'fd' 'htop' 'fzf' 'fnm'
    'jq' 'just' 'ripgrep' 'unzip' 'wget' 'xclip' 'lazygit' 'tmux' 'neovim'
    'zsh-autosuggestions' 'zsh-syntax-highlighting')
package_string=""

concat_packages() {
    for package in "${system_packages[@]}"
    do
        package_string+="$package "
    done
    echo "Packages for install: $package_string"
}

prompt_sudo() {
    sudo -v
}

setup_homebrew() {
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.profile
    source ~/.profile
    echo "Homebrew setup."
}

linux_base() {
    echo "Installing ZSH and setting it to the default terminal."
    brew install zsh
    command -v zsh | sudo tee -a /etc/shells
    chsh -s $(which zsh)
}

setup_ohmyzsh() {
    echo "Setting up ohmyzsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

check_then_symlink() {
    location=${1}
    dir_to_link=${2}
    if [ -e "$location" ]; then
        cp -r $location "$link_destination.backup"
    fi
    ln -s $dir_to_link $location
}

setup_system() {
    concat_packages
    brew install $package_string
    echo "Setting git config."
    git config --global user.name "$git_username"
    git config --global user.email "$git_email"
    echo "Symlinking configs."
    check_then_symlink ~/.config/nvim $current_directory/config/nvim
    check_then_symlink ~/.tmux.conf $current_directory/config/.tmux.conf
    check_then_symlink ~/.zshrc $current_directory/config/.zshrc
    check_then_symlink ~/bin $current_directory/bin
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
