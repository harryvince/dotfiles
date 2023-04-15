{ config, pkgs, ... }:
let
    shared_config = import ./shared.nix { inherit pkgs config; };
in
{
    home.file."background".source = ../2560x1440-Wallpaper-Free-Download-1.jpg;
    home.packages = import ./packages/personal.nix { inherit pkgs; };
    imports = [ shared_config ];
}
