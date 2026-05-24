{ config, lib, pkgs, self, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/ssh.nix
  ];

  networking.hostName = "yurnero";

  system.stateVersion = "25.05";
}
