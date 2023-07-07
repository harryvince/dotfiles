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
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in {
      homeConfigurations.shared = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./config/nix/shared.nix ];
      };

      homeConfigurations.personal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./config/nix/personal.nix ];
      };

      homeConfigurations.darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./config/nix/personal.nix ];
      };
    };
}
