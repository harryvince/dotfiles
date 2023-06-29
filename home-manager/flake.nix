{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
        url = "github:lnl7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, darwin, ... }:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      home-manager = inputs.home-manager;
    in {
      homeConfigurations.shared = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./shared.nix ];
      };
      homeConfigurations.personal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./personal.nix ];
      };
      homeConfigurations.darwin = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.harryvince = import ./shared.nix;
            }
          ];
      };
    };
}
