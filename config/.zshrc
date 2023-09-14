export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    ssh-agent
    zsh-autosuggestions 
    zsh-syntax-highlighting 
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
alias vim="nvim"
alias lg="lazygit"

eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

# Sessionizer binding
bindkey -s ^f "~/bin/scripts/sessionizer\n"
