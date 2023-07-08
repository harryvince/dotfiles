{ inputs }:

{ system, username, gitDetails, desktop }:

let
    hardware-configuration = import /etc/nixos/hardware-configuration.nix;
    configuration = import ./configuration.nix { inherit username; };
in
inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
        hardware-configuration
        configuration

        inputs.home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = import ./home-manager.nix {
                inherit inputs system gitDetails desktop;
            };
        }
    ];
}
