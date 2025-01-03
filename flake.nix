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
      nixosConfigurations.default = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ ./configuration.nix ];
      };
  };
}
