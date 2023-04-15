{ config, pkgs, ... }:
let
    shared_config = import ./shared.nix { inherit pkgs config; };
    private_config = pkgs.fetchgit {
        rev = "master";
        sha256 = "1ds251q4s6s0y3hkmrvkgr9al0fzqh2ydl5v0zl3sic0gc2gzmah";
        url = "git@github.com:harryvince/personal.git";
    };
in
{
    home.file."background".source = ../2560x1440-Wallpaper-Free-Download-1.jpg;
    home.file.".tmux-personal.conf".source = private_config + /.configs/.tmux-personal.conf;
    home.packages = import ./packages/personal.nix { inherit pkgs; };
    imports = [ shared_config ];
}
