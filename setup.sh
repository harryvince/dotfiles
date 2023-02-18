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
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo y | ~/.fzf/install
echo 'Tool Setup Finished'
echo 'Please ensure to source your rc file for fzf to work correctly'
