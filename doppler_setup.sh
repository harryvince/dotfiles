#!/bin/bash
# Setup base packages required for script
echo 'Setting up doppler.'
if [ -x "$(command -v apt-get)" ]
then
    sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add -
    echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
    sudo apt-get update && sudo apt-get install doppler

elif [ -x "$(command -v brew)" ]
then
    brew install gnupg
    brew install dopplerhq/cli/doppler
else
    echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi
fi

doppler login
doppler setup
