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
    nodejs
    nodePackages.pnpm
    postman
    python3Full
    ripgrep
    rustc
    unzip
    wget
]
