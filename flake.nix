{
  description = "NixOS server on /dev/sda with disko, systemd-boot and SSH";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05-small";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    yurneroAddr = "D0:17:C2:93:B3:B5";
  in {
    apps.${system}.wakonlan = {
      type = "app";
      program = "${(pkgs.writeShellApplication {
        name = "wakonlan";
        runtimeInputs = [pkgs.wakeonlan];
        text = ''
          exec wakeonlan ${yurneroAddr}
        '';
      })}/bin/wakonlan";
    };

    nixosConfigurations.yurnero = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit self;};
      modules = [
        disko.nixosModules.disko
        ./hosts/yurnero/configuration.nix
      ];
    };
  };
}
