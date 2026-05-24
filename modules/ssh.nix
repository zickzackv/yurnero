{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.fabian.openssh.authorizedKeys.keys = [
    # Exportiere deinen Public Key aus 1Password und ersetze diesen Platzhalter.
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKnhG9cVWWKezu+IUcLkNbhsKFA87F226zTXgS7QlCMJ fabian@traxex"
  ];
}
