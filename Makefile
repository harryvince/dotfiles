.PHONY: all brew-update brew-install

all:
	stow zsh
	stow configs

brew-update:
	rm Brewfile && brew bundle dump

brew-install:
	brew bundle install
