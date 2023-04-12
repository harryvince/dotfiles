{ config, pkgs, ... }:

{
    home = {
        username = "harry";
        homeDirectory = "/home/harry";
        stateVersion = "22.11";
        packages = import ./packages.nix { inherit pkgs; };
    };

    programs.home-manager = {
        enable = true;
    };
}
