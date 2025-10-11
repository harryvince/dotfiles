typeset -U path cdpath fpath manpath

# Plugin management
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

ZSH_AUTOSUGGEST_STRATEGY=(history)

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Setup Completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C 'aws_completer' aws

# Setup History
HISTSIZE="100000"
SAVEHIST="100000"

HISTFILE="/Users/${USER}/.config/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/bin"
export PATH="/Users/harry/.bun/bin:$PATH"

source <(fzf --zsh)

# oh-my-zsh aliases
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus


alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Aliases
alias -- brew-update='brew update && brew upgrade && brew autoremove && brew cleanup -s && brew cleanup --prune=all'
alias -- ldo=lazydocker
alias -- lg=lazygit
alias -- m='. $HOME/bin/mono'
alias -- n="nnn -H -U"
alias -- vim=nvim
alias -- vi=nvim
alias -- pip=pip3
alias -- pc=process-compose
alias -- rp="pinggy -p 443 -R0:localhost:3000 -o StrictHostKeyChecking=no -o ServerAliveInterval=30 $PINGGY_TOKEN+force@eu.pro.pinggy.io"
alias -- av=ansible-vault

# Allow for editing of current cmd
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Option left and right
bindkey "^[f" forward-word
bindkey "^[b" backward-word

bindkey -s "^n" "n\n"

eval "$(mise activate)"
eval "$(brew shellenv)"

# Prompt has to be last
eval "$(starship init zsh)"
