{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ home-manager, ... }:
    let
      system = (builtins.fromJSON (builtins.readFile ./config/nix/config.json)).system.architecture;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.shared = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./config/nix/shared.nix ];
      };

      homeConfigurations.personal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./config/nix/personal.nix ];
      };
    };
}
