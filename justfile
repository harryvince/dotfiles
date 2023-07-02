clean:
    nix-store --gc

deepClean:
    nix-collect-garbage -d --delete-older-than 1d

build profile:
   home-manager switch --flake ".#{{profile}}" --impure

update:
    nix flake update

optimise:
    nix-store --optimise
