.PHONY: all brew brew-install

all:
	stow zsh
	stow configs
	stow scripts

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle install

brew-update:
	rm Brewfile && brew bundle dump
