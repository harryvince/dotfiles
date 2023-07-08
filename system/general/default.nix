{ inputs }:

{ system, desktop, shared, gitDetails, username }:

let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    home-manager-config = import ./home-manager.nix { inherit inputs system gitDetails username pkgs; };
    personal_config = import ../shared/personal.nix { inherit pkgs; };
    shared_config = import ../shared/home-manager.nix { inherit inputs system gitDetails pkgs desktop; };
in
inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = if shared then [
        home-manager-config
        shared_config
    ] else [
        home-manager-config
        personal_config
        shared_config
    ];

}
