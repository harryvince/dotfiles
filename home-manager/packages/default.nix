{ pkgs, ... }:

with pkgs; [
    awscli2
    bat
    cargo
    fd
    gcc
    htop
    jq
    just
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Ubuntu" ]; })
    nodejs
    postman
    python3Full
    ripgrep
    rustc
    unzip
    wget
]