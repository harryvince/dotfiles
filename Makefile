.PHONY: all brew brew-update asdf-plugins asdf-comp

all:
	stow zsh
	stow configs
	stow scripts

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	cp deps/Brewfile ./Brewfile
	brew bundle install
	rm ./Brewfile

brew-update:
	brew bundle dump && mv Brewfile deps/Brewfile
