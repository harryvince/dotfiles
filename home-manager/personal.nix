{ config, pkgs, ... }:
let
    shared_config = import ./shared.nix { inherit pkgs config; };
    tmux_conf = pkgs.fetchgit {
        rev = "master";
        sha256 = "1ds251q4s6s0y3hkmrvkgr9al0fzqh2ydl5v0zl3sic0gc2gzmah";
        url = "git@github.com:harryvince/personal.git";
    };
in
{
    home.file."background".source = ../2560x1440-Wallpaper-Free-Download-1.jpg;
    home.file."personal".source = tmux_conf;
    home.packages = import ./packages/personal.nix { inherit pkgs; };
    imports = [ shared_config ];
}
