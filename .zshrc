export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# copy files to clipboard
alias xclip="xclip -selection c"

# lets rebind vim to neovim because of muscle memory
alias vim="nvim"
