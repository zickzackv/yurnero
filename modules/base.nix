{ pkgs, ... }:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  networking.useNetworkd = true;
  systemd.network.enable = true;

  services.resolved.enable = true;

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bashInteractive;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    helix
    curl
    wget
    tmux
  ];

  services.qemuGuest.enable = false;
}
