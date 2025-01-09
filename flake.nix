{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
      nixosConfigurations.laptop = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ ./hosts/laptop/configuration.nix ];
      };
      nixosConfigurations.old_laptop = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ ./hosts/old_laptop/configuration.nix ];
      };
  };
}
