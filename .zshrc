export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# copy files to clipboard
alias xclip="xclip -selection c"

# lets rebind vim to neovim because of muscle memory
alias vim="nvim"

# Sessionizer binding
bindkey -s ^f "~/bin/scripts/sessionizer\n"
# SSM binding
bindkey -s ^s "~/bin/scripts/ssm\n"
bindkey -s ^S "~/bin/scripts/ssm --list-ids\n"

# Start Zoxide
Zruncount=$(ps -ef | grep "zoxide" | grep -v "grep" | wc -l)
if [ $runcount -eq 0 ]; then
    echo Starting Zoxide
    eval "$(zoxide init zsh)"
fi
