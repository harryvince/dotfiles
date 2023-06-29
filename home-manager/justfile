clean:
    nix-store --gc

deepClean:
    nix-collect-garbage -d --delete-older-than 1d

build profile:
   nix run .#homeConfigurations.{{profile}}.activationPackage --impure

update:
    nix flake update

optimise:
    nix-store --optimise
