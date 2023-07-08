{ inputs, system, gitDetails, username, pkgs }:

let 
    homedir = if system == "aarch64-darwin" then "Users" else "home";
in
{
    home = {
        username = username;
        homeDirectory = "/${homedir}/${username}";

        file = {
            ".config/nix/nix.conf".source = ../../config/nix/nix.conf;
        };

    };

    programs.home-manager.enable = true;

    nixpkgs = {
        config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
        };
    };
}
