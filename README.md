# dotfiles

This is my collection of dotfiles. Wether it works for you or not, I'm not sure.

## Installation

So I now manage my dotfiles with [chezmoi](https://github.com/twpayne/chezmoi).

Will probs still need to clone this repo somewhere, but I'm not sure.

```sh
git clone https://github.com/harryvince/dotfiles.git ~/.dotfiles
```

## Usage

```sh
make brew # or just install mise with brew
set -o vi
```

`chezmoi init --apply harryvince`
