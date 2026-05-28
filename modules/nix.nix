{...}:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimse.automatic = true;
  nix.gc.automatic = true;
}
