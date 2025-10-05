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
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
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
alias -- python=python3
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

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /opt/homebrew/bin/mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command /opt/homebrew/bin/mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command /opt/homebrew/bin/mise "$command" "$@"
}

_mise_hook() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    # preserve existing handler if present
    if typeset -f command_not_found_handler >/dev/null; then
        functions -c command_not_found_handler _command_not_found_handler
    fi

    typeset -gA _mise_cnf_tried

    # helper for fallback behavior
    _mise_fallback() {
        local _cmd="$1"; shift
        if typeset -f _command_not_found_handler >/dev/null; then
            _command_not_found_handler "$_cmd" "$@"
            return $?
        else
            print -u2 -- "zsh: command not found: $_cmd"
            return 127
        fi
    }

    command_not_found_handler() {
        local cmd="$1"; shift

        # never intercept mise itself or retry already-attempted commands
        if [[ "$cmd" == "mise" || "$cmd" == mise-* || -n "${_mise_cnf_tried["$cmd"]}" ]]; then
            _mise_fallback "$cmd" "$@"
            return $?
        fi

        # run the hook; only retry if the command is actually found afterward
        if /opt/homebrew/bin/mise hook-not-found -s zsh -- "$cmd"; then
            _mise_hook
            if command -v -- "$cmd" >/dev/null 2>&1; then
                "$cmd" "$@"
                return $?
            fi
        else
            # only mark as tried if mise explicitly can't handle it
            _mise_cnf_tried["$cmd"]=1
        fi

        # fall back
        _mise_fallback "$cmd" "$@"
    }
fi

# Prompt has to be last
eval "$(starship init zsh)"
