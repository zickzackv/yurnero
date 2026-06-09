{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  users.users.fabian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    fastfetch
    _1password-cli
    git
    tig
    gitu
    kakoune
    curl
    tmux
    btop
    gron
    jq
    ripgrep
  ];

  services.qemuGuest.enable = false;
  programs.fish.enable = true;
  programs.fzf.fuzzyCompletion = true;
}
