.PHONY: all brew brew-update asdf-plugins asdf-comp

all:
	stow zsh
	stow configs
	stow scripts

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle install

brew-update:
	rm Brewfile && brew bundle dump && mv Brewfile deps/Brewfile

asdf:
	cat deps/asdf-plugins.txt | xargs -L 1 asdf plugin add
	make asdf-comp

asdf-plugins:
	asdf plugin list > deps/asdf-plugins.txt

asdf-comp:
	mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
	asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
