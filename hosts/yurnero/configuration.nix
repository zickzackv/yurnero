{ config, lib, pkgs, self, ... }:
{
  system.stateVersion = "25.05";
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/ssh.nix
    ../../modules/nix.nix
    ./disko.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "data" ];

  networking.hostName = "yurnero";
  networking.useNetworkd = true;
  networking.hostId = "dc12e630";
  systemd.network.enable = true;
  services.resolved.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";

  environment.enableAllTerminfo = true; 
}
