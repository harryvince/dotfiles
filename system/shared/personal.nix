{ pkgs }:

{
    home.packages = import ../shared/personal-packages.nix { inherit pkgs; };
    home.sessionVariables = {
        EDITOR = "nvim";
        PULUMI_SKIP_UPDATE_CHECK = "true";
    };
}
