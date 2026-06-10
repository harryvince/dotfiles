.PHONY: setup brew brew-update

setup:
	stow --adopt .
	git reset --hard

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	cp deps/Brewfile ./Brewfile
	brew bundle install
	rm ./Brewfile

brew-update:
	brew bundle dump
