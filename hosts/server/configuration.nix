{ config, lib, pkgs, self, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/ssh.nix
  ];

  networking.hostName = "server";

  system.stateVersion = "25.05";
}
