.PHONY: all brew brew-update asdf-plugins asdf-comp

all:
	stow zsh
	stow configs
	stow scripts

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle install

brew-update:
	rm Brewfile && brew bundle dump

asdf-plugins:
	asdf plugin add nodejs
	asdf plugin add bun
	asdf plugin add terraform

asdf-comp:
	mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
	asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
