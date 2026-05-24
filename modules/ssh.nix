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

  users.users.admin.openssh.authorizedKeys.keys = [
    # Exportiere deinen Public Key aus 1Password und ersetze diesen Platzhalter.
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI_REPLACE_THIS_WITH_YOUR_REAL_PUBLIC_KEY admin@server"
  ];
}
