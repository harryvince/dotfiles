{
  description = "My Development Environment in NixOS";

  inputs = {
      home-manager = {
          inputs.nixpkgs.follows = "nixpkgs";
          url = "github:nix-community/home-manager";
      };
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, self, ...}: 
      let 
        systems = import ./system { inherit inputs; };
        gitDetails = {
            username = "Harry Vince";
            email = "harryavince@gmail.com";
        };
        username = "harry";
      in
      flake-parts.lib.mkFlake { inherit inputs; } {
          systems = [ "x86_64-linux" "aarch64-darwin" ];
          perSystem = { config, self', inputs', pkgs, system, ... }: {
              packages = {
                  my-nvim = pkgs.vimUtils.buildVimPlugin {
                      name = "harrynvim";
                      src = ./config/nvim;
                  };
              };
          };

          flake = {

              nixosConfigurations = {
                  nixos = systems.mkNixOS {
                      inherit gitDetails username;
                      system = "x86_64-linux";
                      desktop = true;
                  };
              };

              homeConfigurations = {
                  personal-linux = systems.mkGeneral {
                      inherit gitDetails username;
                      system = "x86_64-linux";
                      desktop = true;
                      shared = false;
                  };
                  personal-darwin = systems.mkGeneral {
                      inherit gitDetails;
                      system = "aarch64-darwin";
                      username = "harryvince";
                      desktop = false;
                      shared = false;
                  };
                  shared-linux = systems.mkGeneral {
                      inherit gitDetails username;
                      system = "x86_64-linux";
                      desktop = false;
                      shared = true;
                  };
                  shared-darwin = systems.mkGeneral {
                      inherit gitDetails username;
                      system = "aarch64-darwin";
                      desktop = false;
                      shared = true;
                  };
              };

          };

      };
}
