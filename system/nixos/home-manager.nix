{ inputs, system, gitDetails, desktop, }:

{ pkgs, ... }:

let
    shared_config = import ../shared/home-manager.nix { inherit inputs system gitDetails desktop pkgs; };
    personal_config = import ../shared/personal.nix { inherit pkgs; };
in
{
    imports = [ shared_config personal_config ];

    programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
    };

    programs.go = {
        enable = true;
        goPath = "Development/language/go";
    };
}
