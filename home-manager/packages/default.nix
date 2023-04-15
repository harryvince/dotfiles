{ pkgs, ... }:

with pkgs; [
    awscli2
    cargo
    fd
    fzf
    gcc
    htop
    jq
    just
    nodejs
    python3Full
    ripgrep
    rustc
    unzip
    wget
    zoxide
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Ubuntu" ]; })
]
