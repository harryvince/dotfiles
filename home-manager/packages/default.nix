{ pkgs, ... }:

with pkgs; [
    ansible
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
    xclip
    zoxide
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Ubuntu" ]; })
]
