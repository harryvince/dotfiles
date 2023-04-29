{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      home-manager = inputs.home-manager;
    in {
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;
      homeConfigurations.shared = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./shared.nix ];
      };
      homeConfigurations.personal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./personal.nix ];
      };
    };
}
