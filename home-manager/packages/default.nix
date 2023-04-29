{ pkgs, ... }:

with pkgs; [
    awscli2
    cargo
    fd
    gcc
    htop
    jq
    just
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Ubuntu" ]; })
    nodejs
    python3Full
    ripgrep
    rustc
    unzip
    wget
]
