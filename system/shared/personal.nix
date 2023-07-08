{ pkgs }:

{
    home.packages = import ../shared/personal-packages.nix { inherit pkgs; };
}
