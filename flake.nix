{
  description = "NixOS server on /dev/sda with disko, systemd-boot and SSH";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          disko.nixosModules.disko
          ./hosts/server/configuration.nix
          ./hosts/server/disko.nix
        ];
      };
    };
}
