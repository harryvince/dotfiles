#!/bin/bash
# Setup packages required for script
echo 'Setting up tools...'
packagesNeeded='curl jq tmux vim htop git'
if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded -y
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded -y
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded -y
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded -y
elif [ -x "$(command -v yum)" ]; then sudo yum install $packagesNeeded -y
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi
cat > ~/.tmux.conf <<'EOE'
# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
# vim keys to move panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

set-option -g set-titles on

# Set vim bindings
set-window-option -g mode-keys vi

# Colours
set -g status-fg green
set -g status-bg black
EOE
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo y | ~/.fzf/install
echo "export LS_COLORS=$LS_COLORS: 'ow=1;34:';" >> ~/.bashrc
echo "export LS_COLORS=$LS_COLORS: 'ow=1;34:';" >> ~/.zshrc
echo 'Tool Setup Finished'
echo 'Please ensure to source your rc file for fzf to work correctly'
