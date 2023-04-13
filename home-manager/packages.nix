{ pkgs, ... }:

with pkgs; [
    awscli2
    cargo
    gcc
    htop
    jq
    just
    lazygit
    nodejs
    python3Full
    ripgrep
    rustc
    unzip
    wget
    xclip
    zoxide
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Ubuntu" ]; })
]
