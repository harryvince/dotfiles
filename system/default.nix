{ inputs }: {
    mkNixOS = import ./nixos { inherit inputs; };
    mkGeneral = import ./general { inherit inputs; };
}
